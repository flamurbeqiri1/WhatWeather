//
//  MockImageLoadingService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

class MockImageLoadingService: ImageLoadingService {

    init() {
        print("Start MockImageLoadingService")
    }

    deinit {
        print("Stop MockImageLoadingService")
    }

    func loadImage(from url: URL, completion: @escaping (Result<UIImage>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data, scale: UIScreen.main.scale) else {
                    throw MockImageLoadingServiceError.invalidData
                }
                DispatchQueue.main.async {
                    print("Download image performed: \(image)")
                    completion(Result.success(image))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
        }
    }
}

enum MockImageLoadingServiceError: String {
    case invalidData = "Invalid image data"
}

extension MockImageLoadingServiceError: LocalizedError {
    public var errorDescription: String? {
        return rawValue
    }
}
