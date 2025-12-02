import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel: NotesViewModel
    @State private var newTitle: String = ""

    init(viewModel: NotesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                inputSection

                List {
                    ForEach(viewModel.notes) { note in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title ?? "")
                                .font(.headline)

                            if let date = note.createdAt {
                                Text(date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
                .listStyle(.plain)
            }
            .padding(.horizontal)
            .navigationTitle("Local Notes")
        }
    }

    private var inputSection: some View {
        HStack {
            TextField("New note title", text: $newTitle)
                .textFieldStyle(.roundedBorder)

            Button("Add") {
                guard !newTitle.isEmpty else { return }
                viewModel.addNote(title: newTitle)
                newTitle = ""
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.vertical)
    }
}
