//
//  PageableView.swift
//  Naqliah Client
//
//  Created by Ahmed Yasser on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import UIKit

protocol PageableView: UIScrollViewDelegate where Self: UIViewController {
    var scroll: UIScrollView {get}
    var isBottom: Bool {get}
    var pageablePresenter: PageablePresenter {get}
    func didEndScrolling()
}

extension PageableView {
    var isBottom: Bool {
      return (scroll.contentOffset.y + scroll.frame.height) >= scroll.contentSize.height
    }
        
    
    func didEndScrolling() {
        guard isBottom && !pageablePresenter.isFetching && pageablePresenter.lastPage > pageablePresenter.currentPage else {return}
        pageablePresenter.paginate()
    }

}
protocol ChatableView: UIScrollViewDelegate where Self: UIViewController {
    var scroll: UIScrollView {get}
    var isTop: Bool {get}
    var pageablePresenter: PageablePresenter {get}
    func didEndScrolling()
}

extension ChatableView {
    var isTop: Bool {
      return scroll.contentOffset.y <= 0.0
    }
        
    
    func didEndScrolling() {
        guard isTop && !pageablePresenter.isFetching && pageablePresenter.lastPage > pageablePresenter.currentPage else {return}
        pageablePresenter.paginate()
    }

}



