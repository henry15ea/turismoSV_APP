//
//  FpagoController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/9/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation


class FpagoController {
    //variables de acceso
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: fpagoResponseModel.DataloginResponse;
    //var dataModels = [dataResponseModel]()
    var dataModels = [fpagoResponseModel.dataResponseModel]()
    
    //modelo de respuesta en el json data
    
    //estructura del json
    struct Response: Codable {
        let data: String
    }
    
    func getData() -> [fpagoResponseModel.dataResponseModel]? {
        return self.dataModels;
    }
    
    
    
    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "fpago");
        modelData = fpagoResponseModel.DataloginResponse(
            Idformapago: "null",
            Metodopago: "null",
            Descripcion: "null",
            Estado: false
        );
        
    }
    
    public func fn_GetFpago(completion: @escaping (Bool) -> Void){
        
        //capturamos los datos del modelo
        
        let url = URL(string: urlname)
        print("peticion a : \(urlname)");
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Perform HTTP Request
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            do {
                if let data = data {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    let data = response.data.data(using: .utf8) // convert the response string to UTF-8 data
                    let models = try decoder.decode([fpagoResponseModel.dataResponseModel].self, from: data!)
                    self.dataModels += models
                    
                    let demo = self.dataModels[0]
                    //print("datos obtenidos \(demo)")
                    completion(true) // Call completion with false to indicate failure
                    return
                } else {
                    print("No se pudo obtener los datos")
                    completion(false) // Call completion with false to indicate failure
                    return
                }
            } catch let error {
                print("Error al analizar el archivo JSON: \(error.localizedDescription)")
                completion(false) // Call completion with false to indicate failure
                return
            }
        }
        
        task.resume()
    }
    
}//end class

