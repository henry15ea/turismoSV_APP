//
//  FacturaHeaderController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class FacturaHeaderController{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: facturaHeaderResponseMondel.DataloginResponse;
    //temporal
    private var imputModel: facturaEncabezadoModel.facturaHeader ;
    
    
    public func fn_getDataResponse() -> facturaHeaderResponseMondel.DataloginResponse{
        return self.modelData;
        
    }
    
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "InCompra");
        
        
        imputModel = facturaEncabezadoModel.facturaHeader(
            idencabezado: "null",
            idcuenta: "null",
            idformapago: "null",
            descuento: 15.0,
            monto: 0.00,
            state_emited: false,
            username: "null"
        );
        self.modelData = facturaHeaderResponseMondel.DataloginResponse(token_paquete: nil, infoMsg: nil, serverApiStatus: nil);

    
    }
    
    public func fn_SetModelData(pmodel:facturaEncabezadoModel.facturaHeader){
        imputModel = pmodel;
    }
    
    public func fn_FacturaRegister(pmodel: facturaEncabezadoModel.facturaHeader,completion: @escaping (Bool) -> Void){
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "idencabezado": pmodel.idencabezado!,
                "idcuenta": pmodel.idcuenta!,
                "idformapago": pmodel.idformapago!,
                "descuento": pmodel.descuento!,
                "monto": pmodel.monto!,
                "state_emited": pmodel.state_emited!,
                "username": pmodel.username!,
                
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
