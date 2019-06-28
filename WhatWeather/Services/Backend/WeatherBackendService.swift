//
//  WeatherBackendService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation
import Alamofire

class WeatherBackendService: BackendService {

    init() {
        #if DEBUG
        print("DEBUG: Start WeatherBackendService")
        #endif
    }

    deinit {
        #if DEBUG
        print("DEBUG: Stop WeatherBackendService")
        #endif
    }

    func get<T>(_ type: T.Type, path: String, completion: @escaping (Result<T>) -> Void) where T: Decodable {
        Alamofire.request(path, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        guard let dataToDecode = response.data else {
                            #if DEBUG
                            print("DEBUG: Response data missing!")
                            #endif
                            return
                        }
                        let object = try JSONDecoder().decode(T.self, from: dataToDecode)
                        completion(Result.success(object))
                    } catch let error {
                        #if DEBUG
                        if let decodingError = error as? DecodingError {
                            print("JSON decoding error: \(String(describing: decodingError))")
                        }
                        #endif
                        completion(Result.failure(error))
                    }
                case .failure(let error):
                    #if DEBUG
                    print("DEBUG: Error on getting response: \(error)")
                    #endif
                    completion(Result.failure(error))
                }
        }
    }
}
