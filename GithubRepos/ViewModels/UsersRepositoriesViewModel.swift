//
//  UsersRepositoriesViewModel.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI
import Combine

class UsersRepositoriesViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    @Published var state: State = .idle
    @Published var userName = ""
    
    private let reposService = RepositoriesListService()
    private lazy var cancellables = Set<AnyCancellable>()
    private var currentUser: String = "" {
        didSet {
            reset()
            searchUsersRepositories(for: currentUser)
        }
    }
    private lazy var currentPage = 1
    private lazy var hasMore = true
    
    func setupBindings() {
        $userName
            //            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // Needed only if search should be executed every time user types new text.
            .sink {[weak self] userName in
                self?.currentUser = userName.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .store(in: &cancellables)
    }
    
    func avatarImage(for user: Owner) -> UIImage? {
        if let url = user.avatarUrl,
           let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    func fetchNextPage() {
        guard state == .complete && hasMore else { return }
        
        currentPage += 1
        fetchRepos()
    }
    
    private func searchUsersRepositories(for user: String) {
        guard !user.isEmpty else {
            state = .idle
            return
        }
        
        fetchRepos(for: user)
    }
    
    private func fetchRepos(for user: String? = nil) {
        state = .loading
        
        reposService.fetchRepositories(user: user ?? currentUser, for: currentPage)
            .catch {[weak self] error -> AnyPublisher<[Repository], Never> in
                self?.state = .error(error.localizedDescription)
                
                return .init(Empty())
            }
            .sink { [weak self] repos in
                self?.handleData(repos)
            }
            .store(in: &cancellables)
    }
    
    private func handleData(_ repos: [Repository]) {
        if repos.isEmpty && currentPage == 1 {
            state = .empty
            repositories = []
        } else {
            hasMore = repos.count == Constants.itemsPerPage
            state = .complete
            repositories += repos
        }
    }
    
    private func reset() {
        currentPage = 1
        hasMore = true
        repositories = []
        state = .idle
    }
    
    enum State: Equatable {
        case idle
        case loading
        case complete
        case empty
        case error(String)
    }
}
