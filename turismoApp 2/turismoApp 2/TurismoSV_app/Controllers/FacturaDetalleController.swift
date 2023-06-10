//
//  FacturaDetalleController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class FacturaDetalleController{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: facturaHeaderResponseMondel.DataloginResponse;
    //temporal
    private var imputModel: detalleFacturaModel.detalleFacturaData ;
    
    
    public func fn_getDataResponse() -> facturaHeaderResponseMondel.DataloginResponse{
        return self.modelData;
        
    }
    
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "InDetalle");
        
        
        imputModel = detalleFacturaModel.detalleFacturaData(username: nil, iddetalle: nil, idencabezado: nil, idpaqueted: nil, precio: nil, descuento: nil, monto: nil, cupos: nil);
        self.modelData = facturaHeaderResponseMondel.DataloginResponse(token_paquete: nil, infoMsg: nil, serverApiStatus: nil);
        
        
    }
    
    public func fn_SetModelData(pmodel: detalleFacturaModel.detalleFacturaData){
        imputModel = pmodel;
    }
    
    public func fn_FacturaDetalleRegister(pmodel: detalleFacturaModel.detalleFacturaData,completion: @escaping (Bool) -> Void){
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "iddetalle": pmodel.iddetalle!,
                "idencabezado": pmodel.idencabezado!,
                "idpaqueted": pmodel.idpaqueted!,
                "precio": pmodel.precio!,
                "descuento": pmodel.descuento!,
                "monto": pmodel.monto!,
                "cupos": pmodel.cupos!,
                "username":pmodel.username!,
                
                ];
        //convertimos los datos en formato json
        let bodyData = try? JSONSerialization.data(
            withJSONObject: jsonObject,
            options: []
        )
        
        let url = URL(string: urlname)
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false) // Call completion with false to indicate failure
                return
            }
            
            guard let data = data else {
                print("Error: no data")
                completion(false) // Call completion with false to indicate failure
                return
            }
            
            // Process the response data and set modelData's InfoMsg property
            let responseModel = try? JSONDecoder().decode(facturaHeaderResponseMondel.dataResponseModel.self, from: data);
            self.modelData.infoMsg = responseModel?.infoMsg;
            self.modelData.serverApiStatus = responseModel?.serverApiStatus;
            self.modelData.token_paquete = responseModel?.token_paquete;
            
            
            completion(true) // Call completion with true to indicate success
        }
        
        task.resume()
    }
    
    
}//end class
