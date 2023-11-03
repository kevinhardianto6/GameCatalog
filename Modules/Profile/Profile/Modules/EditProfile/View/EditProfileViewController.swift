//
//  EditProfileViewController.swift
//  Catalog
//
//  Created by Kevin Hardianto on 12/10/22.
//

import UIKit
import RxSwift

public class EditProfileViewController: UIViewController {
  
  public var editProfileViewModel: EditProfileViewModel!
  
  @IBOutlet weak var btnBack: UIButton!
  @IBOutlet weak var imgPhoto: UIImageView!
  @IBOutlet weak var btnSave: UIButton!
  @IBOutlet weak var textfieldName: UITextField!
  
  private let disposeBag = DisposeBag()
  
  public init() {
    super.init(nibName: "EditProfileViewController", bundle: Bundle(identifier: ProfileBundle.getIdentifier()))
  }
  
  required init?(coder: NSCoder) {
    super.init(nibName: "EditProfileViewController", bundle: Bundle(identifier: ProfileBundle.getIdentifier()))
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBinding()
    setupData()
  }
  
  func setupUI() {
    imgPhoto.layer.cornerRadius = imgPhoto.frame.height/2
    btnSave.isEnabled = false
    
    textfieldName.attributedPlaceholder = NSAttributedString(
      string: "Input your name here",
      attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    )
    
    textfieldName.textColor = .white
    textfieldName.becomeFirstResponder()
    textfieldName.delegate = self
  }
  
  func setupBinding() {
    editProfileViewModel.get.subscribe(onNext: { name in
      self.textfieldName.text = name
    }).disposed(by: editProfileViewModel.disposeBag)
    
    editProfileViewModel.set.subscribe(onNext: { _ in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Profile has been updated.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
      }
    }).disposed(by: editProfileViewModel.disposeBag)
    
    btnBack.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        self.navigationController?.popViewController(animated: true)
      })
      .disposed(by: disposeBag)
    
    btnSave.rx.tap
      .asObservable()
      .subscribe(onNext: { _ in
        self.editProfileViewModel.setName(name: self.textfieldName.text ?? "")
      })
      .disposed(by: disposeBag)
    
    textfieldName.rx.controlEvent([.editingChanged])
      .asObservable()
      .subscribe(onNext: { _ in
        let text = self.textfieldName.text
        if text != "" && text != nil && text != " " {
          self.btnSave.isEnabled = true
        } else {
          self.btnSave.isEnabled = false
        }
      })
      .disposed(by: disposeBag)
    
    textfieldName.rx.controlEvent([.editingDidEndOnExit])
      .asObservable()
      .subscribe(onNext: { _ in
        self.textfieldName.resignFirstResponder()
      })
      .disposed(by: disposeBag)
  }
  
  func setupData() {
    editProfileViewModel.getName()
  }
}

extension EditProfileViewController: UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let acceptableCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
    let cs = NSCharacterSet(charactersIn: acceptableCharacters).inverted
    let filtered = string.components(separatedBy: cs).joined(separator: "")
    
    return (string == filtered)
  }
}
