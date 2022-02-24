//
//  URLRequest.swift
//  WeatherInfo
//
//  Created by Suhyoung Eo on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

extension URLRequest {

    /*RxCocoa를 이용한 Error handling*/
    static func load<T: Codable>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
               
                if 200..<300 ~= response.statusCode {
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
    
    /*
     // RxSwift
    static func load<T: Codable>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
     */
    
}

struct Resource<T> {
    let url: URL
}
