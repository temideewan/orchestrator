# Project Description: performance-app

## What This Project Is

`performance-app` is the SeamlessHR performance management module — a Vue 3 Single-Page Application (SPA) built on the `@shrfe/vue-base-app` boilerplate. It is an enterprise HR frontend that enables organisations to manage the full performance lifecycle for their employees.

## Domain Coverage

The app owns the following HR performance management domains:

| Domain | Key Entities |
|--------|-------------|
| **Objectives** | OKRs (Objectives & Key Results), KPIs (BSC-style Key Performance Indicators) |
| **Key Results** | Sub-goals attached to OKRs |
| **Appraisals** | Employee performance evaluations, appraisal cycles/periods, matrix appraisals |
| **Performance Reviews** | Peer and manager reviews, review reports |
| **Exceptional Achievements** | EA/ESS recognition and tracking |
| **PIPs** | Performance Improvement Plans — creation, detail, and list management |
| **Settings** | Admin configuration for appraisal templates, weightings, and workflows |
| **Analytics** | Performance data aggregation and reporting |

## Architecture

- **Type**: SPA (no server-side rendering, no backend code in this repo)
- **Module pattern**: All functionality lives under `src/modules/performance/` following the `@shrfe/vue-base-app` module contract:
  - `entry.ts` — exports `{ routes, store }` for registration at app bootstrap
  - `routes.ts` — 14+ route definitions (objectives, appraisals, reviews, PIPs, settings, analytics)
  - `store/` — Namespaced Vuex 4 store for shared state (departments, job roles, currencies, etc.)
  - `api/` — 14 API service files wrapping `@shrfe/core` HTTPBaseService
  - `composables/` — 110 TanStack Query composables (`useXxxApi` pattern)
  - `components/` — ~80 Vue SFCs named by entity convention
  - `views/` — 14 thin page components (entry points for routes)
  - `types/` — TypeScript definitions for all domain entities
  - `const/` — Route names, query keys, workflow constants

## API Integration

- **Base URL**: `${SHR_API_BASE_URL}/hrms` (from env vars)
- **Protocol**: RESTful JSON API
- **Auth**: Token-based; auto-refresh at `/api/v1/auth/refresh` via `@shrfe/core`
- **Key API namespaces**: `/api/v1/performance/*` for all performance domain endpoints
- **HTTP Client**: `@shrfe/core` HTTPBaseService (Axios-based) — never imported directly

## Tech Stack Summary

| Layer | Technology |
|-------|-----------|
| Framework | Vue 3.2.41 |
| Language | TypeScript 5.1.x |
| Build | Webpack 5, Babel 7 |
| State (server) | TanStack Query via `@shrfe/vue-lib` |
| State (client) | Vuex 4.x (namespaced stores) |
| Routing | Vue Router 4.x |
| HTTP | `@shrfe/core` HTTPBaseService (Axios) |
| Testing | Jest 29.3.1, @vue/test-utils 2.2.6 |
| Linting | ESLint 8.26, Prettier 2.7.1, StyleLint 15.3 |
| Git hooks | Lefthook 1.2.2 |
| Package manager | Yarn 4.6.0 (Corepack) |
| Node.js | >= 18.12.0 |

## Repository Location

`/Users/temidayoomoyajowo/web_path/performance-app`

## Entry Points

- App bootstrap: `src/bootstrap.ts`
- Module entry: `src/modules/performance/entry.ts`
- Webpack config: `webpack.config.js`
- Dev server: `yarn serve` (port 8080)
- Production build: `yarn build` → `dist/`
