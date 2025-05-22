//
//  ApiUtils.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import AWSSigner
import Foundation

enum ApiUtils {
    static let baseUrl = "https://shizima-api.baptiiiste.com"
    static let minioUrl = "https://minioapi.baptiiiste.com/shizima/"
    
    static let signer = AWSSigner(
        credentials: StaticCredential(
            accessKeyId: Secrets.minioAccessKeyId,
            secretAccessKey: Secrets.minioSecretAccessKey
        ),
        name: "s3",
        region: "eu-west-3"
    )
    
    static func perform<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Erreur réseau :", error)
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Pas de réponse HTTP")
                completion(.failure(NSError(domain: "", code: -1)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ Code de réponse invalide :", httpResponse.statusCode)
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode)))
                return
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    print("❌ Données indécodables")
                    completion(.failure(error))
                }
            } else {
                print("❌ Données vides")
                completion(.failure(NSError(domain: "", code: -1)))
            }
        }

        task.resume()
    }
}
