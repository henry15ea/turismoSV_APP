//
//  ultimosPaquetesController.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/4/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class ultimosPaquetesController {
    //variables de acceso
    private let url = cls_routesApi();
    private var urlname:String="";
    private var messageApi="";
    private var modelData: ultimosPkgResponseModel.DataloginResponse;
    //var dataModels = [dataResponseModel]()
    var dataModels = [ultimosPkgResponseModel.dataResponseModel]()
    
    //estructura del json
    struct Response: Codable {
        let data: String
    }
    
    func getData() -> [ultimosPkgResponseModel.dataResponseModel]? {
        return self.dataModels;
    }
    

    public func fn_GetApiStatus()->String{
        return messageApi.trimmingCharacters(in: .whitespacesAndNewlines);
        
    }
    
    public init(){
        //iniciando elementos
        urlname = url.fn_GetUrl(nmb: "ultimosPaquetes");
        modelData = ultimosPkgResponseModel.DataloginResponse(
            Idpaqueted: "null",
            Nombre: "null",
            Descripcion: "null",
            Direccion: "null",
            Img: "null",
            Precio: 0.0,
            Cupos_disp: "0",
            Cuposllenos: "0",
            Fechainicial: "null",
            Fechafinal: "null",
            Estado: false,
            Fechreg: "null"
        )
    }
    
    public func fn_GetUltimosPaquetes(completion: @escaping (Bool) -> Void){
        
        self.dataModels=[]
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
                    let models = try decoder.decode([ultimosPkgResponseModel.dataResponseModel].self, from: data!)
                    self.dataModels += models
                    
                    let demo = self.dataModels.count;
                    print("datos obtenidos \(demo)")
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

