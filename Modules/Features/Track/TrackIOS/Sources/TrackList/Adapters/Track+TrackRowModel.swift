import Foundation
import SharedIOS
import Track

extension Track {
  /// Transforms `Track` to `TrackRowModel`
  func asTrackRowModel() -> TrackRowModel<Int> {
    TrackRowModel(
      id: id,
      title: title
    )
  }
}
