//
//  DetailGamesViewModel.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation

class DetailGamesViewModel: ObservableObject {
    private let detailGamesRepository: DetailGamesListRepository
    @Published var isAnimatingLoading: Bool = true
    @Published var isAlert: Bool = false
    @Published var dataDetailGames: DetailGamesModel?
    init(detailGamesRepository: DetailGamesListRepository = Services.instance) {
        self.detailGamesRepository = detailGamesRepository
    }
    func getDetailGames(id: Int) {
        self.isAnimatingLoading = true
        self.detailGamesRepository.getGamesDetail(id: id) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let detailGame):
                DispatchQueue.main.async {
                    self.dataDetailGames = detailGame
                    self.isAnimatingLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isAnimatingLoading = false
                    self.isAlert =  true
                    print(error.localizedDescription)
                }
            }
        }
    }
}
