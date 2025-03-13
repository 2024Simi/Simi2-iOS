# Simi2-iOS Development Guide

## Project Structure
- iOS app using modular architecture with Core, DesignSystem, Feature modules
- Tuist used for project generation and dependency management

## Build & Run Commands
- Generate project: `tuist generate`
- Build app: Open in Xcode and use ⌘+B
- Run app: Open in Xcode and use ⌘+R
- Run single test: Select test in test navigator and click run button or ⌃+⌘+U

## Code Style Guidelines
- **Naming**: Use camelCase for variables/functions, PascalCase for types
- **Types**: Always specify types explicitly for public APIs
- **Imports**: Group imports by modules, Swift standard library first
- **Components**: Follow MVVM pattern with coordinators for navigation
- **Error Handling**: Use custom NetworkError enum, handle all errors explicitly
- **Extensions**: Use extensions to organize functionality by concern
- **Formatting**: 4-space indentation, 120 character line limit
- **UI**: Use programmatic UI with BasedUIComponent protocol

## Networking
- Use ApiService for network requests with proper error handling
- Follow EndPoint protocol for API endpoint definitions