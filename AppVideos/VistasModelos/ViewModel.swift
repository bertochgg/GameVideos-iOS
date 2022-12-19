import Foundation


//Clase con protocolo ObservableObject, este protocolo hace que los elementos dentro de esta clase puedan ser visto en otra instancia con wrapper ObservedObject
class ViewModel: ObservableObject {
 
// 1.
    //Informacion con wrapper Published para ser publicada en algun lado, en este caso se debe publicar en GamesView
  @Published var gamesInfo = [Game]()//variable de tipo arreglo con elementos Game
  
    
    init() {//Inicializador
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!//Se obtiene la URL de la API a hacer request
        var request = URLRequest(url: url)//variable request que usa la palabra reservada URLRequest con parametro url al cual le asignamos la variable url
        request.httpMethod = "GET"//Definicion del metodo http por el cual obtendremos la informacion = GET
        
        // 2.
        URLSession.shared.dataTask(with: request) {(data, response, error) in//Sesion para abrir el canal y obtener la informacion requerida
        //La sesion tiene q ir con argumentos y retornara 3 cosas: los datos, la respues del servidor y un error en caso de haber uno
            
            //do catch para las excepciones
            do {
                if let jsonData = data {
                    // 3.
                    print("tamañoJSON: \(jsonData)")
                    
                    let decodedData = try JSONDecoder().decode([Game].self, from: jsonData)//JSONDecoder decodifica informacion JSON
                    //.decode contiene el tipo de dato en como se leera la informacion, .self se refiere al tipo de dato que es = Game,
                    //jsonData es igual data de la sesion abierta
                    
                    print("JSONDecodificado: \(decodedData)")
                    
                    //En otro hilo de CPU realizar las tareas de la recabacion de datos de forma asincrona
                    DispatchQueue.main.async {
                        //Llenar propiedad games info con el arreglo de datos decodificados de nuestro json original
                        self.gamesInfo.append(contentsOf: decodedData)
                       
                    }
                    
                    
                } else {
                    print("No existen datos en el json recuperado")
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()//Funcion resume para ejecutar el request
    }
    

}
