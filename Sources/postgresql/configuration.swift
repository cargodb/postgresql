#if os(Linux)
    import libpostgresql_linux
    import GLibc
#else
    import libpostgresql_macos
    import Darwin
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
            "client_encoding" : "UTF8",].reduce([]) { reduction, index in
                    return reduction + ["\(index.key)='\(index.value)'"]
            }.joined(separator: " ")
  }

  public static var `default` = Configuration()
}
