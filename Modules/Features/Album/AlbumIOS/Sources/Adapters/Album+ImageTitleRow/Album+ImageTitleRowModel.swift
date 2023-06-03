import Album
import SharedIOS

extension Album {
  /// Transforms `Album` to `ImageTitleRowModel<Int>`
  public func asImageTitleRowModel() -> ImageTitleRowModel<Int> {
    ImageTitleRowModel(
      id: id,
      title: title,
      imageURL: imageURL
    )
  }
}
