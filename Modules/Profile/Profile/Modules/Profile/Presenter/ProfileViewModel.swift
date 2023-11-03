//
//  ProfileViewModel.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import RxSwift
import RxCocoa

public class ProfileViewModel {
  
  var name: PublishSubject<String> = PublishSubject()
  var disposeBag = DisposeBag()
  
  private let profileUseCase: ProfileUseCase
  private let profileRouter = ProfileRouter()
  
  public init(profileUseCase: ProfileUseCase) {
    self.profileUseCase = profileUseCase
  }
  
  func getName() {
    profileUseCase.getProfile()
      .observe(on: MainScheduler.instance)
      .subscribe { name in
        self.name.onNext(name)
      }.disposed(by: disposeBag)
  }
  
  func makeEditProfileView() -> UIViewController {
    return profileRouter.makeEditProfileView()
  }
}
