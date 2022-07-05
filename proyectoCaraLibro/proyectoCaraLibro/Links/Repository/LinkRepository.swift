//
//  LinkRepository.swift
//  proyectoCaraLibro
//
//  Created by user190993 on 7/5/22.
//

import Foundation

final class LinkRepository {
    private let linkDatasource: LinkDatasource
    init(linkDatasource: LinkDatasource = LinkDatasource()){
        self.linkDatasource = linkDatasource
    }
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        linkDatasource.getAllLinks(completionBlock: completionBlock)
    }
}
