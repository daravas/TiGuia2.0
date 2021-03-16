//
//  FavoriteHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import UIKit
import SwiftUI

class FavoriteHostingController: UIHostingController<FavoriteView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: FavoriteView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
