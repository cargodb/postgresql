#if os(Linux)
    import libpostgresql_linux
#else
    import libpostgresql_macos
#endif

public struct Configuration {
  public var host:String      = "localhost"
  public var port:String      = "5432"
  public var user:String      = ""
  public var passwd:String    = ""
  public var database:String  = ""
  
  public var conninfo:String {
    return ["host"            : host,
            "port"            : port,
            "dbname"          : database,
            "user"            : user,
            "password"        : passwd,
            "client_encoding" : "'UTF8'",].reduce([]) { reduction, index in
                    return reduction + ["\(index.key)='\(index.value)'"]
            }.joined(separator: " ")
  }
  
  public static var `default` = Configuration()
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
  
  private let config:Configuration
  private(set) var connection:OpaquePointer!
  
  public init(_ configuration:Configuration = Configuration.default) {
    self.config     = configuration
    self.connection = PQconnectdb(self.config.conninfo)
  }
}
