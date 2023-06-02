import Artist
import SharedIOS

extension Artist {
  func asImageTitleRowModel() -> ImageTitleRowModel<Int> {
    ImageTitleRowModel(
      id: id,
      title: name,
      imageURL: imageURL
    )
  }
}
