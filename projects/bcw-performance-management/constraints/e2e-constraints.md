# E2E Constraints: bcw-performance-management

These constraints govern all end-to-end test development for the `bcw-performance-management` project.

---

## Page Object Model (POM) — Mandatory

- **All page interactions must go through Page Objects** — zero raw selectors in test files
- Every page or major UI surface gets its own Page Object class inheriting from `BasePage`
- Page Objects expose semantic methods (`clickCreateCycle()`, `fillAppraisalForm(data)`) — not raw `click('[data-testid=...]')`
- Page Objects live in `e2e/pages/` — one file per page or major UI surface

### BasePage Contract
```typescript
abstract class BasePage {
  constructor(protected page: Page) {}
  async navigate(path: string): Promise<void>
  async waitForPageLoad(): Promise<void>
  async screenshot(name: string): Promise<void>
  async getText(selector: string): Promise<string>
  async click(selector: string): Promise<void>
  async type(selector: string, text: string): Promise<void>
  async isVisible(selector: string): Promise<boolean>
}
```

## Selector Strategy

Priority order (use highest available):

1. **ARIA selectors** — `[role="button"]`, `[aria-label="Create appraisal cycle"]`, `[aria-labelledby="..."]`
2. **`data-testid` attributes** — `[data-testid="appraisal-cycle-create-btn"]`
3. **Semantic HTML** — `button`, `input[type="submit"]`
4. **Avoid**: CSS class names (Stencil may scope-hash them), auto-generated IDs, DOM structure-dependent selectors

## Wait Strategies — No `waitForTimeout`

- **Never** use `waitForTimeout` or `page.waitForTimeout` — they produce flaky tests
- Use these instead:
  - `waitForSelector(selector)` — element exists in DOM
  - `waitForNavigation()` — full page navigation completes
  - `waitForFunction(fn)` — arbitrary JS condition is true
  - `waitForNetworkIdle()` — all network requests settle (use sparingly)

## Test Isolation

- Each test suite (`describe` block) must set up its own state in `beforeAll`/`beforeEach` via API calls — do not depend on state left by another suite
- Tear down created data in `afterAll`/`afterEach`
- Tests within a suite may share setup, but **one test must never depend on a previous test's side effects**

## Failure Handling

- **Screenshot on every failure** — use an `afterEach` hook or `try/catch` in test steps
- Screenshot naming: `test-results/screenshots/{suite}-{test-name}-failure.png`
- Descriptive test names: `it('should create an appraisal cycle and view its detail page')` — reads like a user story

## Reporting

- **HTML report**: `test-results/report.html` — generated after every run via `jest-html-reporter`
- **JUnit XML**: `test-results/junit.xml` — for CI integration via `jest-junit`
- Both reporters must be configured in the Jest config

## App Configuration for E2E

- **Dev server URL**: `http://localhost:3333` (Stencil dev server default)
- Start the app before E2E runs: `yarn start` or use the Docker Compose setup
- The root custom element is `swc-bcw-performance-management-app` — wait for it to be defined before interacting

```javascript
// Wait for Stencil custom element to be defined
await page.waitForFunction(() => customElements.get('swc-bcw-performance-management-app') !== undefined);
```

## Full Pipeline

```bash
# 1. Start Stencil dev server
yarn start &

# 2. Wait for it to be ready
npx wait-on http://localhost:3333

# 3. Run E2E tests
cd e2e && npx jest --config jest.config.ts

# 4. Results are in:
#    test-results/report.html
#    test-results/junit.xml
#    test-results/screenshots/ (failures only)

# 5. Kill dev server
kill %1
```

## Quick Run (app already running)

```bash
cd e2e && npx jest --config jest.config.ts
```

## Single Suite

```bash
cd e2e && npx jest --config jest.config.ts -- tests/appraisal.spec.ts
```

## Test Domain Coverage Priority

Test these user flows in order of business criticality:

1. **Authentication** — login, 401 redirect to login
2. **Performance Appraisal** — list cycles, create cycle (multi-step wizard: define → periods → participants → review/confirm), view cycle detail, edit cycle, duplicate, delete
3. **Appraisal Periods** — view period details, manage period settings
4. **Line Manager Dashboard** — view stats, view pending appraisals, view teams, manager table
5. **Configurations — Criteria Metrics** — list metrics, create metric, edit metric, delete metric
6. **Configurations — Policies** — view policies, configure policy settings

## Quality Standards

- POM enforced — zero raw selectors in test files
- No `waitForTimeout` anywhere in the test codebase
- Screenshot on every failure
- HTML + JUnit reports generated on every run
- Clean isolation — no inter-test dependencies
- Wait for Stencil custom elements to be defined before interacting
- Headless mode must work (for CI)
- Docker-compatible (Debian + Chrome dependencies)
