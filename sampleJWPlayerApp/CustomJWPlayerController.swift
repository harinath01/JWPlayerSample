// swiftlint:disable all
//  CustomFullScreenViewController.swift
//  VideoPlayerKit
//
//  Created by Ateeq  Ahmad on 02/03/23.
//

import UIKit
import JWPlayerKit

class PlayerFullScreenViewController: JWFullScreenViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        displayInLandscape = true
        if #available(iOS 16, *) {
            DispatchQueue.main.async {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                self.navigationController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .landscapeRight))
            }
        } else {
            displayInLandscape = true
        }
    }
    
}
