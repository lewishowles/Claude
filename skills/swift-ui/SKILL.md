---
name: swift-ui
description: Use this skill when building or reviewing SwiftUI views, navigation, state, bindings, and performance in *.swift files. Covers @Observable, @Bindable, view composition, NavigationStack, anti-patterns such as ObservableObject and @Published, and responsive interfaces. Pair with swift.
related-skills:
  - swift
  - code-style
  - accessibility
---

# SwiftUI patterns

Modern SwiftUI, iOS 26+ / macOS 26+. `@Observable` over legacy `ObservableObject`. Type-safe navigation. Performance-aware view composition.

## State management

### Property wrapper selection

Choose by scope and mutability:

| Wrapper | Scope | Mutability | Use case |
|---------|-------|-----------|----------|
| `@State` | Single view | Mutable | Simple local state (toggle, text field) |
| `@Binding` | Parent ↔ child | Mutable | Pass mutable state to child |
| `@Observable` | View model | Mutable | Multi-view shared state (modern, recommended) |
| `@Bindable` | Observable access | Mutable binding | Get bindings from Observable in `@Environment`-injected models |
| `@Environment` | App-wide | Read-only | Access app-level config or services |
| `@EnvironmentObject` | App-wide | Deprecated | Use `@Environment` + `@Observable` instead |

### @Observable view model pattern

Replace `ObservableObject` + `@Published` + `@StateObject` with `@Observable`:

```swift
import Observation

@Observable
@MainActor
final class ProjectViewModel {
  var projects: [Project] = []
  var selectedProjectID: UUID?
  var isLoading = false

  func loadProjects() async {
    isLoading = true
    defer { isLoading = false }
    projects = await ProjectService.fetch()
  }
}

struct ProjectView: View {
  @State var model = ProjectViewModel()

  var body: some View {
    List(model.projects) { project in
      ProjectRow(project: project)
    }
    .task {
      await model.loadProjects()
    }
  }
}
```

### Environment injection pattern

Inject Observable models via `@Environment`, access with `@Bindable`:

```swift
// In parent
.environment(authModel)

// In child
struct LoginView: View {
  @Environment(AuthViewModel.self) var auth

  var body: some View {
    // Read-only access to auth state
    Text(auth.username)
  }
}

// For mutable bindings, use @Bindable
struct SettingsView: View {
  @Environment(SettingsViewModel.self) var settings

  var body: some View {
    Form {
      @Bindable var settings = settings
      Toggle("Notifications", isOn: $settings.notificationsEnabled)
    }
  }
}
```

## View composition

### Subview extraction

Avoid re-rendering entire view tree on local state change. Extract sub-views with own `@State`:

```swift
struct ContentView: View {
  @State var activeTab = 0

  var body: some View {
    TabView(selection: $activeTab) {
      Tab1View()  // own @State, doesn't re-render with activeTab change
      Tab2View()
    }
  }
}

struct Tab1View: View {
  @State var textInput = ""

  var body: some View {
    TextField("Enter...", text: $textInput)
  }
}
```

### ViewModifier pattern

Reusable styling and behaviour:

```swift
struct PrimaryButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(Color.blue)
      .foregroundColor(.white)
      .cornerRadius(8)
  }
}

extension View {
  func primaryButton() -> some View {
    modifier(PrimaryButtonModifier())
  }
}

Button("Submit") { }
  .primaryButton()
```

## Navigation

### Type-safe NavigationStack

Enum-based routing + `NavigationPath` for type-safe navigation:

```swift
enum Route: Hashable {
  case projectDetail(id: UUID)
  case settings
  case about
}

struct ContentView: View {
  @State var navigationPath = NavigationPath()

  var body: some View {
    NavigationStack(path: $navigationPath) {
      List(projects) { project in
        NavigationLink(value: Route.projectDetail(id: project.id)) {
          Text(project.name)
        }
      }
      .navigationDestination(for: Route.self) { route in
        switch route {
        case .projectDetail(let id):
          ProjectDetailView(id: id)
        case .settings:
          SettingsView()
        case .about:
          AboutView()
        }
      }
    }
  }
}
```

## Performance optimization

### LazyVStack / LazyHStack

Use for large collections — renders only visible rows:

```swift
ScrollView {
  LazyVStack(spacing: 0) {
    ForEach(largeList, id: \.id) { item in
      ItemRow(item: item)
    }
  }
}
```

### Stable identifiers in ForEach

Always `id: \.id`, not implicit integer index:

```swift
// GOOD
ForEach(items, id: \.id) { item in
  ItemView(item: item)
}

// BAD — reorders cause wrong animations/state
ForEach(items, id: \.self) { item in
  ItemView(item: item)
}
```

### Avoid expensive work in body

Move I/O, heavy computation, DB queries into `.task {}`:

```swift
struct DetailView: View {
  @State var data: Data?

  var body: some View {
    VStack {
      Text(data?.name ?? "Loading...")
    }
    .task {
      // NOT in body — runs once
      data = await fetchData()
    }
  }
}
```

### Equatable conformance for expensive views

Conform to `Equatable`, use `.equatable()` to skip re-renders when props unchanged:

```swift
struct ExpensiveView: View, Equatable {
  let data: Data
  let onAction: () -> Void

  var body: some View {
    // Expensive layout/rendering
  }

  static func == (lhs: ExpensiveView, rhs: ExpensiveView) -> Bool {
    lhs.data.id == rhs.data.id
  }
}

// In parent, use with .equatable()
ExpensiveView(data: data, onAction: handler)
  .equatable()
```

## Previews

### #Preview macro pattern

Modern Xcode preview macro with mock data:

```swift
struct ProjectDetailView: View {
  let project: Project

  var body: some View {
    VStack {
      Text(project.name)
    }
  }
}

#Preview {
  ProjectDetailView(
    project: Project(
      id: UUID(),
      name: "Sample Project",
      description: "A test project"
    )
  )
}
```

## Anti-patterns to avoid

- **ObservableObject + @Published** — use `@Observable` instead
- **@StateObject** — use `@State` + `@Observable` instead
- **@EnvironmentObject** — use `@Environment` + Observable instead
- **AnyView type erasure** — use conditional view composition instead
- **Async work in body or init** — use `.task {}` or `.onAppear {}`
- **Creating view models in child views** — inject from parent
- **Ignoring Sendable** — @MainActor-annotated view models are Sendable automatically

> Modified from [ECC `swiftui-patterns`](https://github.com/affaan-m/everything-claude-code/blob/main/skills/swiftui-patterns/SKILL.md) — MIT © 2026 Affaan Mustafa. Adapted to integrate existing macOS app patterns and focus on iOS 26+ / macOS 26+ @Observable framework.
