# [Task Title] — Standard Specification

> Use for: typical features, API endpoints, UI screens (~80 lines)

## Quick Reference
- **What**: One-line problem statement
- **Why**: Business context / user impact
- **Platform**: [Tech stack / service]
- **Complexity**: Standard
- **Ticket**: [TASK-ID]
- **Success Metric**: How to verify it works

## Problem Statement

[Current state → Problem → Desired state]

## User Stories

- **US-001**: As a [user type], I want [action] so that [benefit]
  - AC-1: [Acceptance criterion]
  - AC-2: [Acceptance criterion]

- **US-002**: As a [user type], I want [action] so that [benefit]
  - AC-1: [Acceptance criterion]

## Technical Design

### Architecture
[Data flow, component interactions, key decision]

### API / Interface Changes
```
METHOD /endpoint
Request:  { field: type }
Response: { field: type }
Errors:   { 4xx: reason }
```

### Data Model
[Schema changes or new fields, if any]

### Key Decisions
- [Decision and rationale]
- [Alternative considered and why rejected]

## Testing Strategy

- **Unit**: [What to unit test]
- **Integration**: [What to integration test]
- **Coverage target**: [X]%
- **Edge cases**: [List key edge cases]

## Implementation Notes

- [Constraint or gotcha]
- [Dependency on another task or service]
- [Performance consideration]
