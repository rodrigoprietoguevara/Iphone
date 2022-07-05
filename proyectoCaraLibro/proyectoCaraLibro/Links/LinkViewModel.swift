//
//  LinkViewModel.swift
//  proyectoCaraLibro
//
//  Created by user190993 on 7/5/22.
//

import Foundation

final class LinkViewModel: ObservableObject{
    @Published var links:[LinkModel] = []
    @Published var messageError: String?
    private let linkRepository: LinkRepository
    
    init(linkRepository: LinkRepository = LinkRepository()) {
        self.linkRepository = linkRepository
    }
    func getAllLinks() {
        linkRepository.getAllLinks{ [weak self] result in
                switch result {
                case .success(let linkModels):
                    self?.links = linkModels
                case .failure(let error):
                self?.messageError = error.localizedDescription
                }
            
        }
    }
    
    
    
    
}
