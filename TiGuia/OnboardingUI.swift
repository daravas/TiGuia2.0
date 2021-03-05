//
//  OnboardingUI.swift
//  TiGuia
//
//  Created by Evaldo Garcia de Souza Júnior on 19/11/20.
//

import Foundation
import SwiftUI
import UIKit

// apresentar a proxima tela: escolha entre estudante e mentor
// EDIT: atualmente indo direto pra area Estudante
struct NextSMUI: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        return MacroAreaStudentViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

// MARK: - Tela completa de onboarding
struct OnboardingUI: View {
    
    var controllers: [UIHostingController<DataOnboardingPage>]
    @State var currentPage = 0
    @State var presented = false
    
    init(_ titles: [String]) {
        self.controllers = titles.map { UIHostingController(rootView: DataOnboardingPage(title: $0)) }
    }
    
    var body: some View {
        VStack {
            // parte de cima do onboarding que contem o botao pular
            HStack {
                Spacer()
                Button(action: {
                    self.presented.toggle()
                }, label: {
                    Text("Pular")
                        .font(.custom("Raleway", size: 16))
                        .foregroundColor(.btnColor)
                    
                }).padding([.top, .leading, .trailing])
                .opacity(currentPage == 2 ? 0 : 1)
                .fullScreenCover(isPresented: $presented, content: {
                    NextSMUI()
                })
            }.padding([.top, .leading, .trailing])
            
            // pageView e pageControl
            PageViewController(controllers: self.controllers, currentPage: $currentPage)
            PageControl(numberOfPages: controllers.count, currentPage: $currentPage)
            
            // botao de comecar
            VStack{
                Button(action: {
                    self.presented.toggle()
                }, label: {
                    Spacer()
                    Text("Começar")
                        .font(.custom("Raleway-Bold", size: 18))
                        .foregroundColor(.lightColor)
                    Spacer()
                    
                }).padding()
                .clipped()
                .background(Color.btnColor) // aqui precisou usar o Color.
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .fullScreenCover(isPresented: $presented, content: {
                    NextSMUI()
                })
            }.padding()
            .opacity(currentPage == 2 ? 1 : 0)
            Spacer(minLength: 10)
        }//.background(Color.backgroundColor)
    }
}

// MARK: - Conteudo do PageView
struct DataOnboardingPage: View {
    var title: String
    
    // Conteudo do onboarding
//    var titlesOnboarding = ["Explore seu futuro","Trilhe o seu caminho","Peça ajuda"]
//    var descsOnboarding = ["Com TiGuia seu futuro está em suas mãos, ou melhor, no seu celular! \n Nos últimos anos, o mercado de trabalho mudou bastante e nós separamos as principais áreas em crescimento para você explorar.","Dispomos todo o conteúdo que você precisa, mas é você quem decide o que quer aprender! \n A trilha interativa registra sua evolução e te ajuda a decidir para onde deseja seguir.","Para ajudar na sua decisão, nossos mentores estarão à disposição. \n Uma conversa com profissionais e alunos da área pode sempre clarear nossa jornada, não é mesmo?"]
//    var imagesOnboarding = ["screen1","screen2","screen3"]
    var titlesOnboarding = ["Explore seu futuro","Trilhe o seu caminho","Peça ajuda"]
    var descsOnboarding = ["Com TiGuia seu futuro está em suas mãos, ou melhor, no seu celular! \n Nos últimos anos, o mercado de trabalho mudou bastante e nós separamos as principais áreas em crescimento para você explorar.","Dispomos todo o conteúdo que você precisa, mas é você quem decide o que quer aprender! \n A trilha interativa registra sua evolução e te ajuda a decidir para onde deseja seguir.","Para ajudar na sua decisão, nossos mentores estarão à disposição. \n Uma conversa com profissionais e alunos da área pode sempre clarear nossa jornada, não é mesmo?"]
    var imagesOnboarding = ["screen1","screen2","screen3"]
    
    // Construcao visual do conteudo do onboarding
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Image(imagesOnboarding[Int(title)!])
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            Text(titlesOnboarding[Int(title)!])
                .font(.custom("Raleway-Bold", size: 30))
                .foregroundColor(.titleColor)
                .padding()
            //Spacer()
            //.frame(height: 35)
            Text(descsOnboarding[Int(title)!])
                .font(.custom("Raleway", size: 14))
                .foregroundColor(.darkColor)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
                .lineSpacing(2)

        }//.background(Color.backgroundColor)
    }
}

// MARK: - PageViewController e suas funcoes
struct PageViewController: UIViewControllerRepresentable {
    
    var controllers: [UIViewController]
    @Binding var currentPage: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true)
    }
    
    typealias UIViewControllerType = UIPageViewController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        let parent: PageViewController
        
        init(_ parent: PageViewController) {
            self.parent = parent
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
                return nil
                //return self.parent.controllers.last
            }
            return self.parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == self.parent.controllers.count - 1 {
                return nil
                //return self.parent.controllers.first
            }
            return self.parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
}

// MARK: - PageControl e suas funcoes
struct PageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor(Color.btnColor)
        control.pageIndicatorTintColor = UIColor.lightGray
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

struct OnboardingUI_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
