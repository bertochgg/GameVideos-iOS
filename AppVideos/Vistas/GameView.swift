import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
    
    var url:String
    var titulo:String
    var studio:String
    var calificacion: String
    var anoPublicacion: String
    var descripcion:String
    var tags:[String]
    var imgsUrl: [String]
    
    var body: some View {
        
    
        ZStack {
            
            Color("Marine").ignoresSafeArea()
           
            VStack {
                video(url: url).frame(height:300)
                
                
                ScrollView {
                
                   //Informacion Video
                   
                    videoInfo(titulo:titulo,studio:studio,calificacion:calificacion,anoPublicacion:anoPublicacion,descripcion:descripcion,tags:tags)
                        .padding(.bottom)
               
                    Gallery(imgsUrl:imgsUrl)
                    
                    Comentarios()
                    
                    JuegosSimilares()
                
                }.frame( maxWidth: .infinity)
            }
      
        }
   
    
    
    }
}

struct video:View {
    
    var url:String
    
    var body: some View{
        
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
        
        
        
    }
    
    
    
}

struct JuegosSimilares: View{
    
    var body: some View{
        VStack(alignment: .leading){
            Text("JUEGOS SIMILARES").foregroundColor(.white).fontWeight(.bold).font(.title).padding(.top, 20).padding(.leading)
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    
                }
            }
        }
    }
}

struct Comentarios: View{
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("COMENTARIOS").foregroundColor(.white).font(.title).padding(.leading).fontWeight(.bold).padding(.top, 20)
            //Item 1
            VStack(alignment: .leading){
                HStack{
                    Image("perfilEjemplo").resizable().aspectRatio(contentMode: .fit).frame(width: 60, height: 60).padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                    VStack(alignment: .leading){
                        Text("Geoff Atto").foregroundColor(.white).fontWeight(.bold)
                        
                        Text("Hace 7 d").foregroundColor(.white).font(.subheadline)
                    }.padding(.top, 12).padding(.leading, 8)
                }
                
                VStack(alignment: .center) {
                    Text("He visto que como media tiene una gran calificacion, y estoy completamente de acuerdo. Es el mejor juego que jugado sin ninguna duda, combina una buena trama con una buenisima experiencia de juego libre gracias a su inmenso mapa y actividades.").foregroundColor(.white).padding(EdgeInsets(top: 0, leading: 12, bottom: 15, trailing: 12)).frame(alignment: .center)
                }
            }.frame(maxWidth: .infinity, alignment: .leading).background(Color("Blue-Gray")).clipShape(RoundedRectangle(cornerRadius: 10)).padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
            
            //Item 2
            VStack(alignment: .leading){
                HStack{
                    Image("perfilEjemplo").resizable().aspectRatio(contentMode: .fit).frame(width: 60, height: 60).padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                    VStack(alignment: .leading){
                        Text("Alvy Baack").foregroundColor(.white).fontWeight(.bold)
                        
                        Text("Hace 7 d").foregroundColor(.white).font(.subheadline)
                    }.padding(.top, 12).padding(.leading, 8)
                }
                
                VStack(alignment: .center) {
                    Text("He visto que como media tiene una gran calificacion, y estoy completamente de acuerdo. Es el mejor juego que jugado sin ninguna duda, combina una buena trama con una buenisima experiencia de juego libre gracias a su inmenso mapa y actividades.").foregroundColor(.white).padding(EdgeInsets(top: 0, leading: 12, bottom: 15, trailing: 12)).frame(alignment: .center)
                }
            }.frame(maxWidth: .infinity, alignment: .leading).background(Color("Blue-Gray")).clipShape(RoundedRectangle(cornerRadius: 10)).padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
        }
        
        
    }
}


struct videoInfo:View {
    
    var titulo:String
    var studio:String
    var calificacion:String
    var anoPublicacion:String
    var descripcion:String
    var tags:[String]
    
    
    
    var body: some View{
        
        
        
        VStack(alignment:.leading ){
            
          Text("\(titulo)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding(.leading)
            .fontWeight(.bold)
            
            HStack{
                
                
                Text("\(studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                    .padding(.leading)
                    .fontWeight(.bold)
                
                Text("\(calificacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                
                Text("\(anoPublicacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top,5)
                
                
                
            }
            
           Text("\(descripcion)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top,5)
                .padding(.leading)
            
            
            HStack{
                
                
                ForEach(tags, id:\.self){
                    
                    tag in
                    
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top,4)
                        .padding(.leading)
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
        }.frame( maxWidth: .infinity,  alignment: .leading)
        
        
        
        
    }
}

struct Gallery:View {
    
    
    var imgsUrl:[String]
    
    let formaGrid = [
    
        GridItem(.flexible())
    
    ]
    
    
    var body: some View{
        
        
        
        VStack(alignment:.leading ){
           
           Text("GALERÍA")
            .foregroundColor(.white)
            .font(.title)
            .padding(.leading)
            .fontWeight(.bold)
            
            
            ScrollView(.horizontal){
              
                LazyHGrid(rows:formaGrid,spacing:8){
                    
                    
                    ForEach(imgsUrl,id: \.self){
                        
                       imgUrl in
                        
                       //Deplegar imagenes del servidor por medio de url
                        
                        KFImage(URL(string: imgUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    
                    
                    
                }
                
                
                
                
            }.frame( height: 180)
            
            
            
            
            
        }.frame( maxWidth: .infinity, alignment: .leading)
        
        
        
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "Ejemplo.com", titulo: "Sonic", studio: "Sega", calificacion: "E+", anoPublicacion: "1991", descripcion: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", tags: ["plataformas","mascota"], imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
    }
}
