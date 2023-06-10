//
//  cls_routesApi.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class cls_routesApi{
    let hostApi:String="http://192.168.43.63:8080/api";
    private var routesApi = [String:String]();
    
    public init(){
        
        routesApi["login"] = (hostApi+"/public/longin");
        //rutas de peticion de datos
        routesApi["categorias"] = (hostApi+"/public/categorias");
        routesApi["ultimosPaquetes"] = (hostApi+"/public/paquetesDisponibles");
        routesApi["paquetesByCategoriaId"] = (hostApi+"/public/paquetesByCategoriaId");
        routesApi["historial"] = (hostApi+"/user/facturasEmitidas");
        routesApi["historialReservas"] = (hostApi+"/user/facturasReservadas");
        routesApi["completaReserva"] = (hostApi+"/user/facturaCompletedShop");
        routesApi["fpago"] = (hostApi+"/public/fpago");
        
        
        //realizar proceso de compra
        routesApi["InCompra"] = (hostApi+"/user/asignarPaquete");
        routesApi["InDetalle"] = (hostApi+"/user/detalleFactura");
        routesApi["InPersonsExtras"] = (hostApi+"/user/integrantesExtras");
        
        
        
        
        
        //routesApi["ultimosPaquetes"] = (hostApi+"");

        
    }
    
    public func fn_GetUrl(nmb: String)-> String{
        return routesApi[nmb]!;
    }
    
    
}
