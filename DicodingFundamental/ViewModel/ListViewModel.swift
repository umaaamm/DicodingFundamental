//
//  ListViewModel.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation

class ListViewModel : ObservableObject {
    
    private let repository: ListRepository
    @Published var isAnimatingLoading: Bool = true
    @Published var isAlert: Bool = false
    @Published var textAlert: String = ""
    @Published var dataGames: [Result] = []
    
    init(repository: ListRepository = Services.instance) {
        self.repository = repository
    }
    
    func getGames(){
        self.isAnimatingLoading = true
        self.repository.fetchGames { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let game):
                DispatchQueue.main.async {
                    self.dataGames = game.results
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
