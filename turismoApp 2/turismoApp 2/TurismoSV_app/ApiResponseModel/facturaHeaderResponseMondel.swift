//
//  facturaHeaderResponseMondel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class facturaHeaderResponseMondel{
    
    public struct DataloginResponse{
        var token_paquete:String?
        var infoMsg:String?
        var serverApiStatus:String?
    }
    
    public struct dataResponseModel:Codable{
        var token_paquete:String?
        var infoMsg:String?
        var serverApiStatus:String?
        
    }
}
