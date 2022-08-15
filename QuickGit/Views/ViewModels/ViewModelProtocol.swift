//
//  ViewModelProtocol.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 14/08/2022.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    var delegate: ViewModelDelegate? {get set}
    var itemCount: Int {get}
//    var dataModel: Decodable? {get set}
    func start() async throws
}

extension ViewModelProtocol {
    var itemCount: Int {
        return 0
    }
}

protocol ViewModelDelegate: UIViewController {
//    var viewModel: ViewModelProtocol
    func didUpdateDataModel()
}
