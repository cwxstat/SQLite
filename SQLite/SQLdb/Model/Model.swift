//
//  Model.swift
//  SQLite
//
//  Created by Mike Chirico on 11/27/22.
//

import Foundation
import UIKit

class WorkoutDisplay: ObservableObject {
    @Published var display = "Actions Today: \(GetCount(table: "PushUp"))\nSit Ups:  \(GetCount(table: "SitUp"))\nKettleBell:  \(GetCount(table: "KettleBell"))"
}



func AddGo(num: Double = 1.0) {
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
    
    db.sql(sql: sql)
    db.sql(sql: "insert into Go (data,num) values ('Go',\(num));")
    db.close()
    
}

func AddEvent(event: String, data: String, num: Double = 1.0) {
    let db = SQLdb()
    db.open("goals.sqlite")
    
    let sql = """
    CREATE TABLE IF NOT EXISTS Event (t1key INTEGER
              PRIMARY KEY,event text, data text,num double,timeEnter DATE);
    CREATE TRIGGER IF NOT EXISTS insert_Event_timeEnter AFTER  INSERT ON Event
      BEGIN
        UPDATE Event SET timeEnter = DATETIME('NOW')  WHERE rowid = new.rowid;
      END;
    """
    
    db.sql(sql: sql)
    db.sql(sql: "insert into Event (event,data,num) values ('\(event)','\(data)',\(num));")
    db.close()
    
}

func AddPushUp(num: Double = 1.0) {
    let db = SQLdb()
    db.open("goals.sqlite")
    
    let sql = """
    CREATE TABLE IF NOT EXISTS PushUp (t1key INTEGER
              PRIMARY KEY,data text,num double,timeEnter DATE);
    CREATE TRIGGER IF NOT EXISTS insert_PushUp_timeEnter AFTER  INSERT ON PushUp
      BEGIN
        UPDATE PushUp SET timeEnter = DATETIME('NOW')  WHERE rowid = new.rowid;
      END;
    """
    
    db.sql(sql: sql)
    db.sql(sql: "insert into PushUp (data,num) values ('PushUp',\(num));")
    db.close()
    
}



func AddEntry(txt: String) {
    let db = SQLdb()
    db.open("goals.sqlite")
    db.create()
    
    guard let  image = db.img(color: UIColor.green,size: CGSize(width: 20,height: 20)) else {
        print("Can't create image.")
        return
    }
    
    db.insert(data: txt, image: image, num: 17.8)
    
    db.close()
}


func DeleteAll() {
    let db = SQLdb()
    
    let database = "goals.sqlite"
    
    db.open(database)
    
    db.sql(sql: "drop TABLE IF EXISTS  PushUp;")
    db.sql(sql: "drop TRIGGER IF EXISTS insert_PushUp_timeEnter;")
    
    db.sql(sql: "drop TABLE IF EXISTS  SitUp;")
    db.sql(sql: "drop TRIGGER IF EXISTS insert_SitUp_timeEnter;")
    
    db.sql(sql: "drop TABLE IF EXISTS  KettleBell;")
    db.sql(sql: "drop TRIGGER IF EXISTS insert_KettleBell_timeEnter;")
    
    
    
    
    db.close()
}



/*
 PushUp
 SitUp
 KettleBell
 */
func GetCount(table:String = "Go",database: String = "goals.sqlite") -> Int64 {
    
    var result:Int64 = 0
    let db = SQLdb()
    db.open(database)
    db.create()
    
    
    let r = db.resultNI(sql: "select t1key, data, num, timeEnter from \(table) where timeEnter > date('now','-17 hour') order by timeEnter desc;")
    
    for (_ , item) in r.enumerated() {
        print("\(item.t1key), \(item.num), \(item.timeEnter)")
        result+=1
    }
    
    db.close()
    
    return result
}

func GetEvent(table:String = "Event",database: String = "goals.sqlite") -> Int64 {
    
    var result:Int64 = 0
    let db = SQLdb()
    db.open(database)
    db.create()
    
    
    let r = db.resultNI(sql: "select t1key, data, num, timeEnter from \(table) where timeEnter > date('now','-17 hour') order by timeEnter desc;")
    
    for (_ , item) in r.enumerated() {
        print("\(item.t1key), \(item.num), \(item.timeEnter)")
        result+=1
    }
    
    db.close()
    
    return result
}
