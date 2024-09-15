//
//  ContentViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-15.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    // MARK: VARIABLES
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    // MARK: INIT
    init() {
        setupSubscribers()
        checkAuthState()
    }
    
    // MARK: FUNCTIONS
    func setupSubscribers() {
        service.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                self?.userSession = userSession
            }
            .store(in: &cancellables)
        
        service.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
                self?.currentUser = currentUser
            }
            .store(in: &cancellables)
    }
    
    func checkAuthState() {
        if let user = Auth.auth().currentUser {
            self.userSession = user
            Task {
                await service.loadUserData()
            }
        }
    }
}
