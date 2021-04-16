//
//  SignTestView.swift
//  TiGuia
//
//  Created by Victor Vieira on 01/04/21.
//

import SwiftUI
import Firebase

struct SignTestView: View {
    
    @ObservedObject var user = UserViewModel()
    
    
    init(){
        user.fetchData(isSigned: false)
    }
    var body: some View {
        VStack{
            ForEach(user.user){ user in
                Text(user.isSigned ? "Ta logado" : "Não ta logado")
            }
            if (user.user.count > 0){
                if(user.user[0].isSigned){
                    Button(action: {
                        user.sendData(isSigned: false)
                    }){
                        Text("logOut")
                    }
                    
                }
                else{
                    Button(action: {
                        user.sendData(isSigned: true)
                    }){
                        Text("logIn")
                    }
                    
                }
                
            }
            else{
                Button(action: {
                    user.sendData(isSigned: true)
                }){
                    Text("logIn")
                }
                
            }
        }
    }
}
struct SignTestView_Previews: PreviewProvider {
    static var previews: some View {
        SignTestView()
    }
}
