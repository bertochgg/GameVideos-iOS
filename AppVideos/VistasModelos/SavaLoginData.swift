//
//  SavaLoginData.swift
//  AppVideos
//
//  Created by Cesar Humberto Grifaldo Garcia on 11/10/22.
//

import Foundation

class SaveLoginData{
    var correo = ""
    var contrasenia = ""
    var confContrasenia = ""
    
    func guardarDatos(correo:String,contrasena:String) -> Bool {
        
        print("Dentro de funcion Guardar Datos obtuve: \(correo) + \(contrasena)")
        UserDefaults.standard.set([correo,contrasena, confContrasenia], forKey: "datosUsuario")
        
        return true
    }
    
    func recuperarDatos() -> [String] {
        
        let datosUsuario:[String] = UserDefaults.standard.stringArray(forKey: "datosUsuario")!
        
        print("Estoy en metodo recuperar datos y recupere: \(datosUsuario)")
        
        return datosUsuario
    }
    
    func validar(correo:String,contrasena:String) -> Bool {
        
        var correoGuardado = ""
        var contraseñaGuardada = ""
        
        
        print("revisando si tengo datos en user defaults con correo: \(correo) y contraseña: \(contrasena)")
        
        
        
        if UserDefaults.standard.object(forKey: "datosUsuario") != nil {
            
            correoGuardado = UserDefaults.standard.stringArray(forKey: "datosUsuario")![0]
            
            contraseñaGuardada = UserDefaults.standard.stringArray(forKey: "datosUsuario")![1]
            
            print("El correo guardado es: \(correoGuardado) y la contraseña guardada es: \(contraseñaGuardada)")
            
            if (correo == correoGuardado && contrasena == contraseñaGuardada){
                
                return true
            }else{
                return false
            }
              
        }else{
            
            print("No hay datos de usuario grabados en el objeto global de userdefaults")
            return false
        }
        
    }
    
}
