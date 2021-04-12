//
//  ChatHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 03/12/20.
//

import Foundation
import UIKit
import SwiftUI

class ChatHostingController: UIHostingController<ChatList> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ChatList());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
