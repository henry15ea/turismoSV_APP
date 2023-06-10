//
//  cls_ImagenUrl.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/4/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class cls_ImagenUrl{
    
    static public func fn_LoadImageUrl(from urlString: String, defaultImage: String) -> UIImage? {
        guard let url = URL(string: urlString) else {
            return UIImage(named: defaultImage)
        }
        
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("Error al cargar la imagen: \(error.localizedDescription)")
            return UIImage(named: defaultImage)
        }
    }

    
}
