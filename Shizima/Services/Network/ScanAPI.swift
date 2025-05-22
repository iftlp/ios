//
//  ScanAPI.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Foundation
import UIKit

enum ScanAPI {

    static func scan(_ fileURL: URL, completion: @escaping (Result<HistoryDTO, Error>) -> Void) {
        guard let token = UIDevice.current.identifierForVendor?.uuidString,
              let url = URL(string: "\(ApiUtils.baseUrl)/recognition/wavFile/\(token)") else {
            print("❌ URL invalide")
            return
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let paramName = "audioFile"
        var body = Data()

        body += Data("--\(boundary)\r\n".utf8)
        body += Data("Content-Disposition:form-data; name=\"\(paramName)\"".utf8)
        let paramSrc = fileURL.lastPathComponent
        if let fileContent = try? Data(contentsOf: fileURL) {
            body += Data("; filename=\"\(paramSrc)\"\r\n".utf8)
            body += Data("Content-Type: \"content-type header\"\r\n".utf8)
            body += Data("\r\n".utf8)
            body += fileContent
            body += Data("\r\n".utf8)
        }
        body += Data("--\(boundary)--\r\n".utf8)

        let postData = body

        var request = URLRequest(url: url)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        ApiUtils.perform(request: request, completion: completion)
    }
}
