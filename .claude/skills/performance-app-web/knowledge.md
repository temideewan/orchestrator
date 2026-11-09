# performance-app Web Knowledge Bank

This knowledge bank stores learned patterns, best practices, and solutions discovered during task execution. It is automatically updated by the skill when significant learnings are identified.

---

## Learned Patterns & Best Practices

*Successful patterns and approaches that should be reused in future tasks.*

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

*Problems encountered and their solutions to avoid repeating mistakes.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Avoid N+1 queries by combining composable fetches | High Impact | Prevents performance degradation | Task: TASK-456
```

---

## Performance Optimisations

*Performance improvements and optimisation techniques discovered.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Use defineAsyncComponent for heavy modals | Medium Impact | Reduces initial bundle size | Task: TASK-789
```

---

## Security Learnings

*Security best practices and vulnerability prevention techniques.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Sanitise HTML before v-html binding | High Impact | Prevents XSS via server-returned HTML | Task: TASK-321
```

---

## Integration Patterns

*Patterns for integrating with TanStack Query, Vuex, Vue Router, and @shrfe packages.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Invalidate parent + child query keys on mutation | Medium Impact | Keeps cache consistent after nested resource updates | Task: TASK-654
```

---

## Testing Strategies

*Effective Vue Test Utils and Jest approaches.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Use flushPromises() after TanStack Query mutations in tests | Low Impact | Prevents false negatives from async state updates | Task: TASK-987
```

---

## Architecture Decisions

*Significant Vue SPA architectural choices and their rationale.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Co-locate query key with composable, not in queryKeys.ts for one-off keys | Medium Impact | Reduces maintenance overhead for single-use queries | Task: TASK-147
```

---

## Tooling & Development

*Webpack, Yarn, ESLint, Lefthook workflow improvements.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Use thread-loader for ts-loader to speed up dev builds | Low Impact | Cuts incremental build time by ~30% on large SFCs | Task: TASK-258
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
