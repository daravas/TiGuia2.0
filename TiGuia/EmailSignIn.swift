//
//  EmailSignIn.swift
//  TiGuia
//
//  Created by Victor Vieira on 20/04/21.
//

import Foundation
import SwiftUI


struct EmailSignIn: View {
    @Environment(\.presentationMode) var presentationMode
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    @State var isEditing: Bool = false
    @State var error: String = ""
    let buttonColor = Color(red: 28/255, green: 118/255, blue: 144/255, opacity: 1.0)
    @EnvironmentObject var session: SessionStore
    @State var textao: String = ""
    @Binding var showThisView: Bool
    @State var showSignUpForm = false
    
    func signIn() {
        session.signIn(email: userEmail, password: userPassword, handler: {(result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.userEmail = ""
                self.userPassword = ""
                showThisView.toggle()
            }
        })
    }
    
    var body: some View{
                VStack(alignment: .center) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(buttonColor)
                    .padding(.trailing, 370.0)
            }
            Image("logotiguia")
                .resizable()
                .frame(width: 96, height: 149)
                .padding(.top, 80)
            
            Text("Faça login")
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(.titleColor)
                .padding(.top, 25)
            
            /*Text("Ao entrar você terá acesso aos mentores que \n fazem parte da comunidade do TiGuia! \nUma conversa com profissionais e alunos da área \n pode te ajudar a entender melhor sobre o assunto\n e a tomar decisões.")
                .font(.custom("Raleway", size: 14))
                .foregroundColor(.darkColor)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing,.bottom])
                .lineSpacing(2)*/
            Text("Email")
                .font(.custom("Raleway-Regular", size: 18))
                .padding(.horizontal)
                .padding(.top)
                
            TextField(
                    "  aluno123@gmail.com",
                     text: $userEmail
                        
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
                   text: $userPassword
               ) {
                  // handleLogin(username: username, password: password)
               }
            .frame(height: 32)

            .border(Color(UIColor(.titleColor)), width: 2)
            .cornerRadius(10)
            .padding()
            
//                    HStack{
//                        Spacer()
//                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                            Text("Esqueceu sua senha?")
//                                .fontWeight(.regular)
//                                .foregroundColor(.black)
//                                .underline()
//
//                        }).padding(.horizontal)
//
//                    }
                    if(error != ""){
                        Text(error)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.red)
//                            .padding()
                    }

                    Button(action: signIn, label: {
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
                        showSignUpForm.toggle()
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
                    //.padding(.top,30)
                    .padding([.leading, .trailing])

            //Spacer()
                }.fullScreenCover(isPresented: $showSignUpForm, content: {
                    CadastroSignUpView(showThisView: $showSignUpForm, showBackView: $showThisView)
                })
        
    }
    
}


//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailSignIn()
//    }
//}
