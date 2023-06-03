import Album
import SharedIOS

extension Album {
  public func asImageTitleRowModel() -> ImageTitleRowModel<Int> {
    ImageTitleRowModel(
      id: id,
      title: title,
      imageURL: imageURL
    )
  }
}
