---
name: e2e-testing
description: Use this skill when writing end-to-end tests with Playwright. Covers browser automation, user interactions, test structure, and CI integration. For unit/component testing, see the unit-testing skill.
related-skills:
  - code-style
  - unit-testing
  - vue-project-stack
---

# End-to-end testing

E2E tests verify full user journeys from browser to backend. Playwright automates browser interactions and assertions.

## Playwright setup

Playwright runs headless browsers (Chromium, Firefox, WebKit) and records interactions.

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

**Use data-test attributes**: Always prefer `data-test="component.element"` over CSS selectors. Namespacing (component.element) avoids cross-test contamination and makes intent clear.

## Best practices

- **One user journey per test** — test full flows, not isolated pieces
- **Use data attributes** — `data-testid="user-input"` is more stable than selectors
- **Wait explicitly** — avoid `page.waitForTimeout()`, use `waitForURL()` or `waitForSelector()`
- **Cleanup** — don't leave test data; use `beforeAll`/`afterAll` to set up/tear down
- **Parallel tests** — tests run in parallel by default; don't depend on execution order
