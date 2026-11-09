# Project Description: bcw-performance-management

## What This Project Is

`bcw-performance-management` (package: `@shrfe/bcw-performance-management-app`) is the BCW (Business Channel Web) performance management micro-frontend — a Stencil.js Web Component application built and distributed as an embeddable custom element. It is an enterprise HR frontend that enables organisations to manage the full performance lifecycle including appraisal cycles, line manager dashboards, criteria metrics, and policy configurations.

## Domain Coverage

| Domain | Key Entities |
|--------|-------------|
| **Performance Appraisal** | Appraisal cycles, periods, participants (departments), cycle stats |
| **Line Manager** | Manager dashboard, team performance, pending appraisals, team cards |
| **Configurations** | Criteria metrics (scoring), policies, appraisal templates |
| **Auth** | Login, token management, 401 handling |
| **Home View** | Application landing / home page |

## Architecture

- **Type**: Stencil.js Web Component SPA — compiled to a native custom element (`swc-bcw-performance-management-app`)
- **Distribution**: Embeddable via npm package (`dist/`) or served standalone (`www/`)
- **Root component**: `src/entry.tsx` — `swc-bcw-performance-management-app`
- **Router**: `@gen2tech/stencil-router` (browser or hash history, configurable via `historyMode` prop)
- **Route prefix**: Configurable via `routePrefix` prop

## Module Structure

Each feature lives under `src/modules/{module-name}/`:
```
src/modules/{module}/
├── pages/          # Page-level Stencil components (entry points for routes)
├── components/     # Reusable child Stencil components
├── services/       # HTTP service files (one per domain entity)
├── types/          # TypeScript type definitions
└── index.ts        # Module exports
```

Key modules:
- `performance-appraisal/` — Appraisal cycle CRUD, periods, participants
- `line-manager/` — Manager dashboard, teams, pending appraisals
- `configurations/` — Criteria metrics + policies
- `auth/` — Login component and login service

## API Integration

- **Base URL**: `process.env.SHR_API_BASE_URL` (from `.env`)
- **Protocol**: RESTful JSON API
- **Auth**: Bearer token via `tokenService.getToken()`; 401 → clear token + redirect to `/bcw-performance-management-app/login`
- **HTTP Client**: `@shrfe/core` HttpService — configured in `src/services/http.ts` with request/error interceptors
- **Never** import raw `fetch` or `axios` in services — always use the configured `http` instance

## Tech Stack Summary

| Layer | Technology |
|-------|-----------|
| Framework | Stencil 4.27.2 (Web Components compiler) |
| Language | TypeScript 5.5.3 |
| Build | Stencil compiler + Rollup (package) + SASS |
| Styling | SCSS (component-scoped), `@shrfe/assets` shared styles |
| State | `@stencil/store` 2.0.16 (lightweight reactive store) |
| Routing | `@gen2tech/stencil-router` |
| HTTP | `@shrfe/core` HttpService (interceptors for auth + error handling) |
| Testing | Jest 29.7.0 + jsdom, Puppeteer 24.2.0 |
| Linting | ESLint + Prettier + StyleLint via `@shrfe/format-config` |
| Git hooks | Lefthook 1.2.2 |
| Package manager | Yarn 4.6.0 (Corepack) |
| Node.js | >= 22.14.0 |

## Path Aliases (tsconfig)

| Alias | Resolves to |
|-------|------------|
| `@/*` | `src/*` |
| `@modules/*` | `src/modules/*` |
| `@services/*` | `src/services/*` |
| `@config/*` | `src/config/*` |
| `@components/*` | `src/components/*` |
| `@assets/*` | `src/assets/*` |

## Repository Location

`/Users/temidayoomoyajowo/web_path/bcw-performance-management`

## Entry Points

- Root component: `src/entry.tsx`
- Module index: `src/index.ts`
- Routes: `src/routes.ts`
- Store: `src/store.ts`
- HTTP service: `src/services/http.ts`
- Config: `src/config/config.ts`
- Stencil config: `stencil.config.ts`
- Dev server: `yarn start` (port 3333)
- Production build: `yarn build` → `dist/` + `www/`
