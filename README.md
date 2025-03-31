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
---
## Getting Started - Firebase Remote Config
- Create new firebase project or utilise existing one.
- Under `Build` >> `Remote Config`.
- Add new Parameter and give a name `dashboard_screen`
- Select the data type to be `JSON`
- Add a default value to the key, here a `JSON` object
- Save and Publish the response
---

## Debug Considerations
- This repository majorly focuses on achieving the SDUI and not on look and feel of the app.
- I've not binded many parameters originally planned for this repository.
- `App Theme`, `Dashboard`, `Login` & `Logout` has been integrated with bare minimum fields.
---
## Personal Opinion
- I genuinely feel its going to be difficult for devs to extend modules overtime, when app needs to be scalled.
- We may encounter run-time errors, could've been caught over pure client-side development process.
- The app only becomes available if there's internet, complete offline mechanism as an option gets ruled out.
- Complete dependency over manual layout of components, instead of Interactive `Builders`.
- Inaccurate initialization of `controllers`, `subscriptions` & `listeners`. 