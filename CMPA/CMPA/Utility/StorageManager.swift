//
//  StorageManager.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 19/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation

enum StorageError: Error {
    case SaveFailed
    case LoadFailed
    case FlushFailed
    case DecodeFailed
}

enum StorageStatus<T: Codable, E: Error> {
    case Success(T)
    case Failed(E)
}

protocol StorageManagerHandler{
    func save<T: Codable>(data: T, for key: String) -> StorageStatus<Data, StorageError>
    func load<T: Codable>(for key: String) -> StorageStatus<T, StorageError>
    func flush(for key: String) -> StorageStatus<Bool, StorageError>
}

class StorageManager: StorageManagerHandler {
    private var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    var userDefaults = UserDefaults.standard
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func save<T: Codable>(data: T, for key: String) -> StorageStatus<Data, StorageError> {
        do {
            let data = try encoder.encode(data.self)
            
            userDefaults.set(data, forKey: key)
            return .Success(data)
        } catch {
            return .Failed(.DecodeFailed)
        }
    }
    
    func load<T: Codable>(for key: String) -> StorageStatus<T, StorageError> where T : Decodable, T : Encodable {
        guard let data = userDefaults.data(forKey: key) else { return .Failed(.LoadFailed) }
        
        do {
            let model: T = try decoder.decode(T.self, from: data)
            
            return .Success(model)
        } catch {
             return .Failed(.DecodeFailed)
        }
    }
    
    func flush(for key: String) -> StorageStatus<Bool, StorageError> {
        let path = StorageManager.DocumentsDirectory.appendingPathComponent(key).path
        let fileManager = FileManager()
        let fileExists = fileManager.fileExists(atPath: path)
        if fileExists {
            do {
                try fileManager.removeItem(atPath: path)
                return .Success(true)
            } catch {
                return .Failed(.FlushFailed)
            }
        }
        return .Success(true) //File does not exist so flush is technically successful
    }
}
