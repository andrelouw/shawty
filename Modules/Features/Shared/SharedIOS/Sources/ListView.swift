import SwiftUI
import UI

public struct ListView: View {
  @State private var isLoading = false

  public var body: some View {
    NavigationView {
      ZStack {
        contentView
        loader
      }
    }
  }

  @ViewBuilder private var loader: some View {
    if isLoading {
      VStack {
        Spacer()
        AnimatingLoaderView().padding()
      }
      .transition(.opacity.animation(.easeInOut(duration: 0.35)))
      .zIndex(1)
    }
  }

  @ViewBuilder private var contentView: some View {
    List {
      Section("Section title") {
        ForEach(0..<35) {
          Text("Cell \($0)")
            .contentShape(Rectangle())
            .onTapGesture {
              print("Did tap cell")
            }
        }
      }
    }
    .scrollContentBackground(.hidden)
    .listStyle(.grouped)
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView()
  }
}
