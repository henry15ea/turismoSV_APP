//
//  facturaEncabezadoModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class facturaEncabezadoModel{
    
    public struct facturaHeader {
        let idencabezado:String?
        let idcuenta:String?
        let idformapago:String?
        let descuento:Double?
        let monto:Double?
        let state_emited:Bool?
        let username:String?
    }
    
}
