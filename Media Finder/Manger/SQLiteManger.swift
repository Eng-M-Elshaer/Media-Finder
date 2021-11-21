//
//  SQLiteManger.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/7/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import SQLite

class SQLiteManger {
    
    // MARK:- Singleton
    private static let sharedInstance = SQLiteManger()
    
    class func shared() -> SQLiteManger {
        return SQLiteManger.sharedInstance
    }
    
    // MARK:- Properties
    private var database: Connection!
    // User Table Columes
    private let usersTable = Table(SQL.usersTable)
    private let idData = Expression<Int>(SQL.idData)
    private let userData = Expression<Data>(SQL.userData)
    // Media Table Columes
    private let mediaTable = Table(SQL.mediaTable)
    private let emailData = Expression<String>(SQL.emailData)
    private let mediaHistoryData = Expression<Data>(SQL.mediaHistoryData)
    private let mediaTypeData = Expression<String>(SQL.mediaTypeData)
    
    // MARK:- Private Methods
    private func setDatabaseTable(tableName: String){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent(tableName).appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    private func createUserTable(){
        let createTable = self.usersTable.create { table in
            table.column(self.idData, primaryKey: true)
            table.column(self.userData)
        }
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
    }
    private func createMediaTable(){
        let createTable = self.mediaTable.create { table in
            table.column(self.emailData, primaryKey: true)
            table.column(self.mediaHistoryData)
            table.column(self.mediaTypeData)
        }
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
    }
    
    // MARK:- Public Methods
    func setupDatabaseTables(){
        setDatabaseTable(tableName: SQL.usersTable)
        setDatabaseTable(tableName: SQL.mediaTable)
    }
    func createDatabaseTables(){
        createUserTable()
        createMediaTable()
    }
    func insertInUserTable(user: Data) {
        let insertUser = self.usersTable.insert(self.userData <- user)
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    func insertInMediaTable(email: String, mediaData: Data, type: String) {
        deleteMediaTable()
        let insertMedia = self.mediaTable.insert(self.emailData <- email,
                                                 self.mediaHistoryData <- mediaData,
                                                 self.mediaTypeData <- type
        )
        do {
            try self.database.run(insertMedia)
        } catch {
            print(error)
        }
    }
    private func deleteMediaTable() {
        do {
            if try database.run(mediaTable.delete()) > 0 {
            } else {
            }
        } catch {
            print(error)
        }
    }
    func getUsersFromDB() -> [Data]? {
        var usersData = [Data]()
        usersData.removeAll()
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
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
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                let data = user[self.userData]
                let decodUser = CoderManger.shared().decodUser(userData: data)
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
        do {
            let medias = try self.database.prepare(self.mediaTable)
            for media in medias {
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
