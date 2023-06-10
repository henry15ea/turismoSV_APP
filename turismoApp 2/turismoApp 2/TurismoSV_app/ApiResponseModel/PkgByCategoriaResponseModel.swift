//
//  PkgByCategoriaResponseModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/5/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class PkgByCategoriaResponseModel{
    
    public struct DataloginResponse{
        let Idpaqueted:String?
        let Nombre:String?
        let Descripcion:String?
        let Direccion:String?
        let Img:String?
        let Precio:Double?
        let Cupos_disp:String?
        let Cuposllenos:String?
        let Fechainicial:String?
        let Fechafinal:String?
        let Estado:Bool?
        let Fechreg:String?
        
        
    }
    
    public struct dataResponseModel:Codable{
        let Idpaqueted:String?
        let Nombre:String?
        let Descripcion:String?
        let Direccion:String?
        let Img:String?
        let Precio:Double?
        let Cupos_disp:String?
        let Cuposllenos:String?
        let Fechainicial:String?
        let Fechafinal:String?
        let Estado:Bool?
        let Fechreg:String?
    }
}
