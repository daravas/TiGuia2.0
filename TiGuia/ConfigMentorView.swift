//
//  ConfigMentorView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 24/03/21.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

struct ConfigMentorView: View {
    @ObservedObject var userViewModel = UserViewModel()
    init(){
        userViewModel.fetchData(isSigned: Auth.auth().currentUser!.isEmailVerified)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Configurações")
                    .font(.custom("Raleway-Bold", size: 30))
                    .foregroundColor(.titleColor)
                Spacer()
            } .padding([.leading, .bottom])
            .padding(.top, 40)
            
            VStack{
                if(userViewModel.user.count > 0){
                    if (!userViewModel.user[0].isSigned) {
                        HStack{
                            Image(systemName: "person" )
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20))
                                .foregroundColor(.titleColor)
                            
                            Text("Conta")
                                .font(.custom("Raleway-Bold", size: 20))
                                .foregroundColor(.titleColor)
                            Spacer()
                        }
                        Divider().frame(height: 1).background(Color.titleColor)
                        
                        
                        AccountView(userVM: userViewModel)
                    }
                    
                }
                else{
                    HStack{
                        Image(systemName: "person" )
                            .frame(width: 20, height: 20)
                            .font(.system(size: 20))
                            .foregroundColor(.titleColor)
                        
                        Text("Conta")
                            .font(.custom("Raleway-Bold", size: 20))
                            .foregroundColor(.titleColor)
                        Spacer()
                    }
                    Divider().frame(height: 1).background(Color.titleColor)
                    
                    
                    AccountView(userVM: userViewModel)
                }
                
                HStack{
                    Image(systemName: "slider.horizontal.3" )
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .foregroundColor(.titleColor)
                    Text("Aparência")
                        .font(.custom("Raleway-Bold", size: 20))
                        .foregroundColor(.titleColor)
                    Spacer()
                }
                
                Divider().frame(height: 1).background(Color.titleColor)
                ToggleDarkModeView()
                Spacer()
                
                if(userViewModel.user.count > 0){
                    if (userViewModel.user[0].isSigned) {
                        SignOutView(userVM: userViewModel)
                    }
                }
                
            }
            .padding()
        }
    }
    
    struct ToggleModel {
        
        var isDark: Bool = UserDefaults.standard.bool(forKey: "isDark") ?? false {
            didSet {
                SceneDelegate.shared?.window!.overrideUserInterfaceStyle = isDark ? .dark : .light
                UserDefaults.standard.setValue(isDark, forKey: "isDark")
            }
        }
    }
    
    struct ToggleDarkModeView: View {
        @State var model = ToggleModel()
        
        var body: some View {
            Toggle(isOn: $model.isDark) {
                Text("Modo escuro")
            }
            .accentColor(.btnColor)
            .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            .font(.custom("Raleway-SemiBold", size: 16))
            .foregroundColor(.darkColor)
            .padding([.top, .bottom])
            
        }
    }
    
    struct AccountView: View {
        
        
        @ObservedObject var userVM: UserViewModel
        
        @State var showSignIn = false
        @State var showResquestName = false
        @State var showMentorArea = false
        @State var userName = Auth.auth().currentUser!.displayName ?? ""
        var body: some View {
            
            Button(action: {
                
                showResquestName.toggle()
                
                
            }, label: {
                
                Text("Login")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.btnColor)
                
            })
            .font(.custom("Raleway-SemiBold", size: 16))
            .foregroundColor(.darkColor)
            .padding([.top, .bottom])
            if(showSignIn || showResquestName || showMentorArea){
                EmptyView().fullScreenCover(isPresented: $showSignIn) {
                    SignInMentorView(userVM: userVM, showThisView: $showSignIn, userName: $userName, showMentorArea: $showMentorArea)
                }
                EmptyView().fullScreenCover(isPresented: $showResquestName) {
                    RequestNameView(showThisView: $showResquestName, showSignIn: $showSignIn, userName: $userName)
                }
//                EmptyView().fullScreenCover(isPresented: $showMentorArea) {
//                    MacroAreaMentorUIView()
//                }
            }
            
        }
    }
    
    struct SignOutView: View {
        @ObservedObject var userVM: UserViewModel
        var body: some View {
            
            Button(action: {
                
                do {
                    try Auth.auth().signOut()
                    userVM.sendData(isSigned: false)
                } catch {
                    print("Error Signing Out")
                }
                
            }, label: {
                Text("Sair")
                    .font(.custom("Raleway-SemiBold", size: 18))
                    .frame(width: 90, height: 50)
                    .foregroundColor(.btnColor)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(.btnColor)), lineWidth: 2)
                    .shadow(radius: 10))
                    .padding(.bottom,40)
            })
        }
    }
    
}


struct ConfigMentorView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
