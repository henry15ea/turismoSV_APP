//
//  invitadosModel.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/8/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class invitadosModel{
    
    struct invitadoDetalle: Codable {
        var nombre: String
        var apellido: String
        var n_doc: String
        var edad: Int
        var iddetalle: String
        var username: String
        var id_paquete: String
    }
    
}
