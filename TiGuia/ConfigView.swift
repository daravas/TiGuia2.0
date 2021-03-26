//
//  ConfigView.swift
//  TiGuia
//
//  Created by Meyrillan Silva on 04/03/21.
//

import UIKit
import SwiftUI
import Firebase

struct ConfigView: View {
    
    @State var condition = Auth.auth().currentUser?.isEmailVerified
    
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
                
                if (condition == false) {
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
                    
                    
                    AccountView()
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
                
                if (condition == true) {
                    SignOutView()
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
        
        @State private var showSignInForm = false
        
        var body: some View {
            
            Button(action: {
                
                showSignInForm.toggle()
                
                
            }, label: {
                
                Text("Login")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.btnColor)
                
            })
            .font(.custom("Raleway-SemiBold", size: 16))
            .foregroundColor(.darkColor)
            .padding([.top, .bottom])
            .fullScreenCover(isPresented: $showSignInForm) {
                SignInView()
            }
            
        }
    }
    
    struct SignOutView: View {
        
        var body: some View {
            
            Button(action: {
                
                do {
                    try Auth.auth().signOut()
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


struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
