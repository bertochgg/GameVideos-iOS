import Foundation


//Cumplimos con el protocolo Codable para poder codificar y decodificar objetos JSON a tipos que swift pueda comprender y utilizar.




//Siempre que se requieran jalar datos de una API en formato JSON, entonces se debe estrcuturar el modelo para que pueda obtener los datos de todos los campos del archivo JSON

//Cuando se jalen datos JSON, las estructuras usadas para mapear los datos deben llevar el protocolo Codable, el cual hace que se descifre la informacion en tipos de datos que el compilador swift y Xcode puedan comprender
struct Games:Codable {
    var games:[Game]//Debido a que el JSON es un arreglo, se debe especificar un arreglo de tipo Game. Game es otra estructura donde se manejan de manera explicita los campos del JSON
}

//LAS PROPIEDADES DE LA ESTRUCTURA DEBEN DE MANERA IMPLICITA IGUALES A LOS NOMBRES DE LOS CAMPOS EN EL JSON
struct Game:Codable, Hashable {
    
    //Campos que posee el JSON
    var title:String
    var studio:String
    var contentRaiting:String
    var publicationYear:String
    var description:String
    var platforms:[String]
    var tags:[String]
    var videosUrls:videoUrl//Este campo difiere de los otros puesto que los url de los videos son de distinto tipo, mobile y tablet
    var galleryImages:[String]
    
}

//Estructura necesaria para mapear los datos en el campo videoUrls
struct videoUrl:Codable, Hashable {
   
    var mobile:String
    var tablet:String
    
}

struct Resultados:Codable {
    
    
    var results:[Game]
    
}
