//
//  LoginVC.swift
//  tempplate
//
//  Created by isoftstone on 2023/6/5.
//

import UIKit
import FDLibrary
import RxSwift

class LoginVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(usernameTF)
        view.addSubview(usernameValidLabel)
        view.addSubview(passwordTF)
        view.addSubview(passwordValidLabel)
        view.addSubview(loginBtn)
        
        usernameTF.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(100)
        }
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(self.usernameTF.snp.bottom).offset(5)
            make.left.equalTo(self.usernameTF)
        }
        passwordTF.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.top.equalTo(self.usernameValidLabel.snp.bottom).offset(10)
        }
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(self.passwordTF.snp.bottom).offset(5)
            make.left.equalTo(self.usernameTF)
        }
        loginBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
            make.top.equalTo(self.passwordValidLabel.snp.bottom).offset(20)
        }
        
        let usernameValid = usernameTF.rx.text.orEmpty.map({$0.count >= 5}).share(replay: 1)
        
        let passwordValid = passwordTF.rx.text.orEmpty.map({$0.count >= 6}).share(replay: 1)
        
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ){$0 && $1}
        .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTF.rx.isEnabled)
            .disposed(by: disposeBag)
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid.bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .subscribe(onNext: {[weak self] in
                debugPrint("do something")
            }).disposed(by: disposeBag)
    }
    
    lazy var usernameTF = {
        let usernameTF = UITextField(frame: .zero)
        usernameTF.placeholder = "请输入用户名"
        usernameTF.borderStyle = .roundedRect
        return usernameTF
    }()
    
    lazy var usernameValidLabel = {
        let usernameValidLabel = UILabel(frame: .zero)
        usernameValidLabel.text = "用户名最少5个字符"
        usernameValidLabel.font = .systemFont(ofSize: 13)
        usernameValidLabel.textColor = .systemRed
        return usernameValidLabel
    }()
    
    lazy var passwordTF = {
        let passwordTF = UITextField(frame: .zero)
        passwordTF.placeholder = "请输入密码"
        passwordTF.isSecureTextEntry = true
        passwordTF.borderStyle = .roundedRect
        return passwordTF
    }()
    
    lazy var passwordValidLabel = {
        let passwordValidLabel = UILabel(frame: .zero)
        passwordValidLabel.text = "密码最少6个字符"
        passwordValidLabel.font = .systemFont(ofSize: 13)
        passwordValidLabel.textColor = .systemRed
        return passwordValidLabel
    }()
    
    lazy var loginBtn = {
        let loginBtn = UIButton(type: .system)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.layer.cornerRadius = 25
        loginBtn.clipsToBounds = true
        loginBtn.titleLabel?.font = .systemFont(ofSize: 17)
        return loginBtn
    }()
}
