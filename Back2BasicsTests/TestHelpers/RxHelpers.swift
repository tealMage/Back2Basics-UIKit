//
//  RxHelpers.swift
//  Back2BasicsTests
//
//  Created by Adam Sterrett on 4/4/21.
//

import Foundation
import RxSwift
@testable import Back2Basics

// The singleWithMockValue and mockObservableForFakeValues will not emit an event if
// a non nil value or error is not passed in.
class RxHelpers {
    static func emptySingle<T>() -> Single<T> {
        return Single.create(subscribe: { _ in return Disposables.create() })
    }

    static func singleWithOptionalMockValue<T>(value: T?, error: Error?) -> Single<T?> {
        return Single<T?>.create(subscribe: { single -> Disposable in
            if let value = value {
                single(.success(value))
            } else if let error = error {
                single(.failure(error))
            } else {
                single(.success(value))
            }

            return Disposables.create()
        })
    }

    static func singleWithMockValue<T>(value: T?, error: Error?) -> Single<T> {
        return Single<T>.create(subscribe: { single -> Disposable in
            if let value = value {
                single(.success(value))
            } else if let error = error {
                single(.failure(error))
            }

            return Disposables.create()
        })
    }

    static func mockObservableForFakeValues<T>(value: T?, error: Error?, startClosure: VoidClosure?) -> Observable<T> {
        return Observable.create({ observable -> Disposable in
            startClosure?()

            if let value = value {
                observable.onNext(value)
            } else if let error = error {
                observable.onError(error)
            }

            return Disposables.create()
        })
    }

    static func observableWithSuccessAndFailureEvents<T>(value: T, error: Error) -> Observable<T> {
        return Observable.create({ observable -> Disposable in

            observable.onNext(value)
            observable.onError(error)

            return Disposables.create()
        })
    }
}
