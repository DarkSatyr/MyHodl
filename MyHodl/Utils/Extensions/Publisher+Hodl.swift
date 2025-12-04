//
//  Publisher.swift
//  MyHodl
//
//  Created by DarkSatyr on 04.12.2025.
//

import Combine

extension Publisher where Failure == Never, Output: Sendable {
    func flatMapAsync<T>(_ transform: @escaping @Sendable (Output) async -> T
        ) -> Publishers.FlatMap<Future<T, Never>, Self> {
            flatMap { value in
                Future { promise in
                    let box = PromiseBox<T, Never>(promise)
                    Task {
                        let output = await transform(value)
                        box.fulfill(.success(output))
                    }
                }
            }
        }
}

extension Publisher where Failure == Error, Output: Sendable {
    func flatMapAsyncThrowing<T: Sendable>(
        _ transform: @escaping @Sendable (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future<T, Error> { promise in
                let box = PromiseBox<T, Error>(promise)
                Task {
                    do {
                        let output = try await transform(value)
                        box.fulfill(.success(output))
                    } catch {
                        box.fulfill(.failure(error))
                    }
                }
            }
        }
    }
}

private final class PromiseBox<T, E: Error>: @unchecked Sendable {
    let fulfill: (Result<T, E>) -> Void

    init(_ fulfill: @escaping (Result<T, E>) -> Void) {
        self.fulfill = fulfill
    }
}
