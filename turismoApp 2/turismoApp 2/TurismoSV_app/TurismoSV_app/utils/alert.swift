//
//  alert.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    public func ShowAlert(ptitle: String, pmessage: String) -> UIAlertController{
        let alertController = UIAlertController(title: ptitle.trimmingCharacters(in: .whitespacesAndNewlines), message: pmessage.trimmingCharacters(in: .whitespacesAndNewlines), preferredStyle: .alert);
        
        return alertController;
    }
    
}
