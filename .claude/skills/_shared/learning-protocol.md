# Autonomous Learning Protocol

This document defines how all agent skills in the oaseru-orchestrator system learn and update their knowledge banks autonomously.

---

## Learning Workflow

### 1. Rule Discovery (During Task Execution)

As you execute tasks, actively identify:
- **New patterns** that work well and should be reused
- **Solutions to tricky problems** that weren't obvious
- **Performance optimizations** that provide measurable improvements
- **Security best practices** discovered or applied
- **Common pitfalls** encountered and how to avoid them
- **Integration patterns** for working with other services
- **Architecture decisions** and their rationale

### 2. Impact Assessment (After Task Completion)

Evaluate the impact of each learning using these criteria:

#### HIGH IMPACT
Rule should be applied across multiple future tasks. Includes:
- **Security vulnerabilities** and their fixes
- **Data integrity issues** and prevention methods
- **Performance improvements** >20%
- **Compliance requirements** (GDPR, security standards)
- **Critical bugs** and root cause solutions
- **Architectural decisions** affecting system design

#### MEDIUM IMPACT
Rule improves code quality or efficiency. Includes:
- **Code quality improvements** (readability, maintainability)
- **Maintainability enhancements** (reduced complexity)
- **Performance improvements** 5-20%
- **Component-level patterns** (reusable components)
- **Testing strategies** that improve coverage
- **Development workflow** improvements

#### LOW IMPACT
Minor improvements or preferences. Includes:
- **Code style preferences** (formatting, naming)
- **Minor documentation** updates
- **Performance improvements** <5%
- **Tooling adjustments** (minor config changes)
- **Cosmetic changes** that don't affect functionality

### 3. Scope Determination

Determine where the learning should be stored:

#### Agent-Specific Learnings
Store in skill's knowledge bank when:
- Pattern is specific to the skill's tech stack (e.g., Java-specific for backend-java)
- Solution applies only to this skill's domain
- Learning involves tool/framework specific to this skill

**Storage**: `skills/[project]/[skill-name]-knowledge.md`

#### Project-Wide Learnings
Store in project constraints when:
- Pattern applies across multiple skills in the project
- General coding standard for entire project
- Security/compliance requirement for all code
- Architectural decision affecting multiple components

**Storage**: `projects/[project]/constraints/[relevant]-constraints.md`
**Action**: Add note that constraint file was updated and should be reviewed

### 4. Auto-Update Decision Tree

```
Is the rule new (not already documented)?
├─ NO → Skip update (rule already exists)
└─ YES → Continue
    │
    Is the impact Medium or High?
    ├─ NO (Low Impact) → Skip auto-update, log for manual review
    └─ YES → Continue
        │
        Is the improvement potential clear?
        ├─ NO → Skip auto-update, document for discussion
        └─ YES → Continue
            │
            Is the risk level Low?
            ├─ NO (Medium/High Risk) → Skip auto-update, flag for review
            └─ YES → Continue
                │
                Are there conflicting existing rules?
                ├─ YES → Skip auto-update, flag conflict
                └─ NO → AUTO-UPDATE APPROVED ✓
```

### 5. Knowledge Bank Update Format

When auto-updating knowledge banks, use this format:

```
[AUTO-LEARNED] YYYY-MM-DD | Rule Title | Impact Level | Why beneficial | Task: TASK-ID

Detailed explanation:
- Context: When this rule applies
- Pattern: How to implement it
- Benefits: Why it's valuable
- Example: Code snippet or scenario
```

**Example**:
```
[AUTO-LEARNED] 2026-02-09 | Use PreparedStatements for all SQL queries | High Impact | Prevents SQL injection attacks | Task: TASK-123

Context: When executing any SQL query with user input or dynamic data
Pattern: Always use PreparedStatement instead of string concatenation
Benefits:
  - Prevents SQL injection vulnerabilities
  - Improves performance with query plan caching
  - Makes code more maintainable
Example:
  // BAD
  String query = "SELECT * FROM users WHERE id = " + userId;

  // GOOD
  String query = "SELECT * FROM users WHERE id = ?";
  PreparedStatement stmt = conn.prepareStatement(query);
  stmt.setInt(1, userId);
```

### 6. Update Execution

#### For Agent-Specific Learnings:
1. Read current knowledge bank file
2. Identify appropriate section (Patterns, Pitfalls, Performance, Security, Integration, Testing, Architecture, Tooling)
3. Add new entry with full context
4. Update learning statistics at bottom of file
5. Commit the change

#### For Project-Wide Learnings:
1. Read current constraint file
2. Add learning to appropriate section
3. Add note: `[AUTO-LEARNED - REVIEW REQUIRED] Added by [skill-name] on YYYY-MM-DD`
4. Update skill's knowledge bank to reference the constraint update
5. Flag for human review (as it affects entire project)

---

## Learning Categories by Section

### Learned Patterns & Best Practices
- Successful architectural patterns
- Code organization strategies
- Design patterns that worked well
- Reusable implementations

### Common Pitfalls & Solutions
- Bugs and their root causes
- Anti-patterns to avoid
- Common mistakes and fixes
- Edge cases to handle

### Performance Optimizations
- Query optimizations
- Caching strategies
- Algorithm improvements
- Resource usage reductions

### Security Learnings
- Vulnerability fixes
- Security best practices
- Authentication/authorization patterns
- Data protection methods

### Integration Patterns
- API integration approaches
- Service communication patterns
- Third-party library usage
- Inter-component coordination

### Testing Strategies
- Test organization
- Mocking strategies
- Test data management
- Coverage improvements

### Architecture Decisions
- System design choices
- Technology selections
- Scalability considerations
- Trade-off analysis

### Tooling & Development
- Build optimizations
- Development scripts
- IDE configurations
- Workflow improvements

---

## Quality Assurance for Learnings

Before auto-updating, verify:

1. **Accuracy**: Is the rule correct and well-understood?
2. **Completeness**: Is enough context provided for future use?
3. **Clarity**: Will another agent understand this learning?
4. **No Conflicts**: Does this contradict existing rules?
5. **Proper Attribution**: Is task ID and date included?

---

## Review and Maintenance

### Regular Reviews
- Monthly: Review all auto-learned rules for accuracy
- Quarterly: Consolidate similar learnings
- Annually: Archive outdated learnings

### Red Flags (Require Human Review)
- Conflicting rules across skills
- High-risk changes (security, data integrity)
- Project-wide constraint updates
- Architectural changes

### Deprecation
When a learning becomes outdated:
- Add `[DEPRECATED]` tag with date and reason
- Provide replacement rule if applicable
- Keep for historical reference

---

## Integration with Orchestrator

The orchestrator tracks learning across all skills:
- Aggregates statistics in `runtime/learning-summary.json`
- Identifies patterns across multiple skills
- Flags skills that need knowledge sharing
- Monitors learning velocity and impact

---

## Success Metrics

Track these metrics for each skill:
- **Total learnings**: Number of rules added
- **Impact distribution**: High/Medium/Low counts
- **Learning velocity**: Rules per task
- **Application rate**: How often learnings are applied
- **Refinement rate**: How often rules are updated/deprecated

---

*This protocol ensures consistent, high-quality autonomous learning across all 26 agent skills.*
