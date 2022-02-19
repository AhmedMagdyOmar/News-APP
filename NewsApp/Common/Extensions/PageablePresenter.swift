//
//  PageablePresenter.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 09/11/2021.
//  Copyright © 2021 Mohamed Akl. All rights reserved.
//

import Foundation

protocol PageablePresenter {
    var currentPage: Int {get}
    var lastPage: Int {get}
    var isFetching: Bool { get set}
    func paginate()
}
