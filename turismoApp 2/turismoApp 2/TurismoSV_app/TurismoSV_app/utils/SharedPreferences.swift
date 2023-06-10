//
//  SharedPreferences.swift
//  TurismoSV_app
//
//  Created by HenryGuzman on 6/1/23.
//  Copyright © 2023 HenryGuzman. All rights reserved.
//

import Foundation

class SharedPreferences{
    
    
    static public func fn_SaveData(data: String, key: String) -> Bool{
        do{
            let keyString:String = key;
            let dataString:String = data;
            UserDefaults.standard.set(
                dataString.trimmingCharacters(in: .whitespacesAndNewlines),
                forKey: keyString.trimmingCharacters(in: .whitespacesAndNewlines)
            );
            
            return true;
        }catch let _error{
            return false;
        }
    }
    
    static public func fn_GetData(key: String) -> String{
        do{
            let dataKey:String = key.trimmingCharacters(in: .whitespacesAndNewlines);
            if let dataString = UserDefaults.standard.object(forKey: dataKey) as? String {
                return dataString;
            } else {
                return "null";
            }

        }catch{
            return "error";
        }
    }
    
}
