////
////  HandelNavigationButtons.swift
////  OfferIT
////
////  Created by Mohamed Akl on 07/06/2021.
////
//
//import UIKit
//
//extension UIViewController {
//    func HideNavigationBar(status: Bool){
//        navigationController?.setNavigationBarHidden(status, animated: true)
//    }
//    func HideTabBar(status: Bool){
//        tabBarController?.tabBar.isHidden = status
//    }
//
//   
//    func dismissFromBottom(){
//        let transition = CATransition()
//        transition.duration = 0.2
//        //        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromBottom
//        view.window!.layer.add(transition, forKey: kCATransition)
//        self.dismiss(animated: false)
//    }
//    func presentFromBottom(VC: UIViewController){
//        VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.subtype = CATransitionSubtype.fromTop
//        view.window!.layer.add(transition, forKey: kCATransition)
//        present(VC, animated: true, completion: nil)
//    }
//    func TableDesigen(TVC: UITableView){
//        TVC.tableFooterView = UIView()
//        TVC.separatorInset = .zero
//        TVC.contentInset = .zero
//    }
//
//    func dismissView(){
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func popView(){
//        self.navigationController?.popViewController(animated: true)
//    }
//    func popToRootView(){
//        self.navigationController?.popToRootViewController(animated: true)
//    }
//    
//    func createNavBtn(image : UIImage){
//
//    }
//    func createShareBtn()-> UIBarButtonItem {
//        let shareBtn = UIBarButtonItem(image: .HomeTab, style: .plain, target: self, action: #selector(searchFunc))
//
//    }
//    func searchNavigation(){
//
//        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
//        navigationController?.navigationBar.barTintColor = AppColor.BackGround
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.WhiteColor]
//
//        navigationItem.rightBarButtonItem =  searchBtn
//    }
//    @objc func searchFunc(){
//    }
//    func backNavigation(){
//        navigationController?.navigationBar.tintColor = AppColor.LightGreen
//        navigationController?.navigationBar.barTintColor = AppColor.Clear
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.LightGreen]
//
//    }
//    func cartNavigation(){
////        let cartBtn = UIBarButtonItem(image: AppImages.cart, style: .plain, target: self, action: #selector(cartFunc))
////        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
////        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
////        navigationController?.navigationBar.barTintColor = AppColor.BackGround
////        navigationItem.rightBarButtonItem =  cartBtn
//    }
//    @objc func cartFunc(){
////        let viewO = ViewObjects()
////        let vc = viewO.searchWordsVC
////        show(vc!, sender: nil)
//        
//    }
//}//end of extension
