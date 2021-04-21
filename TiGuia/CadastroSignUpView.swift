//
//  CadastroSignUpView.swift
//  TiGuia
//
//  Created by Victor Vieira on 20/04/21.
//

import SwiftUI

struct CadastroSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var userEmail: String = ""
    @State var userName: String = ""
    @State var userPassword: String = ""
    @State var isEditing: Bool = false
    let buttonColor = Color(red: 28/255, green: 118/255, blue: 144/255, opacity: 1.0)

    @EnvironmentObject var session: SessionStore
    @State var error: String = ""
    @Binding var showThisView: Bool
    @Binding var showBackView: Bool
    @State var emailField = "  aluno123@gmail.com"
    @State var nameField = " Nome"
    @State var senhaField = " Senha"
    @ObservedObject var userVM: UserViewModel
    @Binding var showMacroView: Bool
    
    func signUp(){
        session.signUp(email: userEmail, password: userPassword, handler: {(result, error) in
            if let error = error {
                self.error = error.localizedDescription
                print(error.localizedDescription)
            } else{
                userVM.sendData(isSigned: true)
                SignInWithAppleCoordinator().changeName(displayName: userName)
                self.userEmail = ""
                self.userName = ""
                self.userPassword = ""
                showMacroView.toggle()
                showBackView.toggle()
                showThisView.toggle()
            }
            
        })
    }
    
    
    var body: some View {
        VStack(alignment: .center) {
    Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Image(systemName: "chevron.backward")
            .foregroundColor(buttonColor)
            .padding(.trailing, 370.0)
    }
//    Image("logotiguia")
//        .resizable()
//        .frame(width: 96, height: 149)
//        .padding(.top, 80)
    
    Text("Cadastro")
        .font(.custom("Raleway-Bold", size: 30))
        .foregroundColor(.titleColor)
        .padding(.top, 25)
    
    /*Text("Ao entrar você terá acesso aos mentores que \n fazem parte da comunidade do TiGuia! \nUma conversa com profissionais e alunos da área \n pode te ajudar a entender melhor sobre o assunto\n e a tomar decisões.")
        .font(.custom("Raleway", size: 14))
        .foregroundColor(.darkColor)
        .multilineTextAlignment(.center)
        .padding([.top, .leading, .trailing,.bottom])
        .lineSpacing(2)*/
            Text("Nome")
                .font(.custom("Raleway-Regular", size: 18))
                .padding(.horizontal)
                .padding(.top)
            TextField(
                    nameField,
                     text: $userName
                        
                ) { isEditing in
                    self.isEditing = isEditing
                self.nameField = ""
                } onCommit: {
                   // validate(name: username)
                }
                .autocapitalization(.none)
                .disableAutocorrection(true)
            .frame(height: 32)

            .border(Color(UIColor(.titleColor)), width: 2)
            .cornerRadius(10)
            .padding([.leading, .bottom, .trailing])
    Text("Email")
        .font(.custom("Raleway-Regular", size: 18))
        .padding(.horizontal)
        .padding(.top)
        
    TextField(
            emailField,
             text: $userEmail
                
        ) { isEditing in
            self.isEditing = isEditing
        emailField = ""
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
           senhaField,
           text: $userPassword
       ) { 
        //senhaField = ""
          // handleLogin(username: username, password: password)
       }
    .frame(height: 32)

    .border(Color(UIColor(.titleColor)), width: 2)
    .cornerRadius(10)
    .padding()
            
            if(error != ""){
                Text(error)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.red)
//                            .padding()
            }
            
            Button(action: signUp, label: {
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
            .padding(.top,90)
            .padding([.leading, .trailing, .bottom])
            
            
            //Spacer()
        }
    }
}

//struct CadastroSignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        CadastroSignUpView()
//    }
//}
