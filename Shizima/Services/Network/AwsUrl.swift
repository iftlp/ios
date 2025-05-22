//
//  AwsUrl.swift
//  Shizima
//
//  Created by Loris Perret on 06/05/2025.
//

import Foundation

struct AwsUrl: Sendable {
    
    // MARK: - Properties

    let url: URL

    // MARK: - Body

    init?(string: String) {
        if let url = URL(string: ApiUtils.minioUrl + string) {
            self.url = ApiUtils.signer.signURL(url: url)
        } else {
            return nil
        }
    }
}
