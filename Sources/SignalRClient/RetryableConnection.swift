//
//  RetryableConnection.swift
//  SignalRClient
//
//  Created by Pawel Kadluczka on 11/17/19.
//

import Foundation

internal class RetryableConnection: Connection {
    private let connectionFactory: () -> Connection
    private let retryPolicy: RetryPolicy
    private var underlyingConnection: Connection

    var delegate: ConnectionDelegate?
    var connectionId: String? {
        return underlyingConnection.connectionId
    }

    init(connectionFactory: @escaping () -> Connection, retryPolicy: RetryPolicy) {
        self.connectionFactory = connectionFactory
        self.retryPolicy = retryPolicy
        self.underlyingConnection = connectionFactory()
    }

    func start() {
        underlyingConnection.delegate = delegate
        underlyingConnection.start()
    }

    func send(data: Data, sendDidComplete: (Error?) -> Void) {
        underlyingConnection.send(data: data, sendDidComplete: sendDidComplete)
    }

    func stop(stopError: Error?) {
        underlyingConnection.stop(stopError: stopError)
    }
}
