# Server Driven User Interface x Flutter Firebase

This project demonstrates how to build a **Server-Driven User Interface (SDUI)** using **Flutter** and **Firebase Remote Config**. The app dynamically fetches UI configurations from Firebase Remote Config and renders the UI based on the server-provided JSON data.

---

## Features

- **Dynamic UI Rendering**: Fetch UI configurations from Firebase Remote Config and render them dynamically.
- **Firebase Integration**: Uses `Firebase Remote Config`, `Firebase Authentication`, and `Firebase Core`.
- **State Management**: Implements `flutter_bloc` for managing app state.
- **Dependency Injection**: Uses `get_it` for dependency injection.
---

## Future Improvements
 - JSON Response could have been converted custom modular dart classes, currently using Json Decoded response due to limited time.
 - Fixed Response JSON Schema across all modules.
 - FallBack mechanism if JSON couldn't be parsed.
 - Cache responses to save unnecessary APIs.


