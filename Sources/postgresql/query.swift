
public enum QueryError : Error {
  case invalid(String)
}

enum QueryDataFormat : Int32 {
  case string = 0
  case binary = 1
}

public final class Query : ExpressibleByStringLiteral {
  public typealias StringLiteralType                  = String
  public typealias ExtendedGraphemeClusterLiteralType = String
  public typealias UnicodeScalarLiteralType           = String

  public let string:String

  var format:QueryDataFormat {
    return .binary
  }

  public init(_ string:String) {
    self.string = string
  }

  public convenience init(stringLiteral value: String) {
    self.init(value)
  }

  public convenience init(unicodeScalarLiteral value: String) {
    self.init(value)
  }

  public convenience init(extendedGraphemeClusterLiteral value: String) {
    self.init(value)
  }
}

extension Query : CustomDebugStringConvertible {
  public var debugDescription:String {
    return string
  }
}

