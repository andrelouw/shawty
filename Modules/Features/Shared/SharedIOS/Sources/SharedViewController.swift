import SwiftUI
import UIKit

public final class SharedViewController: UIHostingController<SharedView> {
  public init() {
    super.init(rootView: SharedView())
  }

  @available(*, unavailable)
  required dynamic init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
