/**
 * Popover component - controlled variant.
 *
 * The controlled `Popover` keeps EBD's open state slaved to `@isOpen` and only
 * **reports** dismissal intents via `onClickOutside`/`onEsc` without mutating
 * state itself. If `@isOpen` is undefined, it is treated as closed.
 *
 * Yields a control hash `{ isOpen, open, close, toggle, anchor }` to `<:trigger>`
 * and `{ close }` to `<:content>`.
 *
 * Usage:
 * ```gts
 * <Popover @isOpen={{this.isOpen}} @onClickOutside={{this.handleOutside}} @onEsc={{this.handleEsc}}>
 *   <:trigger as |pop|>
 *     <button {{pop.anchor}}>Toggle</button>
 *   </:trigger>
 *   <:content as |pop|>
 *     Content here.
 *     <button {{on "click" pop.close}}>Close</button>
 *   </:content>
 * </Popover>
 * ```
 */
import bstRef from "#src/modifiers/bst-ref.ts";
import { htmlSafe } from "@ember/template";
import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import * as stylex from "@stylexjs/stylex";
import BasicDropdown from "ember-basic-dropdown/components/basic-dropdown";
import { modifier } from "ember-modifier";
import { generateId, trapFocus } from "../../a11y/index";
import { resolveOverride } from "../../helpers/overrides";
import { createAnchorModifier } from "./anchor";
import { mapPlacement } from "./placement";
import { styles } from "./styles.stylex";
import {
  ACCESSIBILITY_TYPE,
  PLACEMENT,
  TRIGGER_TYPE,
  type AccessibilityType,
  type PopoverOverrides,
  type PopoverPlacement,
  type PopoverSignature,
  type StatefulPopoverSignature,
  type TriggerType,
} from "./types";

// Re-export types and constants
export {
  ACCESSIBILITY_TYPE, PLACEMENT, TRIGGER_TYPE, type AccessibilityType, type PopoverOverrides, type PopoverPlacement, type PopoverSignature,
  type StatefulPopoverSignature, type TriggerType
};

// ─── Arrow constants ────────────────────────────────────────────────────────────

const ARROW_WIDTH = 9;

// ─── Helpers ────────────────────────────────────────────────────────────────────

interface DropdownAPI {
	isOpen: boolean;
	actions: {
		open: () => void;
		close: () => void;
		toggle: () => void;
		reposition: () => void;
	};
}

// ─── Controlled Popover ─────────────────────────────────────────────────────────

/**
 * Controlled Popover component.
 *
 * The external `@isOpen` arg is the source of truth. EBD's open state is kept
 * in sync by:
 * - Using `@initiallyOpened` set to `@isOpen` for initial render
 * - Intercepting `@onClose` to prevent EBD from auto-closing (returns `false`)
 * - Using `@onOpen` to prevent EBD from auto-opening (returns `false`)
 * - Conditionally rendering `<dd.Content>` only when `@isOpen` is true
 *
 * Dismissal intents (outside click, Escape) are surfaced via `onClickOutside`
 * and `onEsc` handlers exactly once. When a handler is absent, the content
 * stays rendered (no state change).
 */
export class Popover extends Component<PopoverSignature> {
	private readonly contentId = generateId("popover-content");
	private previouslyFocused: HTMLElement | null = null;
	private cleanupFocusTrap: (() => void) | null = null;
	private contentEl: HTMLElement | null = null;

	/** The captured trigger element (used to distinguish trigger clicks from
	 *  genuine outside clicks). */
	private triggerEl: HTMLElement | null = null;

	/** True while we are programmatically syncing EBD's open state to `@isOpen`.
	 *  Lets `handleOpen`/`handleClose` allow our own actions while blocking
	 *  user/trigger-initiated state changes (consumer owns the state). */
	private _syncing = false;

	captureTrigger = (el: HTMLElement | null): void => {
		this.triggerEl = el;
	};

	/**
	 * Drives EBD's open state from the controlled `@isOpen` argument.
	 *
	 * EBD is internally uncontrolled and gates `<dd.Content>` on its own
	 * `dd.isOpen`. To make `@isOpen` authoritative we open/close EBD
	 * programmatically (wrapped in the `_syncing` flag so the `onOpen`/`onClose`
	 * interceptors allow it) whenever `@isOpen` and `dd.isOpen` diverge.
	 *
	 * The work is deferred to a microtask to avoid mutating EBD's tracked state
	 * during render (which would trigger a backtracking-rerender assertion).
	 */
	syncOpenState = modifier(
		(_el: Element, [dd, isOpen]: [DropdownAPI, boolean]) => {
			Promise.resolve().then(() => {
				if (this.isDestroying || this.isDestroyed) return;
				if (isOpen && !dd.isOpen) {
					this._syncing = true;
					dd.actions.open();
					this._syncing = false;
				} else if (!isOpen && dd.isOpen) {
					this._syncing = true;
					dd.actions.close();
					this._syncing = false;
				}
			});
		},
	);

	// ─── Open state ───────────────────────────────────────────────────────────

	get isOpen(): boolean {
		return this.args.isOpen ?? false;
	}

	// ─── Placement ────────────────────────────────────────────────────────────

	get placement(): PopoverPlacement {
		return this.args.placement ?? "auto";
	}

	get resolvedPlacement() {
		return mapPlacement(this.placement);
	}

	get verticalPosition() {
		return this.resolvedPlacement.vertical;
	}

	get horizontalPosition() {
		return this.resolvedPlacement.horizontal;
	}

	// ─── Destination (mountNode) ──────────────────────────────────────────────

	get destination(): string {
		if (this.args.mountNode) {
			if (!this.args.mountNode.id) {
				this.args.mountNode.id = generateId("popover-dest");
			}
			return this.args.mountNode.id;
		}
		// Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
	}

	// ─── Margin ───────────────────────────────────────────────────────────────

	get popoverMargin(): number {
		return Math.max(0, Math.round(this.args.popoverMargin ?? 8));
	}

	get marginStyle(): string {
		const margin = this.popoverMargin;
		if (margin === 0) return htmlSafe("").toString();

		const placement = this.placement;

		if (placement.startsWith("left")) {
			return htmlSafe(`margin-right: ${margin}px`).toString();
		}
		if (placement.startsWith("right")) {
			return htmlSafe(`margin-left: ${margin}px`).toString();
		}

		const { vertical } = this.resolvedPlacement;
		if (vertical === "above") {
			return htmlSafe(`margin-bottom: ${margin}px`).toString();
		}
		return htmlSafe(`margin-top: ${margin}px`).toString();
	}

	// ─── Delays ───────────────────────────────────────────────────────────────

	get onMouseEnterDelay(): number {
		return Math.max(0, Math.round(this.args.onMouseEnterDelay ?? 200));
	}

	get onMouseLeaveDelay(): number {
		return Math.max(0, Math.round(this.args.onMouseLeaveDelay ?? 200));
	}

	// ─── Trigger type / accessibility type ────────────────────────────────────

	get triggerType(): TriggerType {
		return this.args.triggerType ?? "click";
	}

	get accessibilityType(): AccessibilityType {
		return this.args.accessibilityType ?? "menu";
	}

	// ─── Content ARIA ─────────────────────────────────────────────────────────

	get contentRole(): string | undefined {
		if (this.accessibilityType === "tooltip") return "tooltip";
		// Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
	}

	get contentAriaId(): string | undefined {
		if (this.accessibilityType === "none") // Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
		return this.contentId;
	}

	// ─── Arrow / Body / Inner ─────────────────────────────────────────────────

	get showArrow(): boolean {
		return this.args.showArrow ?? false;
	}

	get bodyClassName(): string | undefined {
		const resolved = resolveOverride(styles.body, this.args.overrides, "Body");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get innerClassName(): string | undefined {
		const resolved = resolveOverride(styles.inner, this.args.overrides, "Inner");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get arrowClassName(): string | undefined {
		const resolved = resolveOverride(styles.arrow, this.args.overrides, "Arrow");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get arrowPositionStyle(): string {
		const placement = this.placement;
		const offset = ARROW_WIDTH / 2;

		if (placement.startsWith("left")) {
			return htmlSafe(`right: -${offset}px; top: calc(50% - ${offset}px)`).toString();
		}
		if (placement.startsWith("right")) {
			return htmlSafe(`left: -${offset}px; top: calc(50% - ${offset}px)`).toString();
		}

		const { vertical } = this.resolvedPlacement;
		if (vertical === "above") {
			return htmlSafe(`bottom: -${offset}px; left: calc(50% - ${offset}px)`).toString();
		}
		// below, auto, or default
		return htmlSafe(`top: -${offset}px; left: calc(50% - ${offset}px)`).toString();
	}

	// ─── Actions (yielded to consumer) ────────────────────────────────────────

	/**
	 * The `open` action surfaces the intent to open. In controlled mode,
	 * the consumer must set `@isOpen` to true - this is just a callback
	 * the consumer can wire up.
	 */
	open = (): void => {
		// In controlled mode, this is a no-op internally.
		// The consumer decides whether to set @isOpen = true.
		// However, we can call onClickOutside's complement - there's nothing
		// to call for "open" in the controlled API, so this is just a yielded action.
	};

	/**
	 * The `close` action surfaces the intent to close. In controlled mode,
	 * the consumer must set `@isOpen` to false.
	 */
	close = (): void => {
		// In controlled mode, this is a no-op internally.
		// The consumer decides whether to set @isOpen = false.
	};

	/**
	 * Toggle opens when closed and closes when open (Req 6.4).
	 */
	toggle = (): void => {
		if (this.isOpen) {
			this.close();
		} else {
			this.open();
		}
	};

	// ─── Anchor modifier factory ──────────────────────────────────────────────

	get anchorModifier() {
		return createAnchorModifier({
			isOpen: this.isOpen,
			triggerType: this.triggerType,
			accessibilityType: this.accessibilityType,
			contentId: this.contentId,
			toggle: this.toggle,
			open: this.open,
			close: this.close,
			onMouseEnterDelay: this.onMouseEnterDelay,
			onMouseLeaveDelay: this.onMouseLeaveDelay,
			onTriggerElementCapture: this.captureTrigger,
		});
	}

	// ─── EBD event interception ───────────────────────────────────────────────

	/**
	 * Intercepts EBD's close attempts. In controlled mode, we NEVER allow EBD
	 * to close on its own - we return `false` to prevent the close.
	 *
	 * Instead, we surface the dismissal intent to the consumer:
	 * - Escape key → call `onEsc` (if provided)
	 * - Outside click → call `onClickOutside` (if provided)
	 *
	 * When a handler is absent, we still return `false` so EBD doesn't auto-close,
	 * keeping content rendered (Req 6.12).
	 */
	/**
	 * Intercepts EBD's close attempts.
	 *
	 * - When `_syncing` is true the close came from our own `@isOpen` sync, so we
	 *   allow it (return undefined).
	 * - Otherwise it is user-initiated (Escape, outside click, or a trigger
	 *   click). We never let EBD change state on its own in controlled mode;
	 *   instead we surface the dismissal intent and return `false` so the
	 *   consumer remains the single source of truth via `@isOpen`.
	 *   Clicks that originate from the trigger element are not reported as
	 *   outside clicks (the consumer's own trigger handler drives `@isOpen`).
	 */
	handleClose = (_dropdown: DropdownAPI, event?: Event): false | void => {
		if (this._syncing) return;
		if (event) {
			if (event instanceof KeyboardEvent && event.key === "Escape") {
				this.args.onEsc?.();
			} else {
				const path = (event as Event & { composedPath?: () => EventTarget[] })
					.composedPath?.();
				const target = (path?.[0] ?? event.target) as Node | null;
				const fromTrigger =
					!!this.triggerEl && !!target && this.triggerEl.contains(target);
				if (!fromTrigger) {
					this.args.onClickOutside?.(event);
				}
			}
		}
		return false;
	};

	/**
	 * Intercepts EBD's open attempts. Our own `@isOpen` sync (`_syncing`) is
	 * allowed; any user/trigger-initiated open is blocked so the consumer owns
	 * the open state via `@isOpen`.
	 */
	handleOpen = (): false | void => {
		if (this._syncing) return;
		return false;
	};

	// ─── Focus management ─────────────────────────────────────────────────────

	captureContent = (el: Element | null): void => {
		if (el) {
			this.contentEl = el as HTMLElement;
			this.setupFocusManagement();
		} else {
			this.teardownFocusManagement();
			this.contentEl = null;
		}
	};

	private setupFocusManagement(): void {
		// Tooltip type NEVER auto-focuses or traps (matching Base Web)
		if (this.accessibilityType === "tooltip") return;

		// Save the currently focused element (the trigger) for returnFocus
		if (this.args.returnFocus) {
			this.previouslyFocused = document.activeElement as HTMLElement | null;
		}

		// autoFocus: focus first focusable element in content after rAF
		if (this.args.autoFocus && this.contentEl) {
			requestAnimationFrame(() => {
				if (!this.contentEl) return;
				const focusable = this.contentEl.querySelector<HTMLElement>(
					'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])',
				);
				focusable?.focus();
			});
		}

		// focusLock: trap Tab cycling within content
		if (this.args.focusLock && this.contentEl) {
			this.cleanupFocusTrap = trapFocus(this.contentEl);
		}
	}

	private teardownFocusManagement(): void {
		// Clean up focus trap
		if (this.cleanupFocusTrap) {
			this.cleanupFocusTrap();
			this.cleanupFocusTrap = null;
		}

		// returnFocus: restore focus to the trigger
		if (this.args.returnFocus && this.previouslyFocused) {
			this.previouslyFocused.focus();
			this.previouslyFocused = null;
		}
	}

	willDestroy(): void {
		super.willDestroy();
		this.teardownFocusManagement();
	}

	// ─── Template ─────────────────────────────────────────────────────────────

	<template>
		<BasicDropdown
			@renderInPlace={{false}}
			@verticalPosition={{this.verticalPosition}}
			@horizontalPosition={{this.horizontalPosition}}
			@destination={{this.destination}}
			@matchTriggerWidth={{false}}
			@initiallyOpened={{this.isOpen}}
			@onClose={{this.handleClose}}
			@onOpen={{this.handleOpen}}
			...attributes
			as |dd|
		>
			<dd.Trigger {{this.syncOpenState dd this.isOpen}}>
				{{yield
					(hash
						isOpen=this.isOpen
						open=this.open
						close=this.close
						toggle=this.toggle
						anchor=this.anchorModifier
					)
					to="trigger"
				}}
			</dd.Trigger>

			{{#if this.isOpen}}
				<dd.Content>
					<div class={{this.bodyClassName}} style={{this.marginStyle}}>
						{{#if this.showArrow}}
							<div class={{this.arrowClassName}} style={{this.arrowPositionStyle}}></div>
						{{/if}}
						<div class={{this.innerClassName}} id={{this.contentAriaId}} role={{this.contentRole}} {{bstRef this.captureContent}}>
							{{yield (hash close=this.close) to="content"}}
						</div>
					</div>
				</dd.Content>
			{{/if}}
		</BasicDropdown>
	</template>
}

// ─── Stateful (Uncontrolled) Popover ────────────────────────────────────────────

/**
 * StatefulPopover - uncontrolled variant.
 *
 * Manages its own open/close state internally using EBD's `dd.isOpen` and
 * `dd.actions`. Fires `onOpen`/`onClose` callbacks after each transition.
 *
 * Supports `dismissOnClickOutside` (default true) and `dismissOnEsc` (default true)
 * to control whether outside clicks or Escape key dismiss the popover.
 *
 * Usage:
 * ```gts
 * <StatefulPopover @onOpen={{this.handleOpen}} @onClose={{this.handleClose}}>
 *   <:trigger as |pop|>
 *     <button {{pop.anchor}}>Toggle</button>
 *   </:trigger>
 *   <:content as |pop|>
 *     Content here.
 *     <button {{on "click" pop.close}}>Close</button>
 *   </:content>
 * </StatefulPopover>
 * ```
 */
class StatefulPopover extends Component<StatefulPopoverSignature> {
	private readonly contentId = generateId("popover-content");
	private previouslyFocused: HTMLElement | null = null;
	private cleanupFocusTrap: (() => void) | null = null;
	private contentEl: HTMLElement | null = null;

	// ─── Internal open state (mirrors dd.isOpen) ──────────────────────────────

	@tracked _isOpen = this.args.initialOpen ?? false;

	// ─── Placement ────────────────────────────────────────────────────────────

	get placement(): PopoverPlacement {
		return this.args.placement ?? "auto";
	}

	get resolvedPlacement() {
		return mapPlacement(this.placement);
	}

	get verticalPosition() {
		return this.resolvedPlacement.vertical;
	}

	get horizontalPosition() {
		return this.resolvedPlacement.horizontal;
	}

	// ─── Destination (mountNode) ──────────────────────────────────────────────

	get destination(): string {
		if (this.args.mountNode) {
			if (!this.args.mountNode.id) {
				this.args.mountNode.id = generateId("popover-dest");
			}
			return this.args.mountNode.id;
		}
		// Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
	}

	// ─── Margin ───────────────────────────────────────────────────────────────

	get popoverMargin(): number {
		return Math.max(0, Math.round(this.args.popoverMargin ?? 8));
	}

	get marginStyle(): string {
		const margin = this.popoverMargin;
		if (margin === 0) return htmlSafe("").toString();

		const placement = this.placement;

		if (placement.startsWith("left")) {
			return htmlSafe(`margin-right: ${margin}px`).toString();
		}
		if (placement.startsWith("right")) {
			return htmlSafe(`margin-left: ${margin}px`).toString();
		}

		const { vertical } = this.resolvedPlacement;
		if (vertical === "above") {
			return htmlSafe(`margin-bottom: ${margin}px`).toString();
		}
		return htmlSafe(`margin-top: ${margin}px`).toString();
	}

	// ─── Delays ───────────────────────────────────────────────────────────────

	get onMouseEnterDelay(): number {
		return Math.max(0, Math.round(this.args.onMouseEnterDelay ?? 200));
	}

	get onMouseLeaveDelay(): number {
		return Math.max(0, Math.round(this.args.onMouseLeaveDelay ?? 200));
	}

	// ─── Trigger type / accessibility type ────────────────────────────────────

	get triggerType(): TriggerType {
		return this.args.triggerType ?? "click";
	}

	get accessibilityType(): AccessibilityType {
		return this.args.accessibilityType ?? "menu";
	}

	// ─── Content ARIA ─────────────────────────────────────────────────────────

	get contentRole(): string | undefined {
		if (this.accessibilityType === "tooltip") return "tooltip";
		// Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
	}

	get contentAriaId(): string | undefined {
		if (this.accessibilityType === "none") // Default to ember-basic-dropdown-wormhole to avoid layout shift
		return "ember-basic-dropdown-wormhole";
		return this.contentId;
	}

	// ─── Arrow / Body / Inner ─────────────────────────────────────────────────

	get showArrow(): boolean {
		return this.args.showArrow ?? false;
	}

	get bodyClassName(): string | undefined {
		const resolved = resolveOverride(styles.body, this.args.overrides, "Body");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get innerClassName(): string | undefined {
		const resolved = resolveOverride(styles.inner, this.args.overrides, "Inner");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get arrowClassName(): string | undefined {
		const resolved = resolveOverride(styles.arrow, this.args.overrides, "Arrow");
		const { className } = stylex.props(...resolved);
		return className || undefined;
	}

	get arrowPositionStyle(): string {
		const placement = this.placement;
		const offset = ARROW_WIDTH / 2;

		if (placement.startsWith("left")) {
			return htmlSafe(`right: -${offset}px; top: calc(50% - ${offset}px)`).toString();
		}
		if (placement.startsWith("right")) {
			return htmlSafe(`left: -${offset}px; top: calc(50% - ${offset}px)`).toString();
		}

		const { vertical } = this.resolvedPlacement;
		if (vertical === "above") {
			return htmlSafe(`bottom: -${offset}px; left: calc(50% - ${offset}px)`).toString();
		}
		// below, auto, or default
		return htmlSafe(`top: -${offset}px; left: calc(50% - ${offset}px)`).toString();
	}

	// ─── Dismissal configuration ──────────────────────────────────────────────

	get dismissOnClickOutside(): boolean {
		return this.args.dismissOnClickOutside ?? true;
	}

	get dismissOnEsc(): boolean {
		return this.args.dismissOnEsc ?? true;
	}

	// ─── Toggle handler ───────────────────────────────────────────────────────

	handleToggle = (dd: DropdownAPI): void => {
		if (dd.isOpen) {
			dd.actions.close();
		} else {
			dd.actions.open();
		}
	};

	// ─── Anchor modifier factory ──────────────────────────────────────────────

	/**
	 * Creates the anchor modifier using tracked `_isOpen` for reactive ARIA.
	 * The toggle/open/close actions call into `ddActions` captured via the
	 * `handleToggle`/`handleOpen`/`handleClose` pattern in the template.
	 */
	createAnchorModifier = (dd: DropdownAPI) => {
		return createAnchorModifier({
			isOpen: this._isOpen,
			triggerType: this.triggerType,
			accessibilityType: this.accessibilityType,
			contentId: this.contentId,
			toggle: () => this.handleToggle(dd),
			open: () => dd.actions.open(),
			close: () => dd.actions.close(),
			onMouseEnterDelay: this.onMouseEnterDelay,
			onMouseLeaveDelay: this.onMouseLeaveDelay,
		});
	};

	// ─── EBD event handlers ───────────────────────────────────────────────────

	/**
	 * Called by EBD when it wants to open the dropdown.
	 * We allow the open (don't return false) and update our tracked state.
	 * Fires `onOpen` exactly once if provided (Req 7.4, 7.6).
	 */
	handleOpen = (): void => {
		this._isOpen = true;
		this.args.onOpen?.();
	};

	/**
	 * Called by EBD when it wants to close the dropdown (outside click or Escape).
	 * We check dismissal config:
	 * - If dismissOnClickOutside is false and event is a click outside → return false (prevent)
	 * - If dismissOnEsc is false and event is Escape → return false (prevent)
	 * - Otherwise, allow close and fire `onClose` (Req 7.5, 7.6, 7.7, 7.8).
	 */
	handleClose = (_dropdown: DropdownAPI, event?: Event): false | void => {
		if (event) {
			// Check if this is an Escape key press
			if (event instanceof KeyboardEvent && event.key === "Escape") {
				if (!this.dismissOnEsc) {
					return false; // Prevent EBD from closing
				}
			} else {
				// Assume it's an outside click
				if (!this.dismissOnClickOutside) {
					return false; // Prevent EBD from closing
				}
			}
		}

		// Allow the close
		this._isOpen = false;
		this.args.onClose?.();
	};

	// ─── Focus management ─────────────────────────────────────────────────────

	captureContent = (el: Element | null): void => {
		if (el) {
			this.contentEl = el as HTMLElement;
			this.setupFocusManagement();
		} else {
			this.teardownFocusManagement();
			this.contentEl = null;
		}
	};

	private setupFocusManagement(): void {
		// Tooltip type NEVER auto-focuses or traps (matching Base Web)
		if (this.accessibilityType === "tooltip") return;

		// Save the currently focused element (the trigger) for returnFocus
		if (this.args.returnFocus) {
			this.previouslyFocused = document.activeElement as HTMLElement | null;
		}

		// autoFocus: focus first focusable element in content after rAF
		if (this.args.autoFocus && this.contentEl) {
			requestAnimationFrame(() => {
				if (!this.contentEl) return;
				const focusable = this.contentEl.querySelector<HTMLElement>(
					'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])',
				);
				focusable?.focus();
			});
		}

		// focusLock: trap Tab cycling within content
		if (this.args.focusLock && this.contentEl) {
			this.cleanupFocusTrap = trapFocus(this.contentEl);
		}
	}

	private teardownFocusManagement(): void {
		// Clean up focus trap
		if (this.cleanupFocusTrap) {
			this.cleanupFocusTrap();
			this.cleanupFocusTrap = null;
		}

		// returnFocus: restore focus to the trigger
		if (this.args.returnFocus && this.previouslyFocused) {
			this.previouslyFocused.focus();
			this.previouslyFocused = null;
		}
	}

	willDestroy(): void {
		super.willDestroy();
		this.teardownFocusManagement();
	}

	// ─── Template ─────────────────────────────────────────────────────────────

	<template>
		<BasicDropdown
			@renderInPlace={{false}}
			@verticalPosition={{this.verticalPosition}}
			@horizontalPosition={{this.horizontalPosition}}
			@destination={{this.destination}}
			@matchTriggerWidth={{false}}
			@initiallyOpened={{this._isOpen}}
			@onClose={{this.handleClose}}
			@onOpen={{this.handleOpen}}
			...attributes
			as |dd|
		>
			<dd.Trigger>
				{{yield
					(hash
						isOpen=dd.isOpen
						open=dd.actions.open
						close=dd.actions.close
						toggle=(fn this.handleToggle dd)
						anchor=(this.createAnchorModifier dd)
					)
					to="trigger"
				}}
			</dd.Trigger>

			{{#if dd.isOpen}}
				<dd.Content>
					<div class={{this.bodyClassName}} style={{this.marginStyle}}>
						{{#if this.showArrow}}
							<div class={{this.arrowClassName}} style={{this.arrowPositionStyle}}></div>
						{{/if}}
						<div class={{this.innerClassName}} id={{this.contentAriaId}} role={{this.contentRole}} {{bstRef this.captureContent}}>
							{{yield (hash close=dd.actions.close) to="content"}}
						</div>
					</div>
				</dd.Content>
			{{/if}}
		</BasicDropdown>
	</template>
}

export default StatefulPopover;
