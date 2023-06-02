import SwiftUI
import UIKit

public final class ArtistViewController: UIHostingController<ArtistView> {
  public init() {
    super.init(rootView: ArtistView())
  }

  @available(*, unavailable)
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
