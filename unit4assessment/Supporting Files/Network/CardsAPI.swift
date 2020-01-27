//
//  CardsAPI.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/27/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct CardsAPI {
    
    static func getQuestion(completion: @escaping (Result<Cards, AppError>) -> ()) {
        let urlString = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let question = try JSONDecoder().decode(Cards.self, from: data)
                    completion(.success(question))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}
