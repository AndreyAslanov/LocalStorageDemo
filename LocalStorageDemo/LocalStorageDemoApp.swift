import SwiftUI
import CoreData

@main
struct LocalStorageDemoApp: App {
    private let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NotesView(
                viewModel: NotesViewModel(
                    context: persistenceController.container.viewContext
                )
            )
        }
    }
}
