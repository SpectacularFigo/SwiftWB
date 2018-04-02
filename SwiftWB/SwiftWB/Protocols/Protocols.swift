//
//  Protocols.swift
//  SwiftWB
//
//  Created by Figo Han on 2018-04-01.
//  Copyright © 2018 Figo Han. All rights reserved.
//

import UIKit

protocol CanTriggerApologyAlert {
    func popupApologyAlert(controller: UIViewController?)
}

extension CanTriggerApologyAlert where Self: UIViewController {
    func popupApologyAlert(controller: UIViewController?) {
        guard let controller = controller else { return }
        let alertController = UIAlertController(title: NSLocalizedString("apology_alert_title", comment: ""), message: NSLocalizedString("apology_alert_body", comment: ""), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("general_wordings_ok", comment: ""), style: .default, handler: nil)
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
