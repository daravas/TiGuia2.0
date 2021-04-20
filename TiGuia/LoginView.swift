//
//  LoginView.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 28/02/21.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var isEditing = false
    @Binding var showSignIn: Bool
    @Binding var userName: String
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading){
                    Image("tiguia")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        
                    
                    Text("Email")
                        .font(.custom("Raleway-Regular", size: 18))
                        .padding(.horizontal)
                        
                    TextField(
                            "  aluno123@gmail.com",
                             text: $username
                                
                        ) { isEditing in
                            self.isEditing = isEditing
                        } onCommit: {
                           // validate(name: username)
                        }
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    .frame(height: 32)

                    .border(Color(UIColor(.titleColor)), width: 2)
                    .cornerRadius(10)
                    .padding([.leading, .bottom, .trailing])
                    
                    Text("Senha")
                        .font(.custom("Raleway-Regular", size: 18))
                        .padding(.horizontal)
                 
                    SecureField(
                           "  Senha",
                           text: $username
                       ) {
                          // handleLogin(username: username, password: password)
                       }
                    .frame(height: 32)

                    .border(Color(UIColor(.titleColor)), width: 2)
                    .cornerRadius(10)
                    .padding()
                    
                    HStack{
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Esqueceu sua senha?")
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .underline()
                                
                        }).padding(.horizontal)
                        
                    }
                    Button(action: {
                    }, label: {
                        Spacer()
                        Text("Entrar")
                            .font(.custom("Raleway-Bold", size: 18))
                            .foregroundColor(.lightColor)
                        Spacer()
                        
                    }).padding()
                    .clipped()
                    .background(Color.btnColor) // aqui precisou usar o Color.
                    .cornerRadius(10)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.top,30)
                    .padding()
                    
                    Button(action: {
                    }, label: {
                        Spacer()
                        Text("Cadastrar")
                            .font(.custom("Raleway-Bold", size: 18))
                            .foregroundColor(.lightColor)
                        Spacer()
                        
                    }).padding()
                    .clipped()
                    .background(Color.btnColor) // aqui precisou usar o Color.
                    .cornerRadius(10)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.top,30)
                    .padding()

               Spacer()
                    
                    
                
            }
            }
        }
}
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
