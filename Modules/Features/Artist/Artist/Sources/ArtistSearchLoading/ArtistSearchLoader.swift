import Shared

public protocol ArtistSearchLoader: QueryValueLoader where Input == String, Output == [Artist] { }
