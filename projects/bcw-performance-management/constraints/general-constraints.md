# General Constraints: bcw-performance-management

These constraints apply across all work on the `bcw-performance-management` project, regardless of which skill is executing.

---

## Environment & Tooling

- **Node.js**: >= 22.14.0 (enforced by package.json `engines`)
- **Package manager**: Yarn 4.6.0 via Corepack — always use `yarn`, never `npm`
- **Enable Corepack**: `corepack enable` before first install on a new machine
- **Install dependencies**: `yarn` or `yarn install` (triggers `postinstall: get-assets`)

## Code Quality Gates (All Must Pass Before Merge)

```bash
yarn format   # runs ESLint + Prettier + StyleLint — must exit with zero warnings
yarn test     # runs Jest unit tests — must pass with no failures
```

- **ESLint**: via `@shrfe/format-config` — TypeScript-aware, zero warnings tolerance
- **Prettier**: via `@shrfe/format-config` — enforced formatting, do not override `.prettierrc.js`
- **StyleLint**: via `@shrfe/format-config` — CSS/SCSS linting, do not override `.stylelintrc.js`
- **Lefthook**: Pre-commit/pre-push hooks run lint checks automatically — never skip with `--no-verify`

## TypeScript

- **Config**: `tsconfig.json` with Stencil-compatible settings — no `any` types
- **No `@ts-ignore`** unless accompanied by a documented reason in a comment
- **No implicit `any`** — all function parameters and return types must be typed
- Use path aliases (`@modules/*`, `@services/*`, `@config/*`) — never use relative `../../..` imports beyond 2 levels

## Module Structure Rules

- Feature modules live under `src/modules/{module-name}/` — lowercase or kebab-case folder names
- Service files live in `src/modules/{module}/services/` or `src/services/` for cross-cutting concerns
- Types live in `src/modules/{module}/types/`
- Shared/reusable components live in `src/components/`
- Never import between sibling modules directly — go through `src/index.ts` exports or `src/services/`

## HTTP & Auth Rules

- **Always** use the configured `http` instance from `src/services/http.ts` — never raw `fetch` or `axios`
- The `http` service automatically attaches Bearer tokens and handles 401 redirects
- API base URL must come from `src/config/config.ts` (reads `process.env.SHR_API_BASE_URL`) — never hardcode URLs
- Encryption key accessed via `src/config/config.ts` only — never read `process.env.SHR_ENCRYPTION_KEY` directly

## Environment Variables

- Copy `.env` before running — never commit `.env` files (they are in `.gitignore`)
- Access env vars only through `src/config/config.ts` — do not read `process.env` directly in modules or components
- Required env vars: `SHR_API_BASE_URL`, `SHR_ENCRYPTION_KEY`, `SHR_NAMESPACE`, `SHR_FULLCALENDAR_KEY`

## Testing

- **Framework**: Jest 29.7.0 with jsdom environment
- **Test location**: `src/**/*.spec.ts` alongside source files
- **No test skips** without a documented reason and linked ticket
- Test component rendering and user interactions — not internal implementation details

## Git & CI/CD

- CI runs in GitHub Actions (`.github/workflows/`) — builds must pass before merging
- Pre-commit/pre-push hooks (Lefthook) enforce lint/format — fix issues, do not bypass hooks
- Docker support via `docker-compose.yml` + `Dockerfile.dev` for consistent environments

## Security

- Never log tokens, passwords, or PII — use `@shrfe/core` encryption utilities
- Validate all user inputs before sending to API (TypeScript types + runtime checks)
- Use the `http` service from `src/services/http.ts` for all API calls — it handles token refresh and auth errors
- Never hardcode API base URLs — always use `config.apiBaseUrl` from `src/config/config.ts`
- 401 handling is in the HTTP error interceptor — do not duplicate auth redirect logic in components

## Dependencies

- Add new dependencies with `yarn add` (prod) or `yarn add -D` (dev)
- Prefer `@shrfe/*` shared packages over equivalent third-party packages that duplicate shared library functionality
- Do not add jQuery, Lodash (use native equivalents), or packages that significantly increase bundle size without justification
- Stencil components from external packages must be added to `stencil.config.ts` `collections` if needed
