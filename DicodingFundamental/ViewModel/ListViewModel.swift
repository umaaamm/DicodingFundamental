//
//  ListViewModel.swift
//  DicodingFundamental
//
//  Created by Kurniawan Gigih Lutfi Umam on 06/08/21.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    private let repository: ListRepository
    private var cancellable: AnyCancellable?
    @Published var isAnimatingLoading: Bool = true
    @Published var dataGames: [Result] = []
    @Published var query: String = ""
    init(repository: ListRepository = Services.instance) {
        self.repository = repository
        cancellable = AnyCancellable(
            $query.removeDuplicates()
                .debounce(for: 0.8, scheduler: DispatchQueue.main)
                .sink(receiveValue: { _ in
                    self.getGames()
                })
        )
    }
    func getGames() {
        self.isAnimatingLoading = true
        if query.isEmpty {
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
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            self.repository.fetchGamesSearch(query: self.query) { [weak self] (result) in
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
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
