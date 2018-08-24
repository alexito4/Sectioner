import XCTest
@testable import Sectioner

struct Person: Equatable, Comparable, CustomDebugStringConvertible {
    let name: String
    let priority: Int
    
    var debugDescription: String {
        return name
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }

}

public func AssertEqual<T: Equatable>(_ expected: T, _ received: T, file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(expected == received, "Found difference for " + diff(expected, received).joined(separator: ", "), file: file, line: line)
}

final class SectionerTests: XCTestCase {
    
    let people = [
        Person(name: "Alex", priority: 1),
        Person(name: "Anna", priority: 1),
        Person(name: "Julian", priority: 1),
        Person(name: "Andrea", priority: 2),
        Person(name: "Rob", priority: 2),
        Person(name: "John", priority: 2),
        Person(name: "Javi", priority: 4)
    ]
    
    let grouped = [
        [
            Person(name: "Alex", priority: 1),
            Person(name: "Anna", priority: 1)
        ],
        [
            Person(name: "Julian", priority: 1)
        ],
        [
            Person(name: "Andrea", priority: 2),
        ],
        [
            Person(name: "Rob", priority: 2)
        ],
        [
            Person(name: "John", priority: 2),
            Person(name: "Javi", priority: 4),
        ]
    ]
    
    let uniqueGroupes = [
        [
            Person(name: "Alex", priority: 1),
            Person(name: "Andrea", priority: 2),
            Person(name: "Anna", priority: 1)
        ],
        [
            Person(name: "Javi", priority: 4),
            Person(name: "John", priority: 2),
            Person(name: "Julian", priority: 1)
        ],
        [
            Person(name: "Rob", priority: 2)
        ]
    ]
    
    func testGroupByClosure() {
        AssertEqual(
            grouped,
            people.groupBy({ (l: Person, r: Person) -> Bool in
                return l.name.first == r.name.first
            })
        )
    }
    
    func testGroupByKeypath() {
        AssertEqual(
            grouped,
            people.groupBy(\Person.name.first)
        )
    }
    
    func testUniquelyGroupByClosure() {
        AssertEqual(
            uniqueGroupes,
            people.uniquelyGroupBy({ (l: Person, r: Person) -> Bool in
                return l.name.first == r.name.first
            })
        )
    }
    
    func testUniquelyGroupByKeypath() {
        AssertEqual(
            uniqueGroupes,
            people.uniquelyGroupBy(\Person.name.first)
        )
    }
    


//    static var allTests = [
//        ("testExample", testBasicGrouper),
//    ]
}
