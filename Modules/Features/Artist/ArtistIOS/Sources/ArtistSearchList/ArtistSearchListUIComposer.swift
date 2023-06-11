import Artist
import Combine
import Core
import Foundation
import Shared
import SharedIOS
import UIKit

public enum ArtistSearchListUIComposer {
  private typealias ArtistContentStreamLoader = () -> ContentViewStream<[ImageTitleRowViewModel<Int>]>

  public static func listComposedWith(
    artistSearchLoader: any ArtistSearchLoader,
    imageDataLoader: any ImageDataLoader,
    searchQueryDebounce: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(500),
    selection: @escaping (Int) -> Void
  ) -> UIViewController {
    let searchViewModel = SearchViewModel(
      promptText: ArtistIOSStrings.artistSearchPrompt
    )

    let listViewModel = ArtistSearchListViewModel(
      contentLoader: artistContentStreamLoader(
        from: searchViewModel.searchTextPublisher().debounced(by: searchQueryDebounce),
        artistSearchLoader: artistSearchLoader,
        imageDataLoader: imageDataLoader
      ),
      onItemSelection: selection
    )

    return ArtistSearchListViewController(
      screenTitle: ArtistIOSStrings.artistSearchScreenTitle,
      searchViewModel: searchViewModel,
      listViewModel: listViewModel
    )
  }

  private static func artistContentStreamLoader(
    from publisher: AnyPublisher<String, Never>,
    artistSearchLoader: any ArtistSearchLoader,
    imageDataLoader: any ImageDataLoader
  ) -> ArtistContentStreamLoader {
    let artistSearchListViewAdapter = ArtistSearchListViewAdapter(
      artistsSearchLoader: artistSearchLoader,
      imageDataLoader: imageDataLoader
    )

    return PublishedQueryContentStreamAdapter(
      queryPublisher: publisher,
      loader: artistSearchListViewAdapter
    ).load
  }
}
