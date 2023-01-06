//
//  ProfileViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import RxSwift
import RxCocoa

protocol ProfileViewModelProtocol {
  var get: PublishSubject<String> { get }
  var disposeBag: DisposeBag { get }
  
  func getName()
  
  func makeEditProfileView() -> UIViewController
}

class ProfileViewModel: ProfileViewModelProtocol {
  
  var get: PublishSubject<String> = PublishSubject()
  var disposeBag = DisposeBag()
  
  private let profileUseCase: ProfileUseCase
  private let profileRouter = ProfileRouter()
  
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
  
  func makeEditProfileView() -> UIViewController {
    return profileRouter.makeEditProfileView()
  }
}
