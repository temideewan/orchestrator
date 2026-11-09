# performance-app Planner Knowledge Bank

This knowledge bank stores learned planning patterns, decomposition insights, and risk patterns discovered during task planning for the performance-app project. It is automatically updated by the skill when significant learnings are identified.

---

## Learned Patterns & Best Practices

*Successful planning patterns and decomposition approaches that should be reused.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Rule Title | Impact Level | Why beneficial | Task: TASK-ID

Context: [when this rule applies]
Pattern: [how to implement it]
Benefits: [why it's valuable]
Example: [scenario]
```

---

## Common Pitfalls & Solutions

*Planning mistakes and their corrections.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Always check if a composable is shared before proposing signature changes | High Impact | Prevents regressions in unrelated views | Task: TASK-456
```

---

## Performance Optimisations

*Planning insights that lead to more efficient implementations.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Group multiple related mutations into one Vuex action to reduce re-renders | Medium Impact | Avoids cascading reactivity updates | Task: TASK-789
```

---

## Security Learnings

*Security risks identified during planning.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Plan v-html usage review whenever rendering server-supplied content | High Impact | Prevents XSS from HRMS API responses | Task: TASK-321
```

---

## Integration Patterns

*Patterns for decomposing features that touch multiple module areas.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | New entity flow always follows: types → api → composable → component → view | Medium Impact | Consistent decomposition reduces planning time | Task: TASK-654
```

---

## Testing Strategies

*Planning insights for E2E test coverage.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Include data-testid requirements in web spec, not just e2e spec | Medium Impact | Ensures web skill adds them during implementation, not as an afterthought | Task: TASK-987
```

---

## Architecture Decisions

*Significant architectural planning choices.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Scope new Vuex modules narrowly — prefer composable local state for single-view state | Medium Impact | Keeps store manageable as feature count grows | Task: TASK-147
```

---

## Tooling & Development

*Planning workflow and tooling insights.*

### Example Entry Format:
```
[AUTO-LEARNED] YYYY-MM-DD | Check queryKeys.ts before planning a new composable to avoid key collisions | Low Impact | Prevents cache invalidation bugs from duplicate keys | Task: TASK-258
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
