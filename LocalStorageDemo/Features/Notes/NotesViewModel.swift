import Foundation
import CoreData

@MainActor
final class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        loadNotes()
    }

    func loadNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)
        ]

        do {
            notes = try context.fetch(request)
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }

    func addNote(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let note = Note(context: context)
        note.id = UUID()
        note.title = trimmed
        note.createdAt = Date()

        save()
    }

    func deleteNote(at offsets: IndexSet) {
        offsets
            .map { notes[$0] }
            .forEach(context.delete)

        save()
    }

    private func save() {
        do {
            try context.save()
            loadNotes()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
