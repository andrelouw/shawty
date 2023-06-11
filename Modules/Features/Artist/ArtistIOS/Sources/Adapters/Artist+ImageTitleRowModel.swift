import Artist
import SharedIOS

extension Artist {
  /// Transforms `Artist` to `ImageTitleRowModel<Int>`
  func asImageTitleRowModel() -> ImageTitleRowModel<Int> {
    ImageTitleRowModel(
      id: id,
      title: name,
      imageURL: imageURL
    )
  }
}
