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
    @Binding var textao: String
    @Binding var showThisView: Bool
    @State var showSignUpForm = false
    @ObservedObject var userVM: UserViewModel
    @Binding var showMacroView: Bool
    
    func signIn() {
        session.signIn(email: userEmail, password: userPassword, handler: {(result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                userVM.sendData(isSigned: true)
                self.userEmail = ""
                self.userPassword = ""
                showMacroView.toggle()
                showThisView.toggle()
            }
        })
    }
    
    var body: some View{
        VStack() {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(buttonColor)
                    .padding(.trailing, 370.0)
            }
            
            HStack {
                
                Image("logotiguia")
                    .resizable()
                    .frame(width: 96, height: 149)
                    .scaleEffect(CGSize(width: 0.7, height: 0.7))
                Spacer()
                
                Text(textao)
                    .font(.custom("Raleway", size: 14))
                    .foregroundColor(.darkColor)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
            } .padding([.leading, .trailing])
            
            Text("Faça login")
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(.titleColor)
                .padding(.top, 25)
            
            VStack(alignment: .leading) {
                
                Text("Email")
                    .font(.custom("Raleway-Regular", size: 14))
                    .padding(.horizontal)
                    .padding(.top)
                
                TextField(
                    " nome@gmail.com",
                    text: $userEmail
                    
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
                    // validate(name: username)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.titleColor, lineWidth: 2))
                .padding([.leading, .bottom, .trailing])
                
                Text("Senha")
                    .font(.custom("Raleway-Regular", size: 14))
                    .padding(.horizontal)
                    .padding(.top)
                    
                
                SecureField(
                    " Senha",
                    text: $userPassword
                ) {
                    // handleLogin(username: username, password: password)
                }
                .frame(height: 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.titleColor, lineWidth: 2))
                .padding([.leading, .bottom, .trailing])
            }
            
            
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
                    .font(.custom("Raleway-Semibold", size: 16))
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
                Text("Não possui uma conta? Cadastre-se")
                    .font(.custom("Raleway-Bold", size: 14))
                Spacer()
                
            }).padding()
            .foregroundColor(.btnColor)
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(.btnColor)), lineWidth: 2)
//                        .shadow(radius: 10))
            //.padding(.top,30)
            .padding([.leading, .trailing])
            
            //Spacer()
        }.fullScreenCover(isPresented: $showSignUpForm, content: {
            CadastroSignUpView(showThisView: $showSignUpForm, showBackView: $showThisView, userVM: userVM, showMacroView: $showMacroView)
        })
        
    }
    
}


//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailSignIn()
//    }
//}
