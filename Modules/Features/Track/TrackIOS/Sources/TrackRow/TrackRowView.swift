import SharedIOS
import SwiftUI
import UI

public struct TrackRowView<ID: Hashable>: View, ListRowDisplayable {
  public typealias Item = TrackRowModel<ID>
  private let model: Item

  public init(model: Item) {
    self.model = model
  }

  public var body: some View {
    HStack {
      Text(model.title)
        .foregroundColor(.font.primary)
      Spacer()
      Icon.play.asImage()
        .foregroundColor(.brand.primary)
        .font(.body)
    }
  }
}
