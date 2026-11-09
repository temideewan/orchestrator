# td-orchestrator

A multi-project AI orchestration system built on the [Orchestrator Pattern](https://github.com). Manages specialist AI agents across multiple software projects with persistent task tracking, spec-driven development, and autonomous learning.

---

## Quick Start

### 1. Set up credentials

```bash
cp .env.example .env
# Edit .env with your Airtable token, base ID, and Telegram bot details
```

### 2. Run the orchestrator

Open this folder in Claude Code, then:

```
/orchestrator start count=3 project=MyProject
```

Or interact directly:

```
/orchestrator status
```

---

## Adding a Project

1. Create the project directory:
   ```bash
   mkdir -p projects/my-project/constraints
   ```

2. Write the constraint files:
   - `projects/my-project/constraints/project-description.md` — what the project is, tech stack, repos
   - `projects/my-project/constraints/general-constraints.md` — coding standards, testing rules, commit format
   - Add domain-specific files as needed: `backend-constraints.md`, `frontend-constraints.md`, etc.

3. Create a project state file:
   - `projects/my-project/project-state.md` — current phase, active tickets, repo list

4. Create skills for the project:
   ```bash
   mkdir -p .claude/skills/my-project-backend
   # Copy and fill in _shared/skill-template.md → SKILL.md
   # Copy and fill in _shared/knowledge-bank-template.md → knowledge.md
   ```

5. Register the skill in `runtime/skill-registry.json` and the project in `runtime/value-streams.json`.

---

## Directory Structure

```
td-orchestrator/
├── .claude/skills/
│   ├── orchestrator/         Central routing agent
│   ├── _shared/              Templates for creating new skills
│   └── {project}-{domain}/   Specialist agents (added per project)
├── projects/                 Project constraints and state
├── runtime/                  System state (JSON files)
├── scripts/
│   ├── airtable/             Task management scripts
│   └── telegram/             Notification and approval scripts
├── templates/spec/           Spec templates (micro / standard / full)
└── memory/                   Claude Code persistent memory (git-tracked)
```

---

## Airtable Setup

Create a base with a **Tasks** table using these fields:

| Field | Type |
|-------|------|
| Task Name | Text |
| Description | Long text |
| Status | Single select: `TO_DO`, `SPEC_IN_PROGRESS`, `SPEC_READY`, `WAITING_SPEC_APPROVAL`, `IMPLEMENTING`, `WAITING_FOR_REVIEW`, `DONE` |
| Priority | Single select: `Low`, `Medium`, `High`, `Urgent` |
| Project | Text |
| Spec Link | URL |
| Assigned To | Text |
| Due Date | Date |
| Completion (%) | Number |

Scripts: `scripts/airtable/airtable-{read,write,create,comment}.sh`

---

## Telegram Setup

1. Message `@BotFather` on Telegram → `/newbot` → save the token
2. Send a message to your bot, then call `https://api.telegram.org/bot{TOKEN}/getUpdates` to get your chat ID
3. Add both to `.env`

Spec approval flow:
- Orchestrator uploads spec → sends `SPEC-042: approved` or `SPEC-042:rejected <reason>`
- `scripts/telegram/wait-for-approval.sh` handles progressive backoff polling

---

## Model Routing

| Model | Used for |
|-------|----------|
| opus | Orchestrator, planners, quality review, spec production, security |
| sonnet | Backend, frontend, mobile, test, infrastructure, API design |
| haiku | Documentation, notifications, resource tracking |

---

## Learning System

Each skill automatically updates its `knowledge.md` after tasks when it discovers new patterns (Medium/High impact, low risk, no conflicts). The orchestrator aggregates stats in `runtime/learning-summary.json`.

See `.claude/skills/_shared/learning-protocol.md` for the full auto-update decision tree and format.
