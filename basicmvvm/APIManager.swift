//
//  APIManager.swift
//  basicmvvm
//
//  Created by Bernard tolosa on 13/12/2018.
//  Copyright © 2018 Mynt. All rights reserved.
//

import RxSwift

struct APIManager {
  static func SignIn(username: String, password: String) -> Observable<Bool> {
    return Observable.create { observer in
      // maybe just return true or false
      observer.onNext(true)
      return Disposables.create()
    }
  }
}
