
// Reference: https://stackoverflow.com/a/46369152/5826424
public struct FailableDecodable<Base: Decodable>: Decodable {

  public let base: Base?

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    base = try? container.decode(Base.self)
  }
}

public struct FailableDecodableArray<Element: Decodable>: Decodable {

  public let elements: [Element]

  public init(from decoder: Decoder) throws {
    var container = try decoder.unkeyedContainer()

    var elements = [Element]()
    if let count = container.count {
      elements.reserveCapacity(count)
    }

    while !container.isAtEnd {
      if
        let element = try container
          .decode(FailableDecodable<Element>.self).base
      {
        elements.append(element)
      }
    }

    self.elements = elements
  }
}
