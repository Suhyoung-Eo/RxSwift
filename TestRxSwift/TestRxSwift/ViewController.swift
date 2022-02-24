//
//  ViewController.swift
//  TestRxSwift
//
//  Created by Suhyoung Eo on 2022/01/12.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable.from([1, 2, 3, 4, 5])
        
    }


}

