# Stencil Constraints: bcw-performance-management

These constraints govern all Stencil.js component development within `bcw-performance-management`.

---

## Component Declaration Rules

- Use `@Component` decorator with `tag`, `styleUrl`, and `shadow: false` (or `scoped: true` for style isolation)
- All component tags must be prefixed with `swc-` (e.g., `swc-appraisal-table`, `swc-stat-card`)
- Component file names must match their tag name in kebab-case (e.g., `appraisal-table.tsx`)
- One component per file — no co-located component declarations

```tsx
// Correct
@Component({
  tag: 'swc-appraisal-table',
  styleUrl: 'appraisal-table.scss',
  scoped: true,
})
export class AppraisalTable { ... }
```

## Props & State

- Use `@Prop()` for inputs from parent — always typed, always documented with JSDoc
- Use `@State()` for internal reactive state — never use class properties directly for reactive values
- Use `@Watch()` to react to `@Prop()` changes — do not rely on constructor for prop-dependent setup
- `@Prop({ reflect: true })` only for attributes that need to be reflected to DOM (e.g., boolean flags)
- Mark props as `readonly` — never mutate a `@Prop()` directly; emit events instead

```tsx
@Prop() cycleId!: string;         // Required prop — use non-null assertion
@Prop() loading: boolean = false; // Optional prop with default
@State() private cycles: AppraisalCycle[] = [];
```

## Events & Communication

- Use `@Event()` for child → parent communication — never call parent methods directly
- Event names: camelCase without "on" prefix in the decorator, consumers listen with `onEventName`
- Use `@Listen()` only for document-level or host-element events — prefer passing callbacks for component interaction

```tsx
@Event() cycleSelected: EventEmitter<string>;

// Emit:
this.cycleSelected.emit(cycle.id);

// Parent listens:
<swc-appraisal-table onCycleSelected={(e) => this.handleCycleSelected(e.detail)} />
```

## Lifecycle Methods

- `connectedCallback()` — set up subscriptions, fetch initial data
- `disconnectedCallback()` — clean up subscriptions, cancel in-flight requests
- `componentWillLoad()` — sync setup before first render; return a `Promise` to defer rendering
- `componentDidLoad()` — DOM-dependent setup (avoid where possible; prefer reactive rendering)
- Do not use `componentWillUpdate()` / `componentDidUpdate()` for data fetching — use `@Watch()` instead

## State Management with `@stencil/store`

- Use `@stencil/store` only for app-wide shared state (e.g., `meta` config passed from host app)
- Keep store data minimal — component-local state belongs in `@State()`
- Store lives in `src/store.ts`; import with `import store from '@/store'`
- Never put API response data in the global store — keep it in component `@State()`

## HTTP & Services

- All API calls go through service files in `src/modules/{module}/services/` 
- Service files export plain async functions (not classes) — typed parameters, typed return values
- Use the configured `http` instance from `@services/http` — never raw `fetch`
- Handle loading and error states in `@State()` — always show loading indicators and error messages

```tsx
// Correct service usage
import { listAppraisalCycles } from '@modules/performance-appraisal/services/appraisal-cycle.service';

// In component:
@State() cycles: AppraisalCycle[] = [];
@State() loading = false;
@State() error: string | null = null;

async fetchCycles() {
  this.loading = true;
  try {
    this.cycles = await listAppraisalCycles();
  } catch (e) {
    this.error = 'Failed to load appraisal cycles';
  } finally {
    this.loading = false;
  }
}
```

## Routing

- Routes are defined in `src/routes.ts` and module-level route files — never inline in components
- Use `@gen2tech/stencil-router` `<stencil-route-link>` for navigation — never `window.location` directly
- Route paths must include the app prefix — use the `routePrefix` prop for configurability
- Lazy-load heavy page components via `component` prop on `<stencil-route>` with dynamic import

## Styling

- Use component-scoped SCSS (`scoped: true` in `@Component`) — prevents style leakage
- Global styles belong in `src/assets/styles/` or `src/entry.css`
- Use `@shrfe/assets` design tokens and shared styles where available — do not redefine colours, spacing, or typography
- CSS custom properties (variables) preferred over hardcoded values
- Never use `!important` — fix specificity issues with proper selector structure

## Accessibility

- All interactive elements must have descriptive `aria-label` or visible text
- Use semantic HTML (`<button>`, `<nav>`, `<main>`, `<section>`) — avoid `<div>` or `<span>` for interactive elements
- Form inputs must be paired with `<label>` elements (use `htmlFor` / `id` linkage)
- Keyboard navigation must work for all interactive UI elements
- Add `data-testid` attributes to all interactive elements for E2E testing

## E2E Testing Integration

- Add `data-testid` attributes to all interactive elements (buttons, inputs, modals, table rows, form fields)
- Naming convention: `data-testid="[module]-[entity]-[action]"` (e.g., `data-testid="appraisal-cycle-create-btn"`, `data-testid="line-manager-teams-tab"`)
- ARIA attributes take priority over `data-testid` for E2E selectors — ensure they are accurate and stable

## Code Style

- PascalCase for component class names (e.g., `AppraisalTable`)
- kebab-case for component tag names and file names
- camelCase for service function names and TypeScript variable/function names
- Group render method sections: slots → conditional panels → main content
- Keep `render()` methods focused — extract complex JSX into private helper methods

## Performance

- Avoid unnecessary `@State()` that triggers full re-renders — use `@State()` only for data that drives UI
- Use `shallowEqual` or immutable updates for array/object state to avoid excessive re-renders
- Lazy-load routes and heavy components
- Avoid fetching data in `render()` — always fetch in lifecycle methods or `@Watch()` handlers

## Testing

- Test files: `*.spec.ts` alongside source files
- Use Stencil's `newSpecPage()` for component unit tests
- Mock service imports with `jest.mock()` — do not make real HTTP calls in unit tests
- Test component output (rendered HTML) and emitted events, not internal state
