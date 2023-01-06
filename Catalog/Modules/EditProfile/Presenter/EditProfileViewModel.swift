//
//  EditProfileViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import RxSwift
import RxCocoa

protocol EditProfileViewModelProtocol {
  var get: PublishSubject<String> { get }
  var set: PublishSubject<Bool> { get }
  var disposeBag: DisposeBag { get }
  
  func getName()
  func setName(name: String)
}

class EditProfileViewModel: EditProfileViewModelProtocol {
  
  var get: PublishSubject<String> = PublishSubject()
  var set: PublishSubject<Bool> = PublishSubject()
  var disposeBag = DisposeBag()
  
  private let profileUseCase: ProfileUseCase
  
  init(profileUseCase: ProfileUseCase) {
    self.profileUseCase = profileUseCase
  }
  
  func getName() {
    profileUseCase.getProfile()
      .observe(on: MainScheduler.instance)
      .subscribe { name in
        self.get.onNext(name)
      }.disposed(by: disposeBag)
  }
  
  func setName(name: String) {
    profileUseCase.setProfile(name: name)
      .observe(on: MainScheduler.instance)
      .subscribe { isSuccess in
        self.set.onNext(true)
      }.disposed(by: disposeBag)
  }
}
