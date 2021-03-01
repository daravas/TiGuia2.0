//
//  MacroAreaStudentViewController.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 26/02/21.
//

import Foundation
import UIKit
import SwiftUI

class MacroAreaStudentViewController: UIViewController {
    
    var macroAreaStudentUIHost: UIHostingController<MacroAreaUI>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        macroAreaStudentUIHost = UIHostingController(rootView: MacroAreaUI())
        macroAreaStudentUIHost?.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(macroAreaStudentUIHost!.view)
        
        let constraints = [
            macroAreaStudentUIHost!.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            macroAreaStudentUIHost!.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            macroAreaStudentUIHost!.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            macroAreaStudentUIHost!.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            macroAreaStudentUIHost!.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
//    @objc func tapStudent(sender: UITapGestureRecognizer) {
//        let vc = storyboard?.instantiateViewController(identifier: "secondVC")
//        vc!.modalPresentationStyle = .fullScreen
//        present(vc!, animated: true)
//    }
    
}
