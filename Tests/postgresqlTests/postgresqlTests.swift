import XCTest
@testable import postgresql

class postgresqlTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(postgresql().text, "Hello, World!")
    }


    static var allTests : [(String, (postgresqlTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
