---
name: accessibility
description: Use this skill when writing or reviewing any HTML, UI components, or interface copy — even if accessibility isn't mentioned. Covers WCAG 2.2 AA baseline (AAA where feasible): colour contrast, keyboard access, screen readers, semantic HTML, focus management, forms & validation, live regions, touch targets (iOS 44×44, Android 48×48), dynamic content, and inclusive design. Apply proactively: accessible design is correct design.
related-skills:
  - code-style
  - vue
  - swift-ui
---

# Accessibility

Foundation: WCAG AA baseline; AAA where feasible. Inaccessible design is incorrect design. Affects: visual impairments (blind, low vision with zoom), colourblindness, keyboard-only navigation, neurodivergence, users needing clear language.

## Visual

- **Colour contrast**: minimum 4.5:1 (normal text), 3:1 (large text). Use tools like colorcontrast.app. Check text vs background AND button vs page background
- **Don't rely on colour alone**: users with colourblindness (1 in 12 men, 1 in 200 women) won't see meaning. Pair colour with icons or text
- **Text readability**: line-height ~1.5 (breathing room), line length ~65 chars (easier to follow), readable font sizes
- **Responsive design**: works on small screens AND at 400% zoom. At max zoom, viewport may be <250px; still navigable

## Content & copy

- **Clear language**: avoid jargon; if someone had no context, could they still understand? Provide hints and links
- **Descriptive links & buttons**: link text alone should explain action. Not "Delete", but "Delete user Lewis Howles". Not "Learn more", but "Visit MDN docs for the `button` tag"
- **Confirmation & reassurance**: show what was chosen (e.g., plan name). Provide success messages with identifiable info: "User 'Lewis Howles' successfully deleted", not just "User deleted"

## Structure & semantics

- **Heading hierarchy**: no `h1` to `h4` jumps. Use correct level, change appearance if needed. If it looks like heading, make it heading
- **Landmark regions**: use `main`, `article`, `aside`, `nav` appropriately. Helps assistive tech skip to relevant sections
- **DOM order matches visual order**: when tabbing through, order should match screen layout. Focus shouldn't jump backwards

## Images & media

- **Alt text**: describes image, not "image of". For decorative images, empty alt: `<img alt="" />`
- **Complex images (charts)**: provide legend as definition list, or narrative description of findings
- **Video & audio**: provide captions/transcripts. Helps deaf users AND those in noisy environments
- **No autoplay**: respects users' data/battery; gives control

## Interaction

- **Keyboard access**: every action via keyboard, no mouse-only interactions. Drag-drop? Provide button alternative
- **Visible focus**: show where keyboard focus is. Ring indicator, not outline removal. On delete in table? Move focus sensibly (next row), not page top
- **Skip links**: help keyboard users skip header/nav: `<a href="#main">Skip to main content</a>` with `<main id="main" tabindex="-1">`
- **Motion**: respect `prefers-reduced-motion`. Guard animations: `@media (prefers-reduced-motion: reduce) { ... }`
- **Timing**: don't auto-dismiss messages. Let user close. Some need more time to read
- **Touch targets**: minimum 44×44px; space them to avoid accidental taps
- **Focus trap in modals**: on open, save `document.activeElement` and move focus into the dialog; on close, restore the saved element. Without restoration, keyboard users lose their position in the page
- **Keyboard contract for interactive widgets** (dropdowns, menus, tabs, comboboxes): Arrow keys navigate items; Enter or Space activates; Escape cancels or closes. Don't invent novel bindings — match the [ARIA authoring practices](https://www.w3.org/WAI/ARIA/apg/patterns/)
- **Dialog ARIA**: `role="dialog"` + `aria-modal="true"` + `aria-labelledby` pointing at the dialog heading. This tells screen readers the rest of the page is inert while the dialog is open

## Touch & mobile

- **Platform touch targets**: iOS 44×44 points minimum (Apple's safe zone); Android 48×48 density-independent pixels. Bigger is better (56–60px ideal)
- **Spacing between targets**: avoid placing tappable elements too close — users with motor impairments or shaky hands need breathing room
- **Viewport meta tag**: `<meta name="viewport" content="width=device-width, initial-scale=1">` — enables zoom on all devices (never add `user-scalable=no`)
- **No horizontal scroll at 400% zoom**: test at maximum zoom on small viewport to ensure reflow, not overflow

## Forms & inputs

- **Label association**: `<label for="inputId">` linking to `<input id="inputId">`, or wrap the input. Never rely on placeholder alone
- **Grouped inputs**: use `<fieldset>` with `<legend>` for radio buttons, checkboxes, or related fields. Legend is read to screen reader users
- **Help text & instructions**: associate with `aria-describedby="helpId"` pointing at a `<span id="helpId">`. Screen readers announce it with the field
- **Validation & errors**: `aria-invalid="true"` on invalid field + `aria-errormessage="errorId"` pointing at error text. Show error summary at top, linked to fields
- **Autocomplete attributes**: use `autocomplete="email"`, `autocomplete="password"`, `autocomplete="current-password"` to help password managers and reduce user friction
- **Error recovery**: don't clear the form on error. Let user fix and resubmit

## Dynamic content & updates

- **Live regions**: use `aria-live="polite"` for form validation feedback, success messages, or notifications. Polite waits for a pause; use `aria-live="assertive"` only for urgent alerts (rare)
- **Region announcement**: pair with `aria-label` to identify what's updating: `<div aria-live="polite" aria-label="Form errors">`
- **No auto-dismiss**: messages must remain until user closes them. Some users need extra time to read
- **Screenreader-only content**: use `.sr-only { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(1px, 1px, 1px, 1px); }` to hide visually but announce to assistive tech

## Semantics & structure (expanded)

- **Tables**: `<table>` with `<caption>`, `<thead>` + `<th scope="col">` for column headers, `<th scope="row">` for row headers. Screen readers use scope to map cell data
- **Lists**: `<ul>` for unordered, `<ol>` for ordered, `<dl>` for definition lists (terms + descriptions). Don't use divs or paragraphs to fake lists
- **Abbreviations**: `<abbr title="full text">` for acronyms. Users and screen readers benefit from expansion
- **Language tag**: `lang="en"` on `<html>` element. Use `lang="cy"` or `lang="fr"` on blocks if content switches languages. Helps screen readers pronounce correctly
- **Navigation & landmarks**: use `<nav>`, `<main>`, `<aside>`, `<article>` to structure content. Screen reader users can jump to landmarks

## Content warnings & safety

- **Flashing & strobing**: no more than 3 flashes per second in any 1-second window (seizure risk). Test animated GIFs, videos, carousels
- **Content warnings**: flag violence, self-harm, abuse, graphic medical content, or other trauma triggers before the user encounters it. Give users control over visibility
- **Reduced motion**: respect `prefers-reduced-motion: reduce`. Disable auto-play animations, carousels, parallax. Keep interactions responsive but not flashy
