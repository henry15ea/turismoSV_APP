//
//  historialResponseModel.swift
//  TurismoSV_app
//
//  Created by ronald on 7/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class histoiralResponseModel{
    
    public struct DataloginResponse{
        let Id_factura:String?
        let Paquete:String?
        let Pasarela:String?
        let Descuento:String?
        let Monto:String?
        let Total:String?
        let Cupos:String?
        let Usuario:String?
        let Estado:String?
        
        
    }
    
    public struct dataResponseModel:Codable{
        let Id_factura:String?
        let Paquete:String?
        let Pasarela:String?
        let Descuento:String?
        let Monto:String?
        let Total:String?
        let Cupos:String?
        let Usuario:String?
        let Estado:String?

    }
}
