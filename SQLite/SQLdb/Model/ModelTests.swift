//
//  ModelTests.swift
//  SQLite
//
//  Created by Mike Chirico on 11/27/22.
//

import XCTest

final class ModelSQLdbTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Event() throws {
        
        let db = SQLdb()
        
        let  database = "db.sqlite"
        db.open(database)
        
        db.sql(sql: "drop TABLE IF EXISTS  Event;")
        db.sql(sql: "drop TRIGGER IF EXISTS insert_Event_timeEnter;")
        var result  = GetEvent(table: "Event",database: database)
        XCTAssertTrue(result.count == 0)
        AddEvent(event: "Event", data: "Data")
        AddEvent(event: "Event", data: "Data2")
        result = GetEvent(table: "Event")
        XCTAssertTrue(result.count != 0)
        
        for (_ , item) in result.enumerated() {
            print("\(item.t1key),\(item.event), \(item.data), \(item.num), \(item.timeEnter)")
        }
        
        
        db.close()
    }
    
    
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
