//
//  ChatMentorHostingController.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 07/12/20.
//

import Foundation
import UIKit
import SwiftUI

class ChatMentorHostingController: UIHostingController<ChatListMentorView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ChatListMentorView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
