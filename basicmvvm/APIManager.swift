//
//  APIManager.swift
//  basicmvvm
//
//  Created by Bernard tolosa on 13/12/2018.
//  Copyright © 2018 Mynt. All rights reserved.
//

import RxSwift

protocol APIManagerProtocol {
  func SignIn(_ user: User) -> Single<Bool>
}

struct APIManager: APIManagerProtocol {
  // its use Single instead of Obserbvale
  // https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Traits.md#creating-a-single
  func SignIn(_ user: User) -> Single<Bool> {
    return Single<Bool>.create { single in
      // fetch from the api here
      // maybe just return true or false
      single(.success(true))
      return Disposables.create()
    }
  }
}
