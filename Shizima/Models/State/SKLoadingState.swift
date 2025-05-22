//
//  SKLoadingState.swift
//  Shizima
//
//  Created by Loris Perret on 30/04/2025.
//

import Combine

enum SKLoadingState<Value> {

    case loading
    case failed(Error)
    case loaded(Value)

    var value: Value? {
        guard case let .loaded(value) = self else {
            return nil
        }

        return value
    }

    var isLoading: Bool {
        guard case .loading = self else {
            return false
        }

        return true
    }

    var isFailed: Bool {
        guard case .failed = self else {
            return false
        }

        return true
    }
}

typealias SKLoadingStatePublisher<T> = Published<SKLoadingState<T>>.Publisher
