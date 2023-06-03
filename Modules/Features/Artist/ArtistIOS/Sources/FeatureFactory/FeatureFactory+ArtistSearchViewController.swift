import Artist
import Shared
import SharedIOS
import UIKit

extension FeatureFactory {
  /// Creates a `ArtistSearchViewController` that load `Artist` based on a query
  /// - Parameter onArtistSelection:  The action to take when an `Artist` is selected on the list view
  /// - Returns: A `ArtistSearchViewController`
  func makeArtistSearchViewController(
    onArtistSelection: @escaping (Int) -> Void
  ) -> UIViewController {
    let queryDebounceOnMilliSeconds = 500
    // The search url
    let url = ArtistEndpoint.search.url(baseURL: baseURL)

    // Loaders
    let remoteArtistSearchLoader = RemoteArtistSearchLoader(
      url: url,
      client: httpClient
    )

    let imageDataLoadingImageAdapter = ImageDataLoadingImageAdapter(
      imageDataLoader: imageLoader,
      dataImageAdapter: UIImage.init(data:)
    )

    // Adapters
    let artistsListCellViewModelAdapter = ArtistImageTitleRowViewModelAdapter(
      artistsSearchLoader: remoteArtistSearchLoader,
      imageDataLoadingImageAdapter: imageDataLoadingImageAdapter
    )

    let searchViewModel = SearchViewModel(
      promptText: ArtistIOSStrings.artistSearchPrompt
    )

    let contentStreamAdapter = PublishedQueryContentStreamAdapter(
      queryPublisher: searchViewModel
        .searchTextPublisher()
        .debounce(
          for: .milliseconds(queryDebounceOnMilliSeconds),
          scheduler: DispatchQueue.main
        )
        .eraseToAnyPublisher(),
      loader: artistsListCellViewModelAdapter
    )

    // ViewModels
    let listViewModel = ArtistSearchListViewModel(
      contentLoader: contentStreamAdapter.load,
      onItemSelection: onArtistSelection
    )

    // View Controller
    return ArtistSearchListViewController(
      screenTitle: ArtistIOSStrings.artistSearchScreenTitle,
      searchViewModel: searchViewModel,
      listViewModel: listViewModel
    )
  }
}
