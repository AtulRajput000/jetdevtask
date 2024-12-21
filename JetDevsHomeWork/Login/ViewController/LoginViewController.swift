//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//    20/12/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginViewControllerDelegate: AnyObject {
    
    func didSucessfullyLoginUser(loginData: LoginResoponseModel?)
}

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var emailView: UIView?
    @IBOutlet private weak var passwordView: UIView?
    @IBOutlet private weak var loginBtn: UIButton?
    @IBOutlet private weak var emailTxtFld: UITextField?
    @IBOutlet private weak var passwordTxtFld: UITextField?
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView?
    
    // MARK: - Properties
    private lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    weak var delegate: LoginViewControllerDelegate?
    // RxSwift
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureUI()
    }
    
    deinit {
        print("\(self) \(#function)")
    }
    
    // MARK: - IBActions
    
    @IBAction private func backButtonTap(_ sender: UIButton) {
        self.dismissLoginScreen()
    }
    
    // MARK: - Helper functions
    private func configureUI() {
        self.hideKeyboardWhenTappedAround()
        self.customiseTextFieldUI(self.emailView)
        self.customiseTextFieldUI(self.passwordView)
        self.loginBtn?.titleLabel?.font = UIFont.latoRegularFont(size: 18.0)
        self.loginBtn?.layer.cornerRadius = 10.0
        self.loginBtn?.titleLabel?.textColor = .white
        self.setupBindings()
    }

    private func customiseTextFieldUI(_ customView: UIView?) {
        guard let lView = customView else {
            return
        }
        if let lImgView = lView.viewWithTag(50) as? UIImageView {
            lImgView.setLayout(WithBorderWidth: 1.0,
                               borderColor: UIColor.lightGray,
                               radius: 10.0,
                               andBackgroundColor: .clear)
        }
        
        if let lTitletLbl = lView.viewWithTag(51) as? UILabel {
            lTitletLbl.font = UIFont.latoRegularFont(size: 12.0)
        }
        
        if let lTxtFld = lView.viewWithTag(55) as? UITextField {
            lTxtFld.setLeftPaddingInTextField(15.0)
            lTxtFld.font = UIFont.latoRegularFont(size: 16.0)
        }
    }
    
    private func dismissLoginScreen(){
        self.dismiss(animated: true)
    }
    
    private func callLoginApi() {
        self.view.endEditing(true)
        self.showHideLoader(true)
        let lRequestModel = LoginRequest(email: self.emailTxtFld?.text, password: self.passwordTxtFld?.text)
        self.loginViewModel.loginUser(loginRequest: lRequestModel) { response, error in
            self.showHideLoader(false)
            if let lError = error,
               lError.isEmpty == false {
                self.showAlertWithMessage(message: lError)
            } else {
                self.dismissLoginScreen()
                self.delegate?.didSucessfullyLoginUser(loginData: response)
            }
        }
    }
    
    private func showHideLoader(_ isShow: Bool) {
        if isShow == true {
            self.indicatorView?.startAnimating()
        } else {
            self.indicatorView?.stopAnimating()
        }
    }
    
    private func showAlertWithMessage(message: String?) {
        let lAlert = UIAlertController(title: "Error",
                                      message: (message ?? ""),
                                      preferredStyle: .alert)
        
        lAlert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
            
        }))
        
        self.present(lAlert, animated: true, completion: nil)
    }
}

// MARK: - RxSwift related functions
extension LoginViewController {
    
    private func setupBindings() {
        // Observables for username and password
        guard let lEmailTxtFld = emailTxtFld,
              let lPswdTxtFld = passwordTxtFld,
              let lLoginBtn = loginBtn else {
            return
        }
        let usernameObservable = lEmailTxtFld.rx.text.orEmpty.asObservable()
        let passwordObservable = lPswdTxtFld.rx.text.orEmpty.asObservable()
        
        // Validation Observables
        let isUsernameValid = usernameObservable.map {!$0.isEmpty }
        let isPasswordValid = passwordObservable.map { $0.count > 0 }
        
        // Combine validations
        let isFormValid = Observable.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
        
        // Bind to login button
        isFormValid
            .bind(to: lLoginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // Update login button appearance
        isFormValid
            .map { $0 ? Utils.hx_color(withHexRGBAString: "#28518D") : Utils.hx_color(withHexRGBAString: "#BDBDBD")}
            .bind(to: lLoginBtn.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        // Handle login button tap
        lLoginBtn.rx.tap
            .withLatestFrom(Observable.combineLatest(usernameObservable, passwordObservable))
            .subscribe(onNext: { [weak self] _, _ in
                self?.callLoginApi()
            })
            .disposed(by: disposeBag)
    }

}

