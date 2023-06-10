//
//  LoginController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 5/29/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class LoginController
{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: LoginResponseModel.DataloginResponse;
    //temporal
    private var imputModel: LoginModel.UserLogin ;

    //modelo respuesta
    public struct dataResponseModel:Codable{
        let user:String?
        let token_id:String?
        let mail:String?
        let role_user:String?
        let infoMsg:String?
        let accesLogin:String?
        let serverApiStatus:String?
    }
    
    public func fn_getDataResponse() -> LoginResponseModel.DataloginResponse{
        return self.modelData;
        
    }

    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "login");
        modelData  = LoginResponseModel.DataloginResponse(
            user: "n1",
            token_id: "n1",
            mail: "n1",
            role_user: "n1",
            InfoMsg: "n1",
            accessLogin: "n1",
            ServerApiStatus: "n1"
        );
        
        
        
        imputModel = LoginModel.UserLogin(username: "demo", password: "demo");
    }
    
    public func fn_SetModelData(pmodel: LoginModel.UserLogin){
        imputModel = pmodel;
    }
    
    public func fn_login2(pmodel: LoginModel.UserLogin,completion: @escaping (Bool) -> Void){
        //capturamos los datos del modelo
        let uname = pmodel.username;
        let upass = pmodel.password;
        
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "usuario": uname!.trimmingCharacters(in: .whitespacesAndNewlines),
                "clave": upass!.trimmingCharacters(in: .whitespacesAndNewlines)
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
            let responseModel = try? JSONDecoder().decode(dataResponseModel.self, from: data)
            if let infoMsg = responseModel?.infoMsg {
                self.modelData.user = responseModel?.user;
                self.modelData.token_id = responseModel?.token_id;
                self.modelData.mail = responseModel?.mail;
                self.modelData.role_user = responseModel?.role_user;
                self.modelData.InfoMsg = infoMsg;
                self.modelData.accessLogin = responseModel?.accesLogin;
                self.modelData.ServerApiStatus = responseModel?.serverApiStatus;
            }
            
            completion(true) // Call completion with true to indicate success
        }
        
        task.resume()
    }
    
}//end class
