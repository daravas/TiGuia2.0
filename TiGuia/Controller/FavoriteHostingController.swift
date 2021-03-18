//
//  FavoriteHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import UIKit
import SwiftUI

class FavoriteHostingController: UIHostingController<Favorite> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: Favorite());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

