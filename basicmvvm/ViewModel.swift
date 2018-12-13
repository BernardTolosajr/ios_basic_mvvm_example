//
//  ViewModel.swift
//  basicmvvm
//
//  Created by Bernard tolosa on 13/12/2018.
//  Copyright © 2018 Mynt. All rights reserved.
//

import RxSwift

struct ViewModel {
  var username = Variable<String>("")
  var password = Variable<String>("")
  var isSuccess = Variable<Bool>(false)
  let disposeBag = DisposeBag()
  
  var isValid: Observable<Bool> {
    let username = self.username.asObservable().map { $0.characters.count >  0}
    let password = self.password.asObservable().map { $0.characters.count >  0}
    return Observable.combineLatest(username, password) { $0 && $1 }
  }
  
  func submit() {
    APIManager.SignIn(username: self.username.value, password: self.password.value).subscribe(onNext: { n in
      self.isSuccess.value = n
    }).disposed(by: self.disposeBag)
  }
}

