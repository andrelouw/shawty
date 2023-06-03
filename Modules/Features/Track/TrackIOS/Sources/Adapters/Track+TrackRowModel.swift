import Foundation
import SharedIOS
import Track

extension Track {
  public func asTrackRowModel() -> TrackRowModel<Int> {
    TrackRowModel(
      id: id,
      title: title
    )
  }
}
