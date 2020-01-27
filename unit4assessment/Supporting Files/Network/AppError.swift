//
//  AppError.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/27/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

enum AppError: Error {
  case badURL(String)
  case noResponse
  case networkClientError(Error)
  case noData
  case decodingError(Error)
  case badStatusCode(Int)
  case badMimeType(String)
}
