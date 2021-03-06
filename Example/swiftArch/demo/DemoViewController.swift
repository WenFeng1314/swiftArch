//
//  DemoViewController.swift
//  swiftArch
//
//  Created by czq on 2018/5/14.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit
import RxSwift
import swiftArch
class DemoViewController: BaseViewController {

     
    var socailAppService:SocialAppService=DataManager.socailAppService
  
    var count=0
    
    override func initView() {
        super.initView()
        let label=UILabel()
        label.text="界面是 demo包下的 DemoViewController\n,一定来看看源码,mock功能的演示"
        label.numberOfLines=0
        label.textColor=UIColor.black
        label.font=UIFont.systemFont(ofSize: 20)
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        UIApplication.shared.keyWindow?.makeToast("这个开小差是我故意的,请点一下空白处", duration: 3)
        
    }
   
    
  
    
    override func start(){
        if count==0 {
            self.showLoading()
            self.loadData(userId: "manondidi", password: "12345566")//错误的账号密码 肯定失败
            count+=1
        }else{
            self.loadMockData(userId: "manondidi", password: "12345566")
        }
        
    }

    
    func loadData(userId:String,password:String){
        self.showLoading()
        socailAppService.rxGetUser(userId: userId, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (bannerArticleList) in
                    self?.showContent()
                }, onError: {[weak self]  (error) in
                    self?.showError()
            }).disposed(by: disposeBag)
    }
    
    
    func loadMockData(userId:String,password:String){
        self.showLoading()
        
        socailAppService.rxGetUserMock(userId: userId, password: password)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (bannerArticleList) in
                    self?.showContent()
                }, onError: {[weak self]  (error) in
                    self?.showError()
                    self?.view.makeToast(error.localizedDescription)
            }).disposed(by: disposeBag)
                
        }
    

    

}
