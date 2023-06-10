//
//  loginResponseModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class LoginResponseModel{
    
    public struct DataloginResponse{
        var user:String?
        var token_id:String?
        var mail:String?
        var role_user:String?
        var InfoMsg:String?
        var accessLogin:String?
        var ServerApiStatus:String?
    }
    
    public struct dataResponseModel:Codable{
        let user:String?
        let token_id:String?
        let mail:String?
        let role_user:String?
        let infoMsg:String?
        let accesLogin:String?
        let serverApiStatus:String?
    }
}
