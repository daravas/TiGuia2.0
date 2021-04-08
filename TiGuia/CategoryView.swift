//
//  CategoryView.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 16/11/20.
//

//import Foundation
import SwiftUI
import Firebase
//titulo, conteúdo, links, cards subcategorias, btn favorito
struct CategoryView: View {
    @State private var favorito: Bool = false
    @State private var presented: Bool = false
    @State var showModal: Bool = false
    @State var completed: Bool = false
    @State var limit: Int = 10
    
    var categoryIndex: Int = 0 //tirar o =0 depois 
    //let category = Data.categories[categoryIndex]
    // VARIAVEL QUE INICIALIZA TODOS OS DADOS - MOVER E APAGAR DEPOIS
    // ta sendo inicalizada na macroarea ate agora
    var socorro = Data()
    @ObservedObject var userVM = UserViewModel()
    init(categoryIndex: Int){
        self.categoryIndex = categoryIndex
        userVM.fetchData(isSigned: Auth.auth().currentUser!.isEmailVerified)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                var category = Data.categories[categoryIndex] //nao sei se é aqui, mas acho que sim pq nos outros lugares nao pegava
                ScrollView {
                    GeometryReader { gmt in
                        Image("computacaoCapa")
                            .resizable()
                            .scaledToFill()
                            .frame(height: geometry.size.height, alignment: .center)
                            //.edgesIgnoringSafeArea(.top)
                            .offset(y: gmt.frame(in: .global).minY > 0 ? -gmt.frame(in: .global).minY : 0)
                        
                    }.frame(height: geometry.size.height / 4 + 30)
                    //                    VStack {
                    //                        Rectangle().fill(Color.gray.opacity(0.5))
                    //                            .frame(height: geometry.size.height / 4 + 30, alignment: .center)
                    //                            .edgesIgnoringSafeArea(.top)
                    //                            //.padding(.bottom, -(geometry.safeAreaInsets.top))
                    //                    }
                    VStack {
                        //
                        //MARK: -Header - titulo + botao de favoritos
                        //
                        HStack {
                         //título
                            Text(category.title)
                                .foregroundColor(.titleColor)
                                .font(.custom("Raleway-Bold", size: 30))
                                .multilineTextAlignment(.leading)
                                //.fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }.padding()
                        //
                        //MARK: -inicio do conteúdo
                        //
                        
                        VStack {
                            ScrollView{
                                //VStack{
                                VStack {
                                    Text(category.content)
                                        .font(.custom("Raleway-Regular", size: 15))
                                        .multilineTextAlignment(.leading)
                                        //.padding()
                                        .foregroundColor(.darkColor)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(limit)
                                        .lineSpacing(3)
                                    
                                    
                                }.padding()
                                //.frame(width: 372, height: 148, alignment: .leading)
                                
                                HStack{
                                    Text("Links úteis")
                                        .multilineTextAlignment(.leading)
                                        .font(.custom("Raleway-Bold", size: 20))
                                        .foregroundColor(.titleColor)
                                    Spacer()
                                }.padding([.top, .leading, .trailing])
                                //
                                //MARK: -"colection" de links
                                //
                                CardLink(category: category)
                                
                                //
                                //MARK: -subcategorias
                                //
                                HStack{
                                    Text("Categorias")
                                        .font(.custom("Raleway-Bold", size: 20))
                                        .foregroundColor(.titleColor)
                                    Spacer()
                                }.padding([.top, .leading, .trailing])
                                
                                
                                VStack {
                                    LazyVStack {
                                        ForEach(0..<category.subcategories.count, id: \.self) { count in
                                            CardsCategory(userVM: userVM, category: category, count: count)
                                        }
                                    }
                                }.padding()
                                
                                
                                
                                //
                                //MARK: -botao de pedir ajuda
                                //
                                VStack {
                                    Button(action: {
                                        // self.presented.toggle()
                                        self.showModal.toggle()
                                    }, label: {
                                        Spacer()
                                        Image(systemName: "ellipses.bubble")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.lightColor)
                                            .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Text("Pedir ajuda")
                                            .font(.custom("Raleway-Bold", size: 18))
                                            .foregroundColor(.lightColor)
                                        Spacer()
                                        
                                    }).padding()
                                    .clipped()
                                    .background(Color.btnColor)
                                    .cornerRadius(10)
                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                    //                            .fullScreenCover(isPresented: $showModal, content: {
                                    //                                HelpUI(showModal: $showModal)
                                    //                            })
                                    //.overlay(HelpUI(showModal: $showModal).opacity(showModal ? 1 : 0).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
                                    
                                }.padding()
                                .edgesIgnoringSafeArea(.bottom)
                                
                                  }
                                .padding(.trailing)
                                Spacer()
                                
                                Spacer(minLength: 20)
                            }
                            
                        }.frame(height: geometry.size.height - ((geometry.size.height / 5)))
                        //.frame(height: geometry.size.height - ((geometry.size.height / 4) + 30))
                        
                    //}//.frame(height: geometry.size.height - ((geometry.size.height / 5)))
                    //.background(Color.backgroundColor)
                    .background(RoundedCorners(tl: 25, tr: 25, bl: 0, br: 0).fill(Color.backgroundColor)) // ta mostrando o fundo de cores diferentes
                    //.cornerRadius(25, corners: [.topLeft, .topRight])
                    //                    .offset(x: 0, y: -35)
                    .clipped()
                    .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 15, x: 0.0, y: -5.0)
                    .offset(y: geometry.frame(in: .global).maxY < 0 ? geometry.frame(in: .global).maxY : 0)
                    
                }.edgesIgnoringSafeArea(.top)
                //.navigationBarTitle("", displayMode: .inline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .overlay(HelpUI(showModal: $showModal, completed: $completed).opacity(showModal ? 1 : 0).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).animation(.easeInOut(duration: 0.3)))
                .overlay(DoubtSentUI(completed: $completed).opacity(completed ? 1 : 0).frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).animation(.easeInOut(duration: 0.3)))
                //.navigationBarBackButtonHidden(true)
                
            }//.frame(height: UIScreen.main.bounds.height)
            
        }.accentColor(.titleColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear(perform: {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UITextView.appearance().backgroundColor = .clear
        })
        
        
    }
}

//codigo pra apresentar a view controller de pedir ajuda
//    struct HelpUI: UIViewControllerRepresentable {
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return //view de pedir ajuda
//        }
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//
//        }
//    }

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView(categoryIndex: 0)
//    }
//}

// MARK: - arrendondar bordas especificas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    //    func path(in rect: CGRect) -> Path {
    //        return Path(roundedRect: rect, cornerSize: CGSize(width: radius, height: radius))
    //    }
}

//struct RoundedCorners: View {
//    var color: Color = .blue
//    var tl: CGFloat = 0.0
//    var tr: CGFloat = 0.0
//    var bl: CGFloat = 0.0
//    var br: CGFloat = 0.0
//
//    var body: some View {
//        GeometryReader { geometry in
//            Path { path in
//
//                let w = geometry.size.width
//                let h = geometry.size.height
//
//                // Make sure we do not exceed the size of the rectangle
//                let tr = min(min(self.tr, h/2), w/2)
//                let tl = min(min(self.tl, h/2), w/2)
//                let bl = min(min(self.bl, h/2), w/2)
//                let br = min(min(self.br, h/2), w/2)
//
//                path.move(to: CGPoint(x: w / 2.0, y: 0))
//                path.addLine(to: CGPoint(x: w - tr, y: 0))
//                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
//                path.addLine(to: CGPoint(x: w, y: h - br))
//                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
//                path.addLine(to: CGPoint(x: bl, y: h))
//                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
//                path.addLine(to: CGPoint(x: 0, y: tl))
//                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
//            }
//            .fill(self.color)
//        }
//    }
//}

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.size.width
        let h = rect.size.height
        
        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        return path
    }
}
