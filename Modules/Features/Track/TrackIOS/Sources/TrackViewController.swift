import SwiftUI
import UIKit

public final class TrackViewController: UIHostingController<TrackView> {
  public init() {
    super.init(rootView: TrackView())
  }

  @available(*, unavailable)
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
