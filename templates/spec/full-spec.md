# [Task Title] — Full Specification

> Use for: complex features, architectural changes, multi-service work (150+ lines)

## Quick Reference
- **What**: One-line problem statement
- **Why**: Business context / user impact
- **Platform**: [Tech stack / services involved]
- **Complexity**: Full
- **Ticket**: [TASK-ID]
- **Skills Required**: [e.g., backend + infrastructure + test]
- **Estimated Scope**: [S / M / L]
- **Success Metric**: How to verify it works

---

## Problem Statement

### Current State
[What exists today and why it's insufficient]

### Problem
[Specific pain point, failure mode, or missing capability]

### Desired State
[What the world looks like after this is done]

---

## User Stories

- **US-001**: As a [user type], I want [action] so that [benefit]
  - AC-1: [Acceptance criterion]
  - AC-2: [Acceptance criterion]
  - AC-3: [Acceptance criterion]

- **US-002**: As a [user type], I want [action] so that [benefit]
  - AC-1: [Acceptance criterion]
  - AC-2: [Acceptance criterion]

---

## Technical Design

### Architecture Overview
[Diagram or description of how components interact]

### API / Interface Changes

#### New Endpoints
```
POST /resource
Request:  { field: type, field: type }
Response: { id: string, field: type }
Errors:   { 400: "validation", 401: "unauthorized", 404: "not found" }

GET /resource/:id
Response: { id: string, field: type }
```

#### Modified Endpoints
[List any changes to existing contracts]

### Data Model

#### New Tables / Collections
```
TableName {
  id:         string (PK)
  field_name: type     // description
  created_at: datetime
}
```

#### Migrations Required
[List schema migrations if applicable]

### Service Dependencies
- [Service A]: [How it's used]
- [Service B]: [How it's used]

### Key Architectural Decisions
| Decision | Choice | Rationale | Alternative Considered |
|----------|--------|-----------|------------------------|
| [topic]  | [what] | [why]     | [what else was considered] |

---

## Security Considerations

- [Authentication / authorization requirements]
- [Data sensitivity and handling]
- [Input validation requirements]
- [Rate limiting / abuse prevention]

---

## Performance Considerations

- [Expected load / scale]
- [Caching strategy]
- [Query optimization requirements]
- [Async processing needs]

---

## Testing Strategy

### Unit Tests
- [Component / function to test]
- [Edge cases to cover]

### Integration Tests
- [Service interactions to test]
- [Database operations to verify]

### E2E Tests
- [User flow to cover end-to-end]

### Coverage Targets
- Backend: [X]%
- Frontend: [X]%
- Mobile: [X]%

### Test Data
[Any fixtures or seed data required]

---

## Implementation Plan

### Phase 1: [Foundation]
- [ ] [Step]
- [ ] [Step]

### Phase 2: [Core Implementation]
- [ ] [Step]
- [ ] [Step]

### Phase 3: [Testing & Cleanup]
- [ ] [Step]
- [ ] [Step]

---

## Implementation Notes

- [Critical constraint]
- [Dependency or blocker]
- [Rollback plan if needed]
- [Monitoring / alerting to add]

---

## Open Questions

- [ ] [Question that needs resolution before implementation]
- [ ] [Question that can be resolved during implementation]
