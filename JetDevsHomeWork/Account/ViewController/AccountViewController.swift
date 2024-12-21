//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        self.showNonLoginView()
    }
    
	@IBAction func loginButtonTap(_ sender: UIButton) {
        self.moveToLoginScreen()
	}
	
    //MARK:  - Helper functions
    
    private func moveToLoginScreen() {
        let lLoginVC = LoginViewController()
        lLoginVC.delegate = self
        lLoginVC.modalPresentationStyle = .overCurrentContext
        self.present(lLoginVC, animated: true)
    }
    
    private func showLoginView() {
        nonLoginView.isHidden = true
        loginView.isHidden = false
    }
    
    private func showNonLoginView() {
        nonLoginView.isHidden = false
        loginView.isHidden = true
    }
    
    private func setUserDataHaving(model: User?) {
        self.nameLabel.text = model?.userName
        if let lImagePath = model?.userProfileURL {
            let lUrl = URL(string: lImagePath)
            self.headImageView.kf.indicatorType = .activity
            self.headImageView.kf.setImage(
                with: lUrl,
                placeholder: nil,
                options: nil) { result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
        self.setCreatedDateData(model: model)
    }
    
    private func setCreatedDateData(model: User?) {
        guard let lCreatedDate = model?.createdAt?.dateFormString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") else {
            return
        }
        print("lDate: \(String(describing: lCreatedDate))")
        let lTimeOffset = Date().offsetFrom(date: lCreatedDate, isShowOnlyDays: true)
        self.daysLabel.text = "Created " + lTimeOffset + " days ago"
    }
}

extension AccountViewController: LoginViewControllerDelegate {
    
    func didSucessfullyLoginUser(loginData: LoginResoponseModel?) {
        self.showLoginView()
        self.setUserDataHaving(model: loginData?.data?.user)
    }
}
