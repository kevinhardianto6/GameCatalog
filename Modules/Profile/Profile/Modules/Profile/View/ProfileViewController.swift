//
//  ProfileViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 01/10/22.
//

import UIKit
import RxSwift
import Core

public class ProfileViewController: BaseViewController {
  
  public var profileViewModel: ProfileViewModel!
  
  @IBOutlet weak public var imgProfileIcon: UIImageView!
  
  @IBOutlet weak public var btnEdit: UIButton!
  
  @IBOutlet weak public var imgPhoto: UIImageView!
  
  @IBOutlet weak public var labelName: UILabel!
  
  private let disposeBag = DisposeBag()
  
  public init() {
    super.init(nibName: "ProfileViewController", bundle: Bundle(identifier: ProfileBundle.getIdentifier()))
  }
  
  required init?(coder: NSCoder) {
      super.init(nibName: "ProfileViewController", bundle: Bundle(identifier: ProfileBundle.getIdentifier()))
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupData()
  }
  
  func setupUI() {
    imgPhoto.layer.cornerRadius = imgPhoto.frame.height/2
    
//    let frameworkBundle = Bundle(for: ProfileViewController.self)
//    if let image = UIImage(named: "kevin-photo", in: frameworkBundle, compatibleWith: nil) {
//      imgPhoto.image = image
//    }
//
//    if let image = UIImage(named: "profile_icon", in: frameworkBundle, compatibleWith: nil) {
//      imgProfileIcon.image = image
//    }
  }
  
  func setupBinding() {
    profileViewModel.name.subscribe(onNext: { name in
      self.labelName.text = name
    }).disposed(by: profileViewModel.disposeBag)
    
    btnEdit.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        let editProfile = self.profileViewModel.makeEditProfileView()
        self.navigationController?.pushViewController(editProfile, animated: true)
      })
      .disposed(by: disposeBag)
  }
  
  func setupData() {
    profileViewModel.getName()
  }
  
  func loadImage(name: String) -> UIImage {
    let frameworkBundle = Bundle(identifier: ProfileBundle.getIdentifier())
    let imagePath = frameworkBundle?.path(forResource: name, ofType: "")
    let result = UIImage(contentsOfFile: imagePath!)
    return result!
  }
}
