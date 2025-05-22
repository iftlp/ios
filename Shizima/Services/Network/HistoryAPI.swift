//
//  HistoryAPI.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import UIKit

enum HistoryAPI {

    static func getHistory(completion: @escaping (Result<[HistoryDTO], Error>) -> Void) {
        guard let token = UIDevice.current.identifierForVendor?.uuidString,
              let url = URL(string: "\(ApiUtils.baseUrl)/user/\(token)/history") else {
            print("❌ URL invalide")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        ApiUtils.perform(request: request, completion: completion)
    }
}
