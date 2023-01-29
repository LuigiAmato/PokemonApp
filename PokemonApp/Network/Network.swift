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
        }
        
    }
    case board(offset:Int,limit:Int)

    func toUrlRequest()->URLRequest? {
        guard let url = URL(string:self.path) else {
            return nil
        }
        return URLRequest(url: url)
    }
}

class Network: ObservableObject {
    @Published var board:Pokemons? = nil
    
    
    // @escaping: sopravvive alla vita di questo oggetto: se scompare l oggetto network lei esiste sempre

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
                        //self.board = decodedUsers
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

