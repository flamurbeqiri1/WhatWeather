//
//  ImageLoadingService.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import UIKit

public protocol ImageLoadingService {
    func loadImage(from url: URL, completion: @escaping (Result<UIImage>) -> Void)
}

public enum ImageLoadingServiceError {
    case dataLoadingFailed(URL)
}

extension ImageLoadingServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .dataLoadingFailed(url): return "Failed to load image data for \(url)"
        }
    }
}
