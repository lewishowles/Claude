---
name: e2e-testing
description: >
  Use this skill when writing, reviewing, or planning end-to-end and browser-based component tests with Playwright or Cypress. It guides agents through user-focused browser automation, interaction coverage, test structure, selector strategy, and CI setup. For isolated logic or rendering checks that do not need a browser, use the unit-testing skill instead.
related-skills:
  - code-style
  - unit-testing
  - vue-project-stack
---

# End-to-end testing

E2E and component tests verify what users see and experience in a real browser. Playwright is the current standard for new projects; Cypress is used in many existing projects and should be respected where already in place.

## General

- Avoid running tests by default because browser-test output is token-heavy. Run only focused tests when needed to verify a specific fix or failure; suggest broader commands for the user to run
- Do not run full suites from plan verification steps unless the user explicitly asks

## Which tool to use

- **Playwright** — preferred for all new projects and new test suites. Supports both full e2e and component-level testing
- **Cypress** — used in many existing projects. Continue using it where already established; don't migrate away unless asked
- **No component testing yet?** — add Playwright component tests, not Cypress

## Component testing

Component tests sit between Vitest unit tests and full e2e. They mount a single component in a real browser and assert what the user sees and experiences. Both Playwright and Cypress support this pattern.

### What to test

- Rendered output: visible text, ARIA attributes, element presence driven by props or slots
- User interaction: click, type, keyboard navigation, focus movement
- Slot-driven behaviour: content appears when a slot is populated, absent when it isn't
- Accessibility attributes: `aria-invalid`, `aria-disabled`, `aria-expanded`, `role`, etc.

### What not to test

- Framework internals: computed values, reactive refs, `wrapper.vm.*` — those belong in Vitest
- Implementation details: internal state, method calls, component structure not visible to the user
- DOM structure for its own sake: assert that an element communicates something, not that a specific tag was used

### Cypress component testing

Used in existing projects with Cypress already configured. Test files are `.cy.js`, co-located with the component.

Projects may provide custom helpers via `@cypress/support/mount`:

- `cy.getByData("data-test-value")` — select by `data-test` attribute
- `cy.getFormField("data-test-value")` — select the native form control inside a form component
- `cy.shouldBeVisible()`, `cy.shouldHaveAttribute(attr, value)`, `cy.shouldNotHaveAttribute(attr)`, `cy.shouldHaveText(text)`, `cy.shouldHaveClass(cls)` — chainable assertion helpers

```javascript
import { createMount } from "@cypress/support/mount";
import FormInput from "./form-input.vue";

const defaultProps = { id: "id-abc" };
const defaultSlots = { default: "Your name" };
const mount = createMount(FormInput, { props: defaultProps, slots: defaultSlots });

describe("form-input", () => {
    it("Sets aria-invalid when an error is provided", () => {
        mount({ slots: { error: "Error text" } });

        cy.getFormField("form-input").shouldHaveAttribute("aria-invalid", "true");
    });

    it("Does not set aria-invalid without an error", () => {
        mount();

        cy.getFormField("form-input").shouldNotHaveAttribute("aria-invalid");
    });
});
```

### Playwright component testing

Preferred for new projects. Use `@playwright/experimental-ct-vue` (or the relevant framework package).

```typescript
import { test, expect } from "@playwright/experimental-ct-vue";
import FormInput from "./form-input.vue";

test("sets aria-invalid when an error is provided", async ({ mount }) => {
    const component = await mount(FormInput, {
        props: { id: "id-abc" },
        slots: { default: "Your name", error: "Error text" },
    });

    await expect(component.locator("input")).toHaveAttribute("aria-invalid", "true");
});

test("does not set aria-invalid without an error", async ({ mount }) => {
    const component = await mount(FormInput, {
        props: { id: "id-abc" },
        slots: { default: "Your name" },
    });

    await expect(component.locator("input")).not.toHaveAttribute("aria-invalid");
});
```

## Playwright setup

Runs headless browsers (Chromium, Firefox, WebKit), records interactions.

```bash
bun add -D @playwright/test
```

Configure in `playwright.config.ts`:

```typescript
import { defineConfig, devices } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: "html",
  use: { baseURL: "http://localhost:5173" },
  webServer: {
    command: "bun run dev",
    url: "http://localhost:5173",
    reuseExistingServer: !process.env.CI,
  },
  projects: [
    { name: "chromium", use: { ...devices["Desktop Chrome"] } },
    { name: "firefox", use: { ...devices["Desktop Firefox"] } },
    { name: "webkit", use: { ...devices["Desktop Safari"] } },
  ],
});
```

## Test structure

```typescript
import { test, expect } from "@playwright/test";

test("user registers and logs in", async ({ page }) => {
  // Navigate
  await page.goto("/register");

  // Fill form
  await page.fill('[data-test="form-register.email"]', "user@example.com");
  await page.fill('[data-test="form-register.password"]', "secure-pass");

  // Submit
  await page.click('[data-test="form-register.submit"]');

  // Wait for navigation
  await page.waitForURL("/login");

  // Login
  await page.fill('[data-test="form-login.email"]', "user@example.com");
  await page.fill('[data-test="form-login.password"]', "secure-pass");
  await page.click('[data-test="form-login.submit"]');

  // Assert
  await expect(page).toHaveURL("/dashboard");
  await expect(page.locator('[data-test="page-dashboard"]')).toBeVisible();
});
```

## Interaction patterns

**Click and navigate**:

```typescript
await page.click('[data-test="nav.settings"]');
await page.waitForURL("/settings");
```

**Form input**:

```typescript
await page.fill('[data-test="form.name"]', "Lewis");
await page.selectOption('[data-test="form.role"]', "admin");
await page.check('[data-test="form.terms"]');
```

**Wait for element**:

```typescript
await page.waitForSelector('[data-test="message.success"]');
await page.locator('[data-test="toast"]').isVisible();
```

**Extract data**:

```typescript
const count = await page.locator('[data-test="list-item"]').count();
const text = await page.locator('[data-test="page-title"]').textContent();
```

**Use data-test attributes**: Prefer `data-test="component.element"` over CSS selectors. Namespacing avoids cross-test contamination, intent stays clear.

**Selector simplicity**: When querying elements (e.g. finding focusable items), prioritise clarity and avoid repetition:
- ✓ Simple: `:is(button, input, select, textarea):not([disabled]), a[href], [tabindex]:not([tabindex='-1'])`
- ✗ Verbose: `:is(button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), a[href], [tabindex]:not([tabindex='-1']))`

Group similar element types with `:is()` and apply single negations rather than repeating `:not()` for each type. See code-style skill for the pattern.

## Best practices

- **One user journey per test** — full flows, not isolated pieces
- **Use data attributes** — `data-test="user-input"` is more stable than CSS selectors
- **Wait explicitly** — avoid `page.waitForTimeout()`, use `waitForURL()` or `waitForSelector()`
- **Cleanup** — no test data left; use `beforeAll`/`afterAll` to set up/tear down
- **Parallel tests** — parallel by default; no execution order dependency
