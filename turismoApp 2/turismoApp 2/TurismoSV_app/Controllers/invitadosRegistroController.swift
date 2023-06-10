//
//  invitadosRegistroController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation


class invitadosRegistroController{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: invitadosResponseModel.DataloginResponse;
    //temporal
    var imputModel = [invitadosModel.invitadoDetalle]();
    
    
    public func fn_getDataResponse() -> invitadosResponseModel.DataloginResponse{
        return self.modelData;
        
    }
    
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "InPersonsExtras");
        
        self.modelData = invitadosResponseModel.DataloginResponse(infoMsg: nil, serverApiStatus: nil);
        
        
    }
    
    public func fn_SetModelData(pmodel: [invitadosModel.invitadoDetalle] ){
        imputModel = pmodel;
    }
   
    
   public func fn_InvitadoRegister(jsonString: String, completion: @escaping (Bool) -> Void) {
        do{
            let bodyData = jsonString.data(using: .utf8)
            
            //convertimos los datos en formato json
            
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
                let responseModel = try? JSONDecoder().decode(invitadosResponseModel.dataResponseModel.self, from: data)
                if let infoMsg = responseModel?.infoMsg {
                    self.modelData.infoMsg = responseModel?.infoMsg;
                    self.modelData.serverApiStatus = responseModel?.serverApiStatus;
                }
                
                completion(true) // Call completion with true to indicate success
                
            }
            
            task.resume()
        }catch{
            completion(false)
        }

    }

    
}//end class
