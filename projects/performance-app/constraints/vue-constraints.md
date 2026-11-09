# Vue Constraints: performance-app

These constraints govern all Vue 3 frontend development within `performance-app`.

---

## Composition API & Component Style

- **Always use** `<script setup>` syntax (Composition API) for new components — no Options API
- Use `defineProps`, `defineEmits`, `defineExpose` macros — never use `withDefaults` on required props
- Keep `<script setup>` blocks focused on orchestration; extract reusable logic to composables
- Template logic must be minimal — use computed properties and composables for transformations

## State Management

### Server State — TanStack Query (via `@shrfe/vue-lib`)
- All API calls must go through TanStack Query composables — **never call Axios/HTTPBaseService directly in components or views**
- Query composables follow the `useXxxApi` naming pattern and live in `src/modules/performance/composables/`
- Query keys are centralised in `src/modules/performance/const/queryKeys.ts` — no inline string keys
- Use `useQuery` for reads, `useMutation` for writes
- Composables must handle loading, error, and empty states explicitly
- On mutation success, invalidate the relevant query keys to keep the cache consistent

### Client State — Vuex 4
- Use Vuex **only** for shared cross-component state that is not server state (e.g., selected department, active filters used across multiple views)
- All stores **must** be namespaced (`namespaced: true`)
- Module store lives in `src/modules/performance/store/`; root store in `src/store/`
- Use `useStore` composition API — avoid `mapState`/`mapActions` in `<script setup>` components

## HTTP & API Layer

- **HTTP client**: `@shrfe/core` HTTPBaseService — configured in `src/config/config.ts`
- API service files live in `src/modules/performance/api/` — one file per domain entity (e.g., `okr.ts`, `appraisal.ts`)
- API service functions are plain functions (not classes) that accept typed parameters and return typed promises
- All API endpoint paths follow: `${SHR_API_BASE_URL}/hrms/api/v1/performance/*`

## Routing

- Route names and paths are defined in `src/modules/performance/routes.ts` — no inline route strings
- Route name constants live in `src/modules/performance/const/routes.ts`
- Use `<RouterLink>` with named routes — avoid path strings in templates
- Lazy-load views where practical to reduce initial bundle size

## Component Architecture

- **Views** (`views/`) are thin orchestrators — they compose layout, pass props to child components, and wire up composables. No business logic in views.
- **Components** (`components/`) are reusable, entity-focused Vue SFCs. Named using PascalCase by entity (e.g., `AppraisalHistoryModal.vue`, `ObjectiveOkrForm.vue`)
- Global reusable components live in `src/components/`; module-specific components in `src/modules/performance/components/`
- Emit events for parent communication — avoid prop drilling more than 2 levels; use `provide/inject` or Vuex for deeper hierarchies
- Use `v-model` with `defineModel` (Vue 3.4+) or `defineProps`/`defineEmits` pair for two-way binding

## Accessibility

- All interactive elements must have descriptive `aria-label` or visible text
- Use semantic HTML (`<button>`, `<nav>`, `<main>`, `<section>`) — avoid `<div>` for interactive elements
- Form inputs must be paired with `<label>` elements
- Keyboard navigation must work for all interactive UI elements

## E2E Testing Integration

- Add `data-testid` attributes to all interactive elements (buttons, inputs, modals, list items) to support Puppeteer selectors
- Naming convention: `data-testid="[entity]-[action]"` (e.g., `data-testid="objective-create-btn"`, `data-testid="appraisal-submit-btn"`)
- ARIA attributes take priority over `data-testid` for E2E selectors — ensure they are accurate

## Code Style

- PascalCase for component filenames and component names
- camelCase for composable filenames (e.g., `useGetObjectivesApi.ts`)
- kebab-case for CSS class names and custom events
- Group template sections: `v-if`/`v-show` before `v-for`; avoid both on the same element
- Use `v-if` for conditional rendering that changes infrequently; `v-show` for frequent toggling

## Performance

- Lazy-load heavy components and views using `defineAsyncComponent` or router-level lazy loading
- Avoid reactive declarations on large, static datasets — use `shallowRef` or `markRaw` where appropriate
- Minimise watchers; prefer computed properties
- Use Webpack's code splitting (already configured) — do not import entire libraries where tree-shaking works

## Testing

- Test files: `tests/unit/*.spec.ts`
- Use `@vue/test-utils` `mount`/`shallowMount` — prefer `mount` for integration-style tests
- Mock `@shrfe/vue-lib` TanStack Query hooks at the composable level — do not mock HTTP responses directly
- Test user interactions and rendered output, not implementation internals
- Minimum 75% line coverage per module
