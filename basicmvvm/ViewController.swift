//
//  ViewController.swift
//  basicmvvm
//
//  Created by Bernard tolosa on 13/12/2018.
//  Copyright © 2018 Mynt. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var someLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!
  
  let viewModel = ViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBindings()
    setupCallBacks()
  }

  func setupBindings() {
    nameTextField.rx.text.orEmpty
      .bind(to: viewModel.username)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text.orEmpty
      .bind(to: viewModel.password)
      .disposed(by: disposeBag)
    
    submitButton.rx.tap.do(onNext:  { [unowned self] in
      self.nameTextField.resignFirstResponder()
      self.passwordTextField.resignFirstResponder()
    }).subscribe(onNext: { [unowned self] in
      self.viewModel.submit()
    }).disposed(by: disposeBag)

    // validations
    viewModel.isValid.bind(to: submitButton.rx.isEnabled)
      .disposed(by: disposeBag)
  }
  
  func setupCallBacks() {
    viewModel.isSuccess.asObservable()
      .bind{ value in
        // do your thing here when succces
        NSLog("Successfull")
      }.disposed(by: disposeBag)
  }
}

