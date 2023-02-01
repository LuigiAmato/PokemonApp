//
//  Network.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation
import SwiftUI

enum NetworkError:Error {
    case RequestError
    case ResponseError
    case ServerError
    case DecodingError
    case ErrorUrl
}

enum Api {
    static public let baseUrlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
    static private let baseUrl = "https://pokeapi.co/api/v2/"
    var path:String {
        switch self {
        case let .board(offset,limit) :
            return Api.baseUrl + "pokemon?offset=\(offset)&limit=\(limit)"
        case let .detail(name) :
            return Api.baseUrl + "pokemon/"+name
        case let .detailAbility(name) :
            return Api.baseUrl + "ability/"+name
        }
   
    }
    case board(offset:Int64,limit:Int64)
    case detail(name:String)
    case detailAbility(name:String)

    func toUrlRequest()->URLRequest? {
        guard let url = URL(string:self.path) else {
            return nil
        }
        return URLRequest(url: url)
    }
}

class Network: ObservableObject {
    
    func request<T: Codable>(request:URLRequest,completion:@escaping (Result<T, NetworkError>) -> Void) {
    
        let urlRequest = request
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(.failure(.RequestError))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.ResponseError))
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(.ServerError))
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedUsers))
                    } catch let error {
                        print("Error decoding: ", error)
                        completion(.failure(.DecodingError))
                    }
                }
            }
            else {
                completion(.failure(.ServerError))
                return
            }
        }

        dataTask.resume()
    }
    
}

