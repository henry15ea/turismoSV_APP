//
//  invitadosResponseModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class invitadosResponseModel{
    public struct DataloginResponse{
        var infoMsg:String?
        var serverApiStatus:String?
        
    }
    
    public struct dataResponseModel:Codable{
        var infoMsg:String?
        var serverApiStatus:String?
        
    }
}
