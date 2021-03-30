//
//  HelpUI.swift
//  TiGuia
//
//  Created by Nádia Bordoni on 04/12/20.
//

import Foundation
import SwiftUI
import Firebase


struct HelpUI: View {
    
    @Binding var showModal: Bool
    @State var doubt: String = "Digite sua dúvida aqui."
    @Binding var completed: Bool
    @ObservedObject var chatroomViewModel = ChatroomViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {
                
                GeometryReader { gmt in
                    Rectangle().fill(Color.black.opacity(0.5))
                        .frame(height: gmt.size.height, alignment: .center)
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .center) {
                    
                    Text("Qual a sua dúvida?")
                        .font(.custom("Raleway-Bold", fixedSize: 18.0))
                        .foregroundColor(.darkColor)
                    
                    
                    VStack {
                        TextEditor(text: $doubt)
                            .multilineTextAlignment(.leading)
                            .frame(width: (geometry.size.width - 100), height: geometry.size.height/6)
                            .font(.custom("Raleway-Regular", size: 16.0))
                            .foregroundColor(self.doubt == "Digite sua dúvida aqui." ? .gray : .darkColor)
                            //.opacity(doubt.isEmpty ? 0.25 : 1)
                            .background(Color.bgcardColor)
                            .padding(5)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.btnColor, lineWidth: 2.0)
                            )
                            .onTapGesture {
                                if self.doubt == "Digite sua dúvida aqui." {
                                    self.doubt = ""
                                }
                            }
                        
                    }.padding(.vertical, 10)
                    
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            self.showModal = false
                            self.doubt = "Digite sua dúvida aqui."
                            self.endEditing()
                        }, label: {
                            //Spacer()
                            Text("Cancelar")
                                .font(.custom("Raleway-Bold", size: 18.0))
                                .foregroundColor(.btnColor)
                                .frame(width: (geometry.size.width)/4)
                        }).padding()
                        //.frame(width: (geometry.size.width - 100)/2)
                        .clipped()
                        .background(Color.lightColor)
                        .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.btnColor, lineWidth: 2.0)
                        )
                        
                        
                        
                        Button(action: {
                            print(doubt)
                            chatroomViewModel.createChatroom(studentId: Auth.auth().currentUser!.uid, studentName: "Victor", chatArea: "Robótica",message: doubt, handler: {
                                
                            })
                            self.completed.toggle()
                            self.showModal.toggle()
                            self.endEditing()
                            // funcao para mandar para o mentor
                            self.doubt = "Digite sua dúvida aqui."
                            
                            Analytics.logEvent("sent_doubt",parameters: nil)
                        }, label: {
                            Text("Enviar")
                                .font(.custom("Raleway-Bold", size: 18.0))
                                //.frame(width: 125)
                                .foregroundColor(.lightColor)
                                .frame(width: (geometry.size.width)/4)
                        }).padding()
                        //.frame(width: (geometry.size.width - 100)/2)
                        .clipped()
                        .background(doubt.isEmpty || doubt == "Digite sua dúvida aqui." ? Color.gray
                                        : Color.btnColor)
                        .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .disabled(doubt.isEmpty || doubt == "Digite sua dúvida aqui.")
                        
                    }.padding(.horizontal)
                }.padding(30)
                .clipped()
                .background(Color.bgcardColor)
                .cornerRadius(10)
                .shadow(radius: 10)
                //.overlay(RoundedRectangle(cornerRadius:10)
                // .stroke(Color.clear, lineWidth: 2.0)
                //.shadow(radius: 10)
                //)
                
            }
            
        }.onTapGesture {
            self.endEditing()
        }
       
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//struct HelpUI_Previews: PreviewProvider {
//    static var previews: some View {
//        HelpUI()
//    }
//}
