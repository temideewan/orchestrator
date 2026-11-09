# General Constraints: performance-app

These constraints apply across all work on the `performance-app` project, regardless of which skill is executing.

---

## Environment & Tooling

- **Node.js**: >= 18.12.0 (enforced by package.json `engines`)
- **Package manager**: Yarn 4.6.0 via Corepack — always use `yarn`, never `npm`
- **Enable Corepack**: `corepack enable` before first install on a new machine
- **Install dependencies**: `yarn` or `yarn install`

## Code Quality Gates (All Must Pass Before Merge)

```bash
yarn format   # runs ESLint + Prettier + StyleLint — must exit with zero warnings
yarn test     # runs Jest unit tests — must pass with no failures
```

- **ESLint**: 8.26.0 — TypeScript-aware, zero warnings tolerance
- **Prettier**: 2.7.1 — enforced formatting, do not override `.prettierrc.js` rules
- **StyleLint**: 15.3.0 — CSS/SCSS linting, do not override `.stylelintrc.js` rules
- **Lefthook**: Pre-commit hook runs lint checks automatically — never skip with `--no-verify`

## TypeScript

- **Strict mode**: `tsconfig.json` has `strict: true` — no `any` types
- **No `@ts-ignore`** unless accompanied by a documented reason in a comment
- **No implicit `any`** — all function parameters and return types must be typed

## Module Structure Rules

- Module folder names **must** be lowercase or kebab-case (e.g., `performance`, `my-module`)
- Every module **must** export `{ routes, store? }` from its `entry.ts`
- Vuex stores **must** be namespaced (`namespaced: true`)
- Route names and query keys must be defined in `const/` — no magic strings in components

## Environment Variables

- Copy `.env.example` to `.env.development` (dev) or `.env.production` (prod) before running
- Never commit `.env.*` files (they are in `.gitignore`)
- Access env vars only through the config layer (`src/config/config.ts`) — do not read `process.env` directly in components or composables

## Testing

- **Framework**: Jest 29.3.1 with `@vue/test-utils` 2.2.6
- **Minimum coverage**: 75% line coverage per module
- **Test location**: `tests/unit/` for unit tests; follow existing file naming `*.spec.ts`
- **No test skips** without a documented reason and linked ticket

## Git & CI/CD

- CI runs in GitHub Actions (`.github/workflows/`) — builds must pass before merging
- Pre-commit hooks (Lefthook) enforce lint/format — fix issues, do not bypass hooks
- Docker support available via `docker-compose.yml` + `Dockerfile.dev` for consistent environments

## Security

- Never log tokens, passwords, or PII — use the `@shrfe/core` encryption utilities
- Validate all user inputs before sending to API (use TypeScript types + runtime checks where needed)
- Use the provided `@shrfe/core` HTTPBaseService for all API calls — it handles token refresh and auth error handling
- Do not hardcode API base URLs — always use `SHR_API_BASE_URL` from config

## Dependencies

- Add new dependencies with `yarn add` (prod) or `yarn add -D` (dev)
- Prefer `@shrfe/*` shared packages over installing equivalent third-party packages that duplicate functionality already in the shared library
- Do not add jQuery, Lodash (use native equivalents), or other packages that significantly increase bundle size without justification
