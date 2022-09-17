//
//  SQLiteManger.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 5/7/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import SQLite

typealias EnteredMediaData = (email: String, mediaData: Data)

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
    private let mediaListData = Expression<Data?>(SQL.mediaListData)

    // Media Table Columes
//    private let mediaTable = Table(SQL.mediaTable)
//    private let emailData = Expression<String>(SQL.emailData)
//    private let mediaHistoryData = Expression<Data>(SQL.mediaHistoryData)
//    private let mediaTypeData = Expression<String>(SQL.mediaTypeData)
    
    // MARK:- Public Methods
    func setupDatabaseTables(){
        setDatabaseTable(tableName: SQL.usersTable)
//        setDatabaseTable(tableName: SQL.mediaTable)
    }
    func createDatabaseTables(){
        createUserTable()
//        createMediaTable()
    }
    func insertInUserData(user: Data) {
        let insertUser = self.usersTable.insert(self.userData <- user)
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    func updateUserMediaListData(with data: EnteredMediaData){
        do {
            let userTableData = try self.database.prepare(self.usersTable)
            for user in userTableData {
                guard let decodUser = CoderManger.shared().decodUser(userData: user[self.userData]) else { return }
                if decodUser.email == data.email {
                    let id = user[self.idData]
                    let media = self.usersTable.filter(self.idData == id)
                    let updateMediaData = media.update(self.mediaListData <- data.mediaData)
                    try self.database.run(updateMediaData)
                }
            }
        } catch {
            print(error)
        }
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
    func getMediaDataFromDB(email: String) -> Data? {
        do {
            let userTableData = try self.database.prepare(self.usersTable)
            for user in userTableData {
                guard let decodUser = CoderManger.shared().decodUser(userData: user[self.userData]) else { return nil}
                if email == decodUser.email {
                    let data = user[self.mediaListData]
                    return data
                }
            }
        } catch {
            print(error)
        }
        return nil
    }
}

// MARK:- Private Methods
extension SQLiteManger {
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
            table.column(self.mediaListData)
        }
        do {
            try self.database.run(createTable)
        } catch {
            print(error)
        }
    }
}

//MARK:- Methods For Scecond Table
//extension SQLiteManger {
//    func getMediaDataFromDB(email: String) -> (Data, String)? {
//        do {
//            let mediaData = try self.database.prepare(self.mediaTable)
//            for media in mediaData {
//                if email == media[self.emailData] {
//                    let data = media[self.mediaHistoryData]
//                    let type = media[self.mediaTypeData]
//                    return (data, type)
//                }
//            }
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//    func insertInMediaTable(with userData: EnteredMediaData) {
//        let insertMedia = self.mediaTable.insert(self.emailData <- userData.email,
//                                                 self.mediaHistoryData <- userData.mediaData,
//                                                 self.mediaTypeData <- userData.mediaType
//        )
//        do {
//            try self.database.run(insertMedia)
//        } catch {
//            print(error)
//        }
//    }
//    func updateUserMedia(with userData: EnteredMediaData){
//        do {
//            let mediaData = try self.database.prepare(self.mediaTable)
//            for data in mediaData {
//                let email = data[self.emailData]
//                if userData.email == email {
//                    let media = self.mediaTable.filter(self.emailData == userData.email)
//                    let updateMediaData = media.update(self.mediaHistoryData <- userData.mediaData,self.mediaTypeData <- userData.mediaType)
//                    try self.database.run(updateMediaData)
//                }
//            }
//        } catch {
//            print(error)
//        }
//    }
//    private func createMediaTable(){
//        let createTable = self.mediaTable.create { table in
//            table.column(self.emailData, primaryKey: true)
//            table.column(self.mediaHistoryData)
//            table.column(self.mediaTypeData)
//        }
//        do {
//            try self.database.run(createTable)
//        } catch {
//            print(error)
//        }
//    }
//    private func deleteMediaTable() {
//        do {
//            if try database.run(mediaTable.delete()) > 0 {
//                print("The Media Table Has Been Deleted.")
//            } else {
//                print("Can not Delete the Media Table")
//            }
//        } catch {
//            print(error)
//        }
//    }
//    func getUsersFromDB() -> [Data]? {
//        var usersData = [Data]()
//        usersData.removeAll()
//        do {
//            let users = try self.database.prepare(self.usersTable)
//            for user in users {
//                let data = user[self.userData]
//                usersData.append(contentsOf: [data])
//            }
//            return usersData
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//}
