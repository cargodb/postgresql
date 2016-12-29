
#if os(Linux)
    import libpostgresql_linux
    import GLibc
#else
    import libpostgresql_macos
    import Darwin
#endif

/// Parameters
public protocol Parameter {
  var stringValue:String  { get }
}

extension String : Parameter {
  public var stringValue:String {
    return self
  }
}

extension Bool    : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Int     : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Int16   : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Int32   : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Int64   : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Float   : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

extension Double  : Parameter {
  public var stringValue:String {
    return "\(self)"
  }
}

/// Columns

public enum ColumnType : UInt32 {
  case boolean      = 16
  case int64        = 20
  case int16        = 21
  case int32        = 23
  case text         = 25
  case singleFloat  = 700
  case doubleFloat  = 701
}
