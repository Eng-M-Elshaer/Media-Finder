//
//  DatabaseManger.swift
//  Guess Game
//
//  Created by Mohamed Elshaer on 5/7/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import Foundation
import SQLite

class SQLiteManger {
    
    // MARK:- Singleton
    private static let sharedInstance = SQLiteManger()
    
    class func shared() -> SQLiteManger {
        return SQLiteManger.sharedInstance
    }
    
    // MARK:- Properties
    private var database: Connection!
    
    private let usersTable = Table(SQL.usersTable)
    private let idData = Expression<Int>(SQL.idData)
    private let userData = Expression<Data>(SQL.userData)
    
    private let mediaTable = Table(SQL.mediaTable)
    private let emailData = Expression<String>(SQL.emailData)
    private let mediaHistoryData = Expression<Data>(SQL.mediaHistoryData)
    private let mediaTypeData = Expression<String>(SQL.mediaTypeData)
    
    // MARK:- Methods
    func setDatabaseTable(tableName: String){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(tableName).appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    func createUserTable(){
        print("CREATEING USER TABLE")
        let createTable = self.usersTable.create { (table) in
            table.column(self.idData, primaryKey: true)
            table.column(self.userData)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    func createMediaTable(){
        print("CREATEING MEDIA TABLE")
        let createTable = self.mediaTable.create { (table) in
            table.column(self.emailData, primaryKey: true)
            table.column(self.mediaHistoryData)
            table.column(self.mediaTypeData)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    func insertInUserTable(user: Data) {
        print("INSERT TAPPED")
        let insertUser = self.usersTable.insert(self.userData <- user)
        
        do {
            try self.database.run(insertUser)
            print("INSERTED USER")
            print(user, "XXXXXX DATA")
        } catch {
            print(error)
        }
    }
    func insertInMediaTable(email: String, mediaData: Data, type: String) {
        print("REMOVE ALL")
        deleteMediaTable()
        print("INSERT TAPPED")
        
        let insertMedia = self.mediaTable.insert(self.emailData <- email,
                                                 self.mediaHistoryData <- mediaData,
                                                 self.mediaTypeData <- type
        )
        
        do {
            try self.database.run(insertMedia)
            print("INSERTED USER")
            print(email, "XXXXXX DATA")
        } catch {
            print(error)
        }
    }
    private func deleteMediaTable() {
        do {
            if try database.run(mediaTable.delete()) > 0 {
                print("deleted Media")
            } else {
                print("alice not found")
            }
        } catch {
            print("delete failed: \(error)")
        }
    }
    func getUsersFromDB() -> [Data]? {
        var usersData = [Data]()
        usersData.removeAll()
        print("Get Data")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("ID: \(user[self.idData]), user data: \(user[self.userData])")
                let data = user[self.userData]
                usersData.append(contentsOf: [data])
            }
            return usersData
        } catch {
            print(error)
        }
        return nil
    }
    func getUserFromDB(email: String) -> User? {
        print("Get Data")
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("ID: \(user[self.idData]), user data: \(user[self.userData])")
                let data = user[self.userData]
                let decodUser = Coder.decodUser(userData: data)
                if email == decodUser?.email {
                    return decodUser
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
    func getMediaDataFromDB(email: String) -> (Data, String)? {
        print("Get Data Media")
        do {
            let medias = try self.database.prepare(self.mediaTable)
            for media in medias {
                print("ID: \(media[self.emailData]), media data: \(media[self.mediaHistoryData])")
                if email == media[self.emailData] {
                    let data = media[self.mediaHistoryData]
                    let type = media[self.mediaTypeData]
                    return (data,type)
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
}
