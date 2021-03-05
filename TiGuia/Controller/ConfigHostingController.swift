//
//  ConfigHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import SwiftUI
import UIKit

class ConfigHostingController: UIHostingController<ConfigView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ConfigView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
