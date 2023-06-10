//
//  categoriasResponseModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/2/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class categoriasResponseModel{
    
    public struct DataloginResponse{
        let Idcategoria:String?
        let Nombre:String?
        let Descripcion:String?
        
    }
    
    public struct dataResponseModel:Codable{
        let Idcategoria:String?
        let Nombre:String?
        let Descripcion:String?
        
    }
}
