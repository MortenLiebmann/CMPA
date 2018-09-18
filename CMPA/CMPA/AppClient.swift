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
    func get<T: Codable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create {observer in
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                do {
                    let value: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    
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
}
