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
    case ErrorMock
}

enum Api {
    static public let hostResources = Configuration.hostResources
    static private let hostService = Configuration.hostService
    static public var mockName:String = ""

    var path:String {
        switch self {
        case let .board(offset,limit) :
            Api.mockName = "board.json"
            return Api.hostService + "pokemon?offset=\(offset)&limit=\(limit)"
        case let .detail(name) :
            Api.mockName = "detail.json"
            return Api.hostService + "pokemon/"+name
        case let .detailAbility(name) :
            Api.mockName = "detailAbility.json"
            return Api.hostService + "ability/"+name
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
    
        if Configuration.isMock {
            _ = processJSONData(filename: Api.mockName,completion: completion)
            return
        }
                
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
                        let decoder = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decoder))
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
    
    private func processJSONData<T: Decodable>(filename: String,completion:@escaping (Result<T, NetworkError>)-> Void) {
        var data: Data = Data()
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            completion(.failure(.ErrorMock))
            return
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            completion(.failure(.ErrorMock))
            return
        }
        
        do {
            let decoder = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decoder))
        } catch {
            completion(.failure(.ErrorMock))
        }
    }
    
}

