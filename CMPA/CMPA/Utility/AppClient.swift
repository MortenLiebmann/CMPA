//
//  AppClient.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 18/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import RxSwift

class AppClient {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    private var storageManager = StorageManager()
    func get<T: Codable>(request: URLRequest, key: String) -> Observable<T> {
        if !Networking.isConnectedToNetwork() {
            return getOfflineData(key: key)
        } else {
            return getOnlineData(request: request, key: key)
        }
    }
    
    private func getOnlineData<T: Codable>(request: URLRequest, key: String) -> Observable<T> {
        return Observable<T>.create {observer in
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                do {
                    let value: T = try self.decoder.decode(T.self, from: data ?? Data())
                    let status = self.storageManager.save(data: value, for: key)
                    observer.onNext(value)
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func getOfflineData<T: Codable>(key: String) -> Observable<T> {
        return Observable<T>.create {observer in
            let status: StorageStatus<T, StorageError> = self.storageManager.load(for: key)
            
            switch status {
            case .Success(let model):
                observer.onNext(model)
                break
            default: break
            }
            return Disposables.create()
        }
    }
}
