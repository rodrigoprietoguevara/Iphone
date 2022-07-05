//
//  LinkDatasource.swift
//  proyectoCaraLibro
//
//  Created by user190993 on 7/5/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LinkModel: Decodable, Identifiable {
    @DocumentID var id : String?
    let nombre: String
    let apellido: String
    
}
final class LinkDatasource{
    private let db = Firestore.firestore()
    private let collection = "users"
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void){
        db.collection(collection).addSnapshotListener{ query, error in
            if let error = error {
                print("Error getting all links")
                completionBlock(.failure(error))
                return
            }
        guard let documents = query?.documents.compactMap({ $0 }) else {
            completionBlock(.success([]))
            return
            }
            let links = documents.map{try? $0.data(as: LinkModel.self)}
                .compactMap  { $0 }
            completionBlock(.success(links))
        }
    }
}
