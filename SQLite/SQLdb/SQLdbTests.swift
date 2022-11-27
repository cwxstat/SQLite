//
//  SQLdbTests.swift
//  SQLite
//
//  Created by Mike Chirico on 11/27/22.
//

import XCTest

final class SQLdbTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSQLdb() throws {
        
        let db = SQLdb()
        db.open("test.sqlite")
        db.create()
        
        guard let  image = db.img(color: UIColor.green,size: CGSize(width: 20,height: 20)) else {
            print("Can't create image.")
            XCTAssertTrue(1==2)
            return
        }
        
        db.insert(data: "data a", image: image, num: 17.8)
        
        let r = db.result()
        
        XCTAssertTrue(r.count >= 1)
        for (_ , item) in r.enumerated() {
            print("\(item.t1key),\t \(item.data), \(item.num), \(item.timeEnter)")
        }
        
        db.close()
        
    }
    
    func testStuff() throws {
        AddGo()
        
        let db = SQLdb(file: "goals.sqlite")
        db.open("goals.sqlite")
        
        
        let sql = """
        CREATE TABLE IF NOT EXISTS Go (t1key INTEGER
                  PRIMARY KEY,data text,num double,timeEnter DATE);
        CREATE TRIGGER IF NOT EXISTS insert_Go_timeEnter AFTER  INSERT ON Go
          BEGIN
            UPDATE Go SET timeEnter = DATETIME('NOW')  WHERE rowid = new.rowid;
          END;
        """
        
        let num = 12
        db.sql(sql: sql)
        db.sql(sql: "insert into Go (data,num) values ('Go',\(num));")
        
        
        
        let r = db.resultNI(sql: "select t1key,data,num,timeEnter from Go;")
        
        XCTAssertTrue(r.count >= 1)
        print(r.count)
        db.close()
    }
    
    
    func testSQLdb_SQL_ResultEvent() throws {
        
        let db = SQLdb()
        db.open("test.sqlite")
        
        //db.sql(sql: "drop TABLE IF EXISTS t2;")
        //db.sql(sql: "drop TRIGGER IF EXISTS insert_t2_timeEnter;")
        
        
        let sql = """
        CREATE TABLE IF NOT EXISTS Event (t1key INTEGER
                  PRIMARY KEY,event text, data text,num double,timeEnter DATE);
        CREATE TRIGGER IF NOT EXISTS insert_Event_timeEnter AFTER  INSERT ON Event
          BEGIN
            UPDATE Event SET timeEnter = DATETIME('NOW')  WHERE rowid = new.rowid;
          END;
        """
        db.sql(sql: sql)
        
        db.sql(sql: "insert into Event (event,data,num) values ('event','data',0.2);")
        db.sql(sql: "insert into Event (event,data,num) values ('event','data',0.2);")
        db.sql(sql: "insert into Event (event,data,num) values ('event','data',0.2);")
        
        
        let r = db.resultEvent(sql: "select t1key,data,num,timeEnter from Event;")
        
        XCTAssertTrue(r.count >= 1)
        print("\n\n   TABLE  \n")
        for (_ , item) in r.enumerated() {
            print("\(item.t1key),\t \(item.event), \(item.data), \(item.num),  timeEnter: \(item.timeEnter)")
        }
        
        db.close()
        db.open("test.sqlite")
        
        
        
        
        
    }
    
    
    
    func testSQLdb_SQL_ResultNI() throws {
        
        let db = SQLdb()
        db.open("test.sqlite")
        
        //db.sql(sql: "drop TABLE IF EXISTS t2;")
        //db.sql(sql: "drop TRIGGER IF EXISTS insert_t2_timeEnter;")
        
        
        let sql = """
        CREATE TABLE IF NOT EXISTS t2 (t1key INTEGER
                  PRIMARY KEY,data text,num double,timeEnter DATE);
        CREATE TRIGGER IF NOT EXISTS insert_t2_timeEnter AFTER  INSERT ON t2
          BEGIN
            UPDATE t2 SET timeEnter = DATETIME('NOW')  WHERE rowid = new.rowid;
          END;
        """
        db.sql(sql: sql)
        
        db.sql(sql: "insert into t2 (data,num) values ('data',0.2);")
        db.sql(sql: "insert into t2 (data,num) values ('data',0.2);")
        db.sql(sql: "insert into t2 (data,num) values ('data',0.2);")
        
        
        var r = db.resultNI(sql: "select t1key,data,num,timeEnter from t2;")
        
        XCTAssertTrue(r.count >= 1)
        print("\n\n   TABLE  \n")
        for (_ , item) in r.enumerated() {
            print("\(item.t1key),\t \(item.data), \(item.num),  timeEnter: \(item.timeEnter)")
        }
        
        db.close()
        db.open("test.sqlite")
        r = db.resultNI(sql: "select t1key,data,num,timeEnter from t2;")
        
        
        
        
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}
