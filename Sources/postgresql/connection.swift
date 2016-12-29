#if os(Linux)
    import libpostgresql_linux
    import GLibc
#else
    import libpostgresql_macos
    import Darwin
#endif

public enum ConnectionError : Error {
  case connecting(String, String)
  
  var description:(error:String, conninfo:String) {
    switch self {
    case .connecting(let msg, let conninfo):
      return (msg, conninfo)
    }
  }
}

public final class Connection {
  public var version:String {
    return String(PQlibVersion())
  }

  public var status:ConnStatusType {
    return PQstatus(connection)
  }
  public var isConnected:Bool {
    return status == CONNECTION_OK
  }

  public var error:String {
    guard let message = PQerrorMessage(connection) else { return "" }

    return String(cString: message)
  }

  private let config:Configuration
  private(set) var connection:OpaquePointer!

  public init(_ configuration:Configuration = Configuration.default) {
    self.config = configuration
  }

  public func connect() throws -> Connection {
    connection = PQconnectdb(self.config.conninfo)

    guard self.isConnected == true else {
      throw ConnectionError.connecting(error, config.conninfo)
    }

    return self
  }

  public func reset() throws {
    guard isConnected == true else { throw ConnectionError.connecting(error, config.conninfo) }

    PQreset(connection)
  }

  public func flush() throws {
    guard isConnected == true else { throw ConnectionError.connecting(error, config.conninfo) }

    PQflush(connection)
  }

  public func close() throws {
    guard isConnected == true else { throw ConnectionError.connecting(error, config.conninfo) }

    PQfinish(connection)
  }

  deinit {
    try? close()
  }
}
