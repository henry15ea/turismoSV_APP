//
//  fpagoResponseModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation


class fpagoResponseModel{
    
    public struct DataloginResponse{
        let Idformapago:String?
        let Metodopago:String?
        let Descripcion:String?
        let Estado:Bool?
        
    }
    
    public struct dataResponseModel:Codable{
        let Idformapago:String?
        let Metodopago:String?
        let Descripcion:String?
        let Estado:Bool?

    }
}
