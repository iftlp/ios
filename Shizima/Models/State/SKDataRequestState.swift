//
//  SKDataRequestState.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Combine

enum SKDataRequestState<T> {

    case idle
    case loading
    case success(T)
    case error(Error)

    var isLoading: Bool {
        guard case .loading = self else {
            return false
        }

        return true
    }

    var value: T? {
        guard case let .success(value) = self else {
            return nil
        }

        return value
    }
}

typealias SKDataRequestStatePublisher<T> = Published<SKDataRequestState<T>>.Publisher
