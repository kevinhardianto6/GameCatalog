//
//  ProfileViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift

class ProfileViewController: BaseViewController {
  
  @IBOutlet weak var btnEdit: UIButton!
  
  @IBOutlet weak var imgPhoto: UIImageView!
  @IBOutlet weak var labelName: UILabel!
  
  private var profileViewModel: ProfileViewModelProtocol?
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    profileViewModel?.getName()
  }
  
  func setupUI() {
    imgPhoto.layer.cornerRadius = imgPhoto.frame.height/2
  }
  
  func setViewModel(viewModel: ProfileViewModelProtocol) {
    self.profileViewModel = viewModel
  }
  
  func setupBinding() {
    profileViewModel?.get.subscribe(onNext: { name in
      self.labelName.text = name
    }).disposed(by: profileViewModel?.disposeBag ?? disposeBag)
    
    btnEdit.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        if let editProfile = self.profileViewModel?.makeEditProfileView() {
          self.navigationController?.pushViewController(editProfile, animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
}
