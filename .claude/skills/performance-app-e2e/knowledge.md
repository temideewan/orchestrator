# performance-app E2E Knowledge Bank

This knowledge bank stores learned Puppeteer patterns, selector strategies, wait fixes, and test reliability improvements for the performance-app project. It is automatically updated by the skill when significant learnings are identified.

---

## Learned Patterns & Best Practices

*Successful Puppeteer and POM patterns that should be reused.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Rule Title | Impact Level | Why beneficial | Task: TASK-ID

Context: [when this rule applies]
Pattern: [how to implement it]
Benefits: [why it's valuable]
Example: [code snippet or scenario]
```

---

## Common Pitfalls & Solutions

*Flaky tests, selector failures, and their fixes.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Vue Router transitions require waitForNavigation not waitForSelector on new route | High Impact | Prevents race conditions on SPA navigation | Task: TASK-456
```

---

## Performance Optimisations

*Test speed improvements and pipeline optimisations.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Seed test data via API in beforeAll, not via UI interactions | Medium Impact | Reduces suite setup time by ~60% | Task: TASK-789
```

---

## Security Learnings

*Security flows that need E2E coverage.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Test that appraisal forms reject submission without required rating fields | High Impact | Catches client-side validation bypasses | Task: TASK-321
```

---

## Integration Patterns

*Patterns for interacting with the Vue 3 SPA's specific behaviour.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | TanStack Query loading states cause brief element absence — use waitForSelector with visible option | Medium Impact | Prevents selector-not-found errors during data loading | Task: TASK-654
```

---

## Testing Strategies

*Effective E2E test organisation for the performance management domain.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Use one Page Object per route view, not per modal | Low Impact | Keeps Page Objects cohesive and maintainable | Task: TASK-987
```

---

## Architecture Decisions

*Significant E2E architecture choices.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Create an AuthPage helper for login flow, shared across all suites | Medium Impact | Eliminates repeated login boilerplate in every beforeAll | Task: TASK-147
```

---

## Tooling & Development

*Puppeteer config, Jest setup, and CI workflow improvements.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Use --single-process Chromium flag in Docker to avoid sandbox issues | Low Impact | Fixes Chrome crash on startup in CI containers | Task: TASK-258
```

---

## Learning Statistics

- **Total Learnings**: 0
- **High Impact**: 0
- **Medium Impact**: 0
- **Low Impact**: 0
- **Last Updated**: 2026-05-04

---

*Note: This knowledge bank is continuously updated. Review periodically to ensure learnings remain relevant and accurate.*
