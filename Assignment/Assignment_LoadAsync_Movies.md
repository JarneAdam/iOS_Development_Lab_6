# Assignment: Asynchronous Data Loading in Movies App

**Course:** iOS Development  
**Program:** Bachelor Applied Computer Science  
**Topic:** Async/Await and Data Loading with SwiftUI  
**Instructors:** Milan Dima, Dirk Hostens

---

## 📋 Introduction

In this assignment you will learn how to work with **asynchronous data loading** in SwiftUI. You will apply the `loadData()` function to your **Movies** application. This technique is essential when loading data from external sources such as JSON files, REST APIs, or databases. Navigation is done using a NavigationPath.

### Functionality of the Movies App

The Movies app offers the following functionalities:

- **List of movies**: Movies are loaded asynchronously and displayed in a list
- **Movie details**: Tap on a movie to view its details, including description, actors, and director
- **Actor navigation**: From a movie detail view, navigate to actor details
- **Director navigation**: From a movie detail view, navigate to director details
- Movies are sorted alphabetically by title

---

## 🎯 Learning Objectives

After this assignment you will be able to:

- ✅ Explain how async/await works in Swift
- ✅ Implement asynchronous functions in a DataStore class
- ✅ Add a loading state to your SwiftUI views
- ✅ Use the `.task` modifier for async operations
- ✅ Load JSON data and map it to model objects
- ✅ Value based navigation

![Movies Screenshot 0](images/Movies%20-%20Screenshot%200.png)
![Movies Screenshot 1](images/Movies%20-%20Screenshot%201.png)
![Movies Screenshot 2](images/Movies%20-%20Screenshot%202.png)
![Movies Screenshot 3](images/Movies%20Screenshot%203.png)

---

## 📚 Background: The MovieDataStore Class

### Overview of the MovieDataStore

The `MovieDataStore` class is an **Observable** data model that acts as the single source of truth for the application. Here is an overview of all functions:

| Function               | Purpose                                              | Parameters | Return  |
| ---------------------- | ---------------------------------------------------- | ---------- | ------- |
| `init()`               | Initializes an empty movies collection               | -          | -       |
| `sort()`               | Sorts movies alphabetically by title                 | -          | -       |
| `getMovies()`          | Returns all movies                                   | -          | [Movie] |
| `getMovies(actor:)`    | Returns movies featuring a specific actor            | Actor      | [Movie] |
| `getMovies(director:)` | Returns movies by a specific director                | Director   | [Movie] |
| `getActors(director:)` | Returns all unique actors who worked with a director | Director   | [Actor] |
| `loadData()`           | **Loads data asynchronously**                        | -          | async   |

### The loadData() Function in Detail

```swift
func loadData() async {
    //simulate async call
    do {
        print("⏳ Simulating 2-second load delay...")
        try await Task.sleep(for: .seconds(2)) // Simulate long load
        // load movies
        // sort
        print("✅ Data loaded successfully.")

    } catch {
        print("❌ Failed to load movies:", error)
        movies = Movies()
    }
}
```

#### What Does This Function Do?

1. **`async` keyword**: Marks the function as asynchronous - it can wait without blocking the UI
2. **`Task.sleep(for: .seconds(2))`**: Simulates a delay (like during a network call)
3. **`try await`**: Waits for the async operation and catches possible errors
4. **`load("movies.json")`**: Loads JSON data from the bundle
5. **`sort()`**: Sorts the loaded movies alphabetically
6. **Error handling**: On error, an empty Movies collection is set

#### Why Async?

- 🚫 **Without async**: The app would freeze during loading
- ✅ **With async**: The UI remains responsive, user sees loading indicator

---

## 🔧 Usage in MovieListView

### Step-by-Step Explanation

#### 1️⃣ Loading State

```swift
@State var loading = true
```

- Tracks whether data is still loading
- Starts at `true` because data hasn't been loaded yet
- Triggers UI update when value changes

#### 2️⃣ Conditional Rendering

```swift
if loading {
    //progressview
} else {
    //list
}
```

- **During loading**: Show ProgressView (spinner)
- **After loading**: Show the list of movies

#### 3️⃣ Task Modifier

```swift
.task {
    //load data async
    //loading is false
}
```

- `.task`: SwiftUI modifier that executes async code
- Automatically called when view appears
- `await`: Waits until loadData() is finished
- `loading = false`: Updates state to show list
- With the `.task` modifier you can directly call the async function `loadData()` as demonstrated above

#### 4️⃣ DataStore as Environment Object

The `MovieDataStore` class must be added as an `@Environment` object to your view:

```swift
@Environment(MovieDataStore.self) var dataStore
```

This ensures your DataStore is available throughout your view hierarchy.

**Using @Bindable for Two-Way Binding:**

When you need to create a binding to an `@Environment` object (for example, to use with `$` syntax for two-way binding), you need to use the `@Bindable` property wrapper:

```swift
@Environment(PathStore.self) var pathStore

var body: some View {
    @Bindable var pathStore = pathStore
    NavigationStack(path: $pathStore.path) {
        // ...
    }
}
```

- **`@Environment`**: Declares the environment object for read access
- **`@Bindable`**: Creates a bindable wrapper within the body to enable two-way binding with `$`
- This pattern is necessary when you need to pass a binding (like `$pathStore.path`) to SwiftUI components

#### 5️⃣ Navigation with NavigationStack

The Movies app uses programmatic navigation with NavigationStack and custom routes:

```swift
NavigationStack(path: $pathStore.path) {
    List(...) {movie in
        NavigationLink(value: Route.movie(movie)) {
            ...
        }
    }
    .navigationDestination(for: Route.self) { route in
        switch route {
            case let .actor(actor: actor):
                ActorDetailView(actor: actor)
            case let .director(director: director):
                ...
            case let .movie(movie: movie):
                ...
        }
    }
}
```

- **`NavigationStack(path:)`**: Creates a navigation stack with a custom path
- **`NavigationLink(value:)`**: Creates a navigation link with a typed route
- **`navigationDestination(for:)`**: Defines how to render each route type
- **Route enum**: Type-safe navigation using enums (actor, director, movie)

---

## 📦 Data Models

### Movie

```swift
struct Movie: Codable, Hashable {
    var title: String
    var description: String
    var actors: [Actor]
    var director: Director
    var releaseDate: String
}
```

### Actor

```swift
struct Actor: Codable, Hashable {
    var firstName: String
    var lastName: String
    var birthday: String
}
```

### Director

```swift
struct Director: Codable, Hashable {
    var firstName: String
    var lastName: String
    var moviesDirected: [String]
}
```

### Movies (Container)

```swift
struct Movies: Codable {
    var movies = [Movie]()
}
```

---

## 📖 Useful Resources

- [Swift Concurrency Documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [SwiftUI Task Modifier](<https://developer.apple.com/documentation/swiftui/view/task(priority:_:)>)
- [Observable Macro](<https://developer.apple.com/documentation/observation/observable()>)
- [NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack)

---

**Good luck! 🎉**
