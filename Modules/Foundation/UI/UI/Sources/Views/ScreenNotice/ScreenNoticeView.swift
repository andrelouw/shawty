import SwiftUI

public struct ScreenNoticeView: View {
  private let model: ScreenNoticeModel

  public init(model: ScreenNoticeModel) {
    self.model = model
  }

  public var body: some View {
    VStack(spacing: 20) {
      iconView
      Spacer()
      titleView
      subtitleView
    }
    .frame(height: 200)
    .opacity(model.style.opacity)
    .animation(.easeInOut(duration: 0.35), value: model)
  }

  private var titleView: some View {
    Text(model.title)
      .font(.headline)
      .foregroundColor(.font.primary)
      .multilineTextAlignment(.center)
  }

  @ViewBuilder private var subtitleView: some View {
    if let subtitle = model.subtitle {
      Text(subtitle)
        .font(.subheadline)
        .foregroundColor(.font.secondary)
        .multilineTextAlignment(.center)
    }
  }

  private var iconView: some View {
    model.icon.asImage()
      .font(.system(size: 50))
      .foregroundColor(model.iconColor)
      .accessibilityIdentifier(model.icon.id)
  }
}
