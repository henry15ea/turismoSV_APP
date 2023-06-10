//
//  RegistroCotroller.swift
//  TurismoSV_app
//
//  Created by ronald on 9/6/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation
import UIKit

class RegistroController
{
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    //temporal
    
    
    //modelo respuesta
    public struct dataResponseModel:Codable{
        
        let infoMsg:String?
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "registro");
    }
    
    
    
    public func fn_GetApiStatus()->String{
        return messageApi;
        
    }
    var usernombre:String="";
    var nombre:String="";
    var apellido:String="";
    var edad:Int=0;
    var telefono:String="";
    var dir:String="";
    var correo:String="";
    var contra:String="";
    
    public func setDatos(uname: String,nombre:String,apellido:String,edad:Int,telefono:String,dir:String,correo:String,contra:String){
        usernombre=uname
        self.nombre=nombre
        self.apellido=apellido
        self.edad=edad
        self.telefono=telefono
        self.dir=dir
        self.correo=correo
        self.contra=contra
    }
    
    public func fn_login2(completion: @escaping (Bool) -> Void){
        //capturamos los datos del modelo
        
        //convertimos los datos en json
        let jsonObject:[String:Any] =
            [
                "id_cuenta": "null",
                "u_name": self.usernombre,
                "id_usuario": "null",
                "u_state": 0,
                "idusuario": "null",
                "nombre": self.nombre,
                "apellido": self.apellido,
                "edad": self.edad,
                "telefono": self.telefono,
                "direccion":self.telefono,
                "correo": self.correo,
                "id_rol": 0,
                "estado": 0,
                "u_pass": self.contra
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
                self.messageApi=infoMsg;
            }
            
            completion(true) // Call completion with true to indicate success
        }
        
        task.resume()
    }
    
}//end class
