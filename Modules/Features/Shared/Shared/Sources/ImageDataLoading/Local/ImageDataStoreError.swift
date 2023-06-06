
public enum ImageDataStoreError: Error {
  case save(SaveError)
  case load(LoadError)

  public enum SaveError {
    case failed(Error)
  }

  public enum LoadError {
    case failed(Error)
    case notFound
  }
}
