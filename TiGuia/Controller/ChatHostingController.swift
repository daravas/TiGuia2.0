//
//  ChatHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import UIKit
import SwiftUI

class ChatHostingController: UIHostingController<TempUI> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: TempUI());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
