#if os(Linux)
  import libpostgresql_linux
  import GLibc
#else
  import libpostgresql_macos
  import Darwin
#endif

public enum DatabaseError : Error {
  case invalidIndex
  case invalidColumn
  case invalidSQL(String)
  case noQuery
  case noResults
}


public class Database {
  fileprivate var connection:Connection!
  fileprivate let statusOn                = "on"
  fileprivate let integerDatetimesKey     = "integer_datetimes"
  fileprivate let config:Configuration

  public var hasIntegerDatetimes:Bool {
    guard let connection = connection else { return false }

    return parameterStatus(connection, key:integerDatetimesKey)
  }

  init(_ config:Configuration) {
    self.config     = config
    self.connection = Connection(self.config)
  }

 @discardableResult
  public func connect() throws -> Connection {
    return try connection.connect()
  }
}

extension Database /* Query */ {
  @discardableResult
  public func execute(_ query:String, _ parameters:[Parameter] = []) throws -> Any? {
    guard query.isEmpty == false else { throw DatabaseError.noQuery }

    let values = UnsafeMutablePointer<UnsafePointer<Int8>?>.allocate(capacity: parameters.count)
    
    defer {
      values.deinitialize()
      values.deallocate(capacity: parameters.count)
    }
    
    var tmp:[[UInt8]] = []
    
    for (index, param) in parameters.enumerated() {
      let appending = [UInt8](param.stringValue.utf8) + [0]
      
      tmp.append(appending)
      
      values[index] = UnsafePointer<Int8>(OpaquePointer(tmp.last!))
    }
    
    let connection  = try connect()
    let result      = PQexecParams(connection.connection, query, Int32(parameters.count), nil, values, nil, nil, QueryDataFormat.binary.rawValue)

    return result
  }
}

extension Database /* private */ {
  fileprivate func parameterStatus(_ conn:Connection, key:String, defaultValue:Bool = false) -> Bool {
    guard let status = PQparameterStatus(conn.connection, integerDatetimesKey) else {
      return defaultValue
    }

    return String(cString:status) == statusOn
  }
}



