# LocalStorageDemo

A lightweight demo project showcasing **local data persistence in iOS** using:

- **Core Data** with `NSPersistentContainer`
- **Keychain** for secure token storage
- **SwiftUI** interface for listing and managing notes
- **MVVM architecture**
- Clean structure and separation of concerns

This demo is intentionally simple but demonstrates the key concepts required for building offline-capable iOS apps.

---

## 📦 Features

### 🔹 Core Data
- Uses `NSPersistentContainer` configured in a reusable `PersistenceController`
- Supports adding, deleting, and fetching notes
- Automatic merging of changes into the view context
- Uses `NSMergeByPropertyObjectTrumpMergePolicy` for safe updates
- Entity: `Note` with fields:
  - `id: UUID`
  - `title: String`
  - `createdAt: Date`

### 🔹 Keychain
- Secure storage for sensitive values (e.g., auth token)
- Wrapper around `SecItemAdd`, `SecItemCopyMatching`, and `SecItemDelete`
- Demonstrates storing and reading access tokens

### 🔹 MVVM + SwiftUI
- `NotesViewModel` handles Core Data operations
- `NotesView` displays a list of notes, allows creating and deleting
- SwiftUI `@StateObject`, `@Published`, and `@MainActor` used correctly

---

## 📁 Project Structure

```text
LocalStorageDemo/
├─ LocalStorageDemoApp.swift        // Entry point
├─ Core/
│  ├─ Data/
│  │  └─ PersistenceController.swift
│  └─ Security/
│     └─ KeychainService.swift
├─ Models/
│  └─ Note+Extensions.swift
├─ Features/
│  └─ Notes/
│     ├─ NotesViewModel.swift
│     └─ NotesView.swift
└─ LocalStorageDemo.xcdatamodeld    // Core Data model
