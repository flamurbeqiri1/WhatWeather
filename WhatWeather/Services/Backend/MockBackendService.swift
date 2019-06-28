//
//  MockBackendService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

class MockBackendService: BackendService {

    init() {
        print("Start MockBackendService")
    }

    deinit {
        print("Stop MockBackendService")
    }

    func get<T>(_ type: T.Type, path: String, completion: @escaping (Result<T>) -> Void) where T: Decodable {
        // Simulate network latency
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(Result.failure(BackendServiceError.objectNotFound))
        }
    }

}
