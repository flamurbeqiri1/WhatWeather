//
//  Result.swift
//  WhatWeather
//
//  Created by Flamur Beqiri on 28/06/2019.
//  Copyright © 2019 Flamur Beqiri. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
