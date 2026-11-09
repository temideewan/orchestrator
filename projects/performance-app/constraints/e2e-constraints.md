# E2E Constraints: performance-app

These constraints govern all end-to-end test development for the `performance-app` project.

---

## Page Object Model (POM) — Mandatory

- **All page interactions must go through Page Objects** — zero raw selectors in test files
- Every page or major UI surface gets its own Page Object class inheriting from `BasePage`
- Page Objects expose semantic methods (`clickCreateObjective()`, `fillAppraisalForm(data)`) — not raw `click('[data-testid=...]')`
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

1. **ARIA selectors** — `[role="button"]`, `[aria-label="Create objective"]`, `[aria-labelledby="..."]`
2. **`data-testid` attributes** — `[data-testid="objective-create-btn"]`
3. **Semantic HTML** — `button`, `input[type="submit"]`
4. **Avoid**: CSS class names, auto-generated IDs, DOM structure-dependent selectors

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

- **Screenshot on every failure** — use a `afterEach` hook or `try/catch` in test steps
- Screenshot naming: `test-results/screenshots/{suite}-{test-name}-failure.png`
- Descriptive test names: `it('should submit appraisal form and show success toast')` — reads like a user story

## Reporting

- **HTML report**: `test-results/report.html` — generated after every run via `jest-html-reporter`
- **JUnit XML**: `test-results/junit.xml` — for CI integration via `jest-junit`
- Both reporters must be configured in the Jest config

## App Configuration for E2E

- **Dev server URL**: `http://localhost:8080` (webpack dev server default)
- Start the app before E2E runs: `yarn serve` or use the Docker compose setup
- For CI, build production bundle (`yarn build`) and serve `dist/` on port 8080 with a static file server

## Full Pipeline

```bash
# 1. Start app
yarn serve &

# 2. Wait for it to be ready
wait-for http://localhost:8080

# 3. Run tests
cd e2e && npx jest --config jest.config.ts

# 4. Results are in:
#    test-results/report.html
#    test-results/junit.xml
#    test-results/screenshots/ (failures only)

# 5. Kill dev server
```

## Quick Run (app already running)

```bash
cd e2e && npx jest --config jest.config.ts
```

## Single Suite

```bash
cd e2e && npx jest --config jest.config.ts -- tests/objectives.spec.ts
```

## Test Domain Coverage Priority

Test these user flows in order of business criticality:

1. **Objectives** — create OKR, create KPI, update, activate, submit for approval
2. **Appraisals** — start appraisal, fill form, submit, view report
3. **Performance Reviews** — initiate review, complete review, view report
4. **PIPs** — create PIP, update, view detail
5. **Exceptional Achievements** — create EA/ESS, view list
6. **Matrix Appraisals** — multi-rater flow
7. **Settings** — admin configuration changes

## Quality Standards

- POM enforced — zero raw selectors in test files
- No `waitForTimeout` anywhere in the test codebase
- Screenshot on every failure
- HTML + JUnit reports generated on every run
- Clean isolation — no inter-test dependencies
- Headless mode must work (for CI)
- Docker-compatible (Debian + Chrome deps)
