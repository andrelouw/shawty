import Artist
import ArtistIOS
import Core
import SharedIOS
import UI
import UIKit

public final class MainCoordinator: Coordinator {
  private var navigationController: UINavigationController
  private var childCoordinators = [Coordinator]()

  public init(appWindow: UIWindow) {
    navigationController = UINavigationController()
    appWindow.rootViewController = navigationController
  }

  public func start() {
    navigationController.show(artistSearchListViewController(), sender: self)
  }

  private func artistSearchListViewController() -> UIViewController {
    let listRowModel = Artist(
      id: 0,
      name: "Kygo",
      imageURL: URL(
        string: "https://e-cdns-images.dzcdn.net/images/artist/df5ebed126f2e7402769782dae1e8c68/56x56-000000-80-0-0.jpg"
      )!
    ).asListRowModel()

    let listRowViewModel = ImageTitleRowViewModel(
      model: listRowModel,
      imageLoader: { _ in
        AsyncStream { continuation in
          Task {
            continuation.yield(LoadingImage.loading)
            try? await Task.sleep(for: .seconds(2))
            continuation.finish()
          }
        }
      }
    )

    let searchViewModel = SearchViewModel(
      promptText: ArtistIOSStrings.artistSearchPrompt
    )

    let stream = ContentViewStream<[ImageTitleRowViewModel]> { continuation in
      Task {
        continuation.yield(.loaded([listRowViewModel]))
        continuation.finish()
      }
    }

    let listViewModel = ArtistSearchListViewModel(
      screenTitle: ArtistIOSStrings.artistSearchScreenTitle,
      contentLoader: { stream },
      onItemSelection: { _ in }
    )

    return ArtistSearchListViewController(
      searchViewModel: searchViewModel,
      listViewModel: listViewModel
    )
  }
}

extension Artist {
  public func asListRowModel() -> ImageTitleRowModel<Int> {
    ImageTitleRowModel(
      id: id,
      title: name,
      imageURL: imageURL
    )
  }
}
