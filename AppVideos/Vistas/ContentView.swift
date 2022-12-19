//
//  ContentView.swift
//  AppVideos
//
//  Created by Cesar Humberto Grifaldo Garcia on 28/09/22.
//

import SwiftUI


//Las estructuras tienen que llevar el protocolo View que sirve para aplicar elementos graficos sw swiftui
struct ContentView: View {
    //Siempre una estructura con protocolo View debe tener dentro suyo una variable body
    var body: some View {
        //Dentro de la variable body debe haber al menos un elementos grafico UI para que no de errores
        NavigationView {
            //Tenemos porq al momento de inciar sesion se debe dirigir a la vista Home
            ZStack{
                //ZStack funciona como sobreposicion, de atras hacia adelante
                Color(red: 18/255, green: 31/255, blue: 61/255, opacity: 100).ignoresSafeArea()//Al ultimo, sirve como background que da color azul oscuro. Ademas ignora el Safe Area para pintar toda la pantalla
                VStack{
                    //Vertical Stack, nos permite acomodar elementos verticalmente
                    //Primero va la imagen de logo
                    
                    //La imagenes pueden reestructuradas para que en caso de ser necesio, se editen a la forma que se requiera
                    //Los modificadores que se usan habitualmente son:
                    //resizable: permite alterar la imagen
                    //aspectRatio: contentMode especifica como se re dibuja la imagen
                    //frame: se le asigna un cierto tamanio de caja al elemento
                    //padding: aniade un espacio interno al elemento grafico
                    Image("AppLogo").resizable().aspectRatio(contentMode: .fit).frame(width: 250).padding(.bottom, 60)
                    
                    //Modulacion
                    //Se puede crear modulos que contengan elementos graficos para hacer el codigo menos pesado y poder reutilizar elementos en caso de ser necesario
                    InicioYRegistroView()
                }
            }
            
        //Un NavigationView al momento de pasar a otra vista, se aniade un boton para el regreso a la vista anterior, para que esto no suceda y afecte al disenio primario de la app, se aniade navigationBarHidden
        }.navigationBarHidden(true)
        
    }
}


//Modulo InicioYRegistroView
struct InicioYRegistroView:View {
    //Variables wrapping se utilizan sobre variable cuando se requiere que estas hagan o ejecuten determinada accion
    //@State funciona como un wrapper que hace que la variable "sobreviva" a los diferentes cambios que pueda tener la vista
    
    
    //Esta variable sirve como un pulsador que mantiene la logica de si el usuario esta en la seccion de incio se sesion o de registro. Se le asigna true para que automaticamente al iniciar la vista se dirija a inicio de sesion
    @State var tipoInicioSesion: Bool = true
    
    var body: some View{
        
        VStack{
            
            //Horizontal Stack mantiene todos los elementos graficos d emanera horizontal
            HStack{
                //Spacer()
                
                //Este HStack contiene contiene los elementos botones de INICIO DE SESION y REGISTRATE
                Button("INICIO DE SESIÓN") {
                    tipoInicioSesion = true
                    print("pantalla inicio de sesion")
                //Cualquier elemento grafico contine diferentes modificadores que afectan en su aspecto
                //foregroundColor: afecta el color de la letra
                //A los modificadores se les puede asignar una condicion ternaria si se requiere cierta interactividad
                }.foregroundColor(tipoInicioSesion ? .white : .gray)
                Spacer()
                Button("REGISTRATE") {
                    tipoInicioSesion = false
                    print("pantalla registro")
                }.foregroundColor(tipoInicioSesion ? .gray : .white)
                //Spacer()
                
            //El padding horizontal puede centrar nuestros elementos
            }.padding(.horizontal, 35)
            Spacer(minLength: 42)
            
            //Control de vista mediante boolanos
            if tipoInicioSesion{
                //Si es true se mostrara la vista en la estructura InicioSesionView()
                InicioSesionView()
            }else{
                //Si es false, entonces se muestra la vista de registro
                RegistroView()
            }
        }
        
    }
}


//Modulo de vista de lo que se muestra en INICIO DE SESION
struct InicioSesionView: View{
    //variables que contendran la informacion que el usuario inserte
    @State var correo:String = ""
    @State var contraseña:String = ""
    @State var isNotUserFound = false
    
    //variable que funciona como accionador para decidir si ir a la vista Home o no
    @State var isPantallaHomeActive: Bool = false
    
    var body: some View {
        
        //ScrolView se utiliza si el contenido sobrepasa la vista del dispositivo. Funciona para scrollear
        ScrollView{
            
            //VStack para acomodar elementos de manera vertical
            //Se pueden pasar parametros en Stacks para controlar diferentes cosas, aligmente mueve sus elementos a cierta posicion
            VStack(alignment: .leading){
                
                Text("Correo electrónico")
                    .foregroundColor(Color(red: 63/255, green: 202/255, blue: 160/255, opacity: 1.0))
                
                //Se usa el ZStack para combinar tanto el TextField y el placeholder
                ZStack(alignment: .leading){
                    //Si el textfield esta vacio entonces se utiliza un elemento text para poner un placeholver
                    if correo.isEmpty {
                        //Aniade color al placeholder
                        Text(verbatim: "ejemplo@gmail.com").font(.caption).foregroundColor(.gray)
                    }
                    //TextField o cualquier otra variable debe ser enlazada a una variable mediante $
                    
                    TextField("", text: $correo).foregroundColor(.white)
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cyan")).padding(.bottom)
                
                
                Text("Contraseña").foregroundColor(.white)
                
                
                ZStack(alignment: .leading){
                    if contraseña.isEmpty {
                        Text("Escribe tu contraseña").font(.caption).foregroundColor(.gray)

                    }
                    
                    //SecureField se utiliza para contrasenias
                    SecureField("", text: $contraseña).foregroundColor(.white)
                    
                }
                
                Divider()
                    .frame(height: 1)
                    .background(Color("Dark-Cyan"))
                
                Text("¿Olvidaste tu contraseña?")
                                    .font(.footnote)
                                    .frame(width: 300,  alignment: .trailing)
                                    .foregroundColor(Color("Dark-Cyan"))
                                    .padding(.bottom, 40)
                                
                                //Buton de Inciiar Sesion
                
                                Button(action: iniciarSesion, label: {
                                    Text("Iniciar Sesión")
                                        .fontWeight(.bold)//Aumentar el peso de letra
                                        .foregroundColor(.white)
                                        .frame( maxWidth: .infinity, alignment: .center)
                                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))//padding con diferentes dimensiones
                                        .overlay(RoundedRectangle(cornerRadius: 6)//Modificadores para cuadro bonito
                                                    .stroke(Color("Dark-Cyan"), lineWidth: 3).shadow(color: .white, radius: 6))
                                }).alert(isPresented: $isNotUserFound) {
                                    Alert(title: Text("Error"), message: Text("El usuario no existe"), dismissButton: .default(Text("Entendido")))
                                }
                                
                                
 
                                Text("Iniciar sesión con redes sociales").frame( maxWidth: .infinity,  alignment: .center).foregroundColor(.white)
                                
                                
                                HStack {
                                        
                    
                                        Button(action: {print("Inicio de sesión con Facebook")}) {
                                            Text("Facebook")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.vertical, 3.0)
                                                .frame( maxWidth: .infinity, alignment: .center)
                                                .background(Color("Blue-Gray"))
                                                .clipShape(RoundedRectangle(cornerRadius: 4.0))//DArle una forma predefinida al boton
                                        }
                                        
                                        .padding()
                                    
                                    
                                    
                                    Button(action: {print("Inicio de sesión con Twitter")}) {
                                        Text("Twitter")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 3.0)
                                            .frame( maxWidth: .infinity, alignment: .center)
                                            .background(Color("Blue-Gray"))
                                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                    }.padding()
                                    
                                }

            }.padding(.horizontal, 35.0)
            
            
            //NavigationLink se ele especifica a que vista ira
            //isActive determina una valoracion booleana, la variable isPantallaHomeActive se inicializa como false para no pasar a la vista Home
            //Label, como no se requiere que existe una texto o algo se pone EmptyView()
            NavigationLink(destination: Home(),
                           isActive: $isPantallaHomeActive,
                           label: {EmptyView()})
        }
        

        
    }
    
    //Funcion que se emplea en el boton de Iniciar Sesion en su parametro action
    func iniciarSesion() {
            
            let iniciarSesion = SaveLoginData()
            let resultado = iniciarSesion.validar(correo: self.correo, contrasena: self.contraseña)
        
        if resultado == true{
            isNotUserFound = false
            isPantallaHomeActive = true
        }else{
            isNotUserFound = true
        }
            
        }
}

struct RegistroView: View{
        @State var correo:String = ""
        @State var contraseña:String = ""
        @State var confirmacionContraseña:String = ""
        @State var isContraseñaConfirmed = false
        var manager = SaveLoginData()
        
        
        var body: some View {
            
            
            ScrollView{
                
                
                VStack(alignment: .center){
                   
                    Text("Elije una foto de perfíl")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        
                    
                    Text("Puedes cambiar o elejirla más adelante")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .padding(.bottom)
                   
                    
                    //Se pueden asignar Elementos y Stacks dentro de label
                    Button(action: tomarFoto, label: {
                        ZStack{
                            
                            Image("perfilEjemplo").resizable().aspectRatio(contentMode: .fit).frame(width: 80.0, height: 80.0)
                            
                            Image(systemName: "camera").foregroundColor(.white)
           
                            
                        }
                    })
                    
                    
                   
                     
                        
                    
                }.padding(.bottom, 18)
                
              
                
                VStack(alignment: .leading){
                    
                    
                    VStack(alignment: .leading){
                    
                 
                   
                        
                    Text("Correo electrónico")
                        .foregroundColor(Color(red: 63/255, green: 202/255, blue: 160/255, opacity: 1.0))
                    
                    ZStack(alignment: .leading){
                        if correo.isEmpty { Text(verbatim:"ejemplo@gmail.com").font(.caption).foregroundColor(.gray) }
                        
                        TextField("", text: $correo).foregroundColor(.white)
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color("Dark-Cyan")).padding(.bottom)
                    
                    
                    Text("Contraseña").foregroundColor(.white)
                    
                    
                    ZStack(alignment: .leading){
                        if contraseña.isEmpty { Text("Introduce tu contraseña").font(.caption).foregroundColor(.gray) }
                        
                        SecureField("", text: $contraseña).foregroundColor(.white)
                        
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color("Dark-Cyan"))
                    
                    Text("Confirmar contraseña*").foregroundColor(.white)
                    
                    
                    ZStack(alignment: .leading){
                        if confirmacionContraseña.isEmpty { Text("Reintroduce tu contraseña").font(.caption).foregroundColor(.gray) }
                        
                        SecureField("", text: $confirmacionContraseña).foregroundColor(.white)
                        
                    }
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color("Dark-Cyan"))
                        .padding(.bottom)
                     
                        
                    }
                    
                    Button(action: registrarse, label: {
                        Text("REGÍSTRATE")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("Dark-Cyan"), lineWidth: 3)
                                .shadow(color: Color("Dark-Cyan"), radius: 6)
                                    )
                    }).padding(.bottom, 20).alert(isPresented: $isContraseñaConfirmed) {
                        Alert(title: Text("Error"), message: Text("Las contraseñas no coinciden, favor de verificar"), dismissButton: .default(Text("Entendido")))
                    }
                    
                    
                    
                  
                            
                    Text("Regístrate con redes sociales").frame( maxWidth: .infinity,  alignment: .center).foregroundColor(.white)
                    
                    
                    HStack {
                            
        
                            Button(action: {print("Inicio de sesión con Facebook")}) {
                                Text("Facebook")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 3.0)
                                    .frame( maxWidth: .infinity, alignment: .center)
                                    .background(Color("Blue-Gray"))
                                    .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                    
                            }
                            
                            .padding()
                        
                        
                        
                        Button(action: {print("Inicio de sesión con Twitter")}) {
                            Text("Twitter")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 3.0)
                                .frame( maxWidth: .infinity, alignment: .center)
                                .background(Color("Blue-Gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                        }.padding()
                        
                    }
                    
                }.padding(.horizontal, 42.0)
                
        
           }
            

        }

        
        func tomarFoto()  {
            print("Tomo foto")
            //logica de tomar fotos.
        }
        
        //Puede llamarse como gustes, ya sea registrate o registrarse, el punto es que sea una acción.
        func registrarse()  {
            
            if self.contraseña != self.confirmacionContraseña{
                isContraseñaConfirmed = true
            }else{
                isContraseñaConfirmed = false
                
                let registroDatos = SaveLoginData()
                registroDatos.guardarDatos(correo: self.correo, contrasena: self.contraseña)
            }
            
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
