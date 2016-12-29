import XCTest
@testable import postgresql

class postgresqlTests: XCTestCase {
  let config  = Configuration(host: "localhost", port: "5432", user: "wess", passwd: "", database: "boxjoint")
  
  func testConnection() {
    let db = Database(config)
    
    do {
      try db.connect()
    } catch let error as ConnectionError {
      XCTFail("Connection Error: \(error.description.error) - Conn: \(error.description.conninfo)", file: #file, line: #line)
    }
    catch {}
  }
  
  func testQuery() {
    let db = Database(config)

    do {
      try db.connect()
      
      let result = try db.execute("SELECT * FROM users")
      
      print("RESULT: \(result)")
      XCTAssertNotNil(result)
      
    } catch let error as ConnectionError {
      XCTFail("Connection Error: \(error.description.error) - Conn: \(error.description.conninfo)", file: #file, line: #line)
    }
    catch {}
}

  static var allTests : [(String, (postgresqlTests) -> () throws -> Void)] {
    return [
      ("testConnection", testConnection),
      ("testQuery", testQuery),
    ]
  }
}
