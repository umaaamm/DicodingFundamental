//
//  Services.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation

typealias ListCompletion = (Swift.Result<RawgGames, NetworkError>) -> Void
typealias ListCompletionDetailGames = (Swift.Result<DetailGamesModel, NetworkError>) -> Void


protocol ListRepository {
    func fetchGames(completion: @escaping ListCompletion)
}

protocol DetailGamesListRepository {
    func getGamesDetail(id: Int, completion: @escaping ListCompletionDetailGames)
}

class Services: ListRepository, DetailGamesListRepository {
    
    static let instance: Services = Services()
    
    private let baseApiUrl = "https://api.rawg.io"
    private let urlSession = URLSession.shared
    
    func fetchGames(completion: @escaping ListCompletion) {
        let url = self.generateUrl(path: UrlPath.urlDetail)
        self.urlSession.dataTask(with: url){ (data, response, error) in
            if let errorResponse = error {
                print("Error response : \(errorResponse.localizedDescription)")
            }else {
                do {
                    let result = try JSONDecoder().decode(RawgGames.self, from: data!)
                    completion(.success(result))
                }catch let error {
                    completion(.failure(.requestFailed))
                    print("Failed to get Games : \(error)")
                }
            }
        }.resume()
    }
    
    func getGamesDetail(id: Int, completion: @escaping ListCompletionDetailGames) {
        let url = URL(string: "\(baseApiUrl)/api/games/\(id)?key=4b3457d69fc84c53b2e0f0d0155eb17b")!
        self.urlSession.dataTask(with: url){ (data, response, error) in
            if let errorResponse = error {
                print("Error response detail games : \(errorResponse.localizedDescription)")
            }else {
                do {
                    let result = try JSONDecoder().decode(DetailGamesModel.self, from: data!)
                    completion(.success(result))
                }catch let error {
                    completion(.failure(.requestFailed))
                    print("Failed to get detail games : \(error)")
                }
            }
        }.resume()
    }
    
    private func generateUrl(path: String) -> URL{
        let url = "\(self.baseApiUrl)/\(path)"
        return URL(string: url)!
    }
}

struct UrlPath {
    static let urlDetail = "api/games?key=4b3457d69fc84c53b2e0f0d0155eb17b"
}
