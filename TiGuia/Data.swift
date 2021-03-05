//
//  Data.swift
//  TiGuia
//
//  Created by Dara Vasconcelos on 24/11/20.
//

import Foundation
import SwiftUI

class Data{
    static var categories:[Category] = []
    var category:Category = Category()
  //  var subcategories:[Subcategory] = []
    var subcategory:Subcategory = Subcategory()
    var link:Link = Link()
    static var favorite = Favorites()
    
    init() {
        self.category.image = "desktopcomputer"
        self.category.title = "Computação"
        self.category.content = "Ciência da Computação é a ciência que estuda as técnicas, metodologias, instrumentos computacionais e aplicações tecnológicas, que automatizem os processos e desenvolvam soluções de processamento de dados de entrada e saída pautado no computador, de forma que se transforme em informação."
       // Data.categories.append(self.category)
        //link 1
        self.link.titulo = "8 Coisas Para Você Saber Antes de Fazer Ciência da Computação"
        self.link.url = "https://medium.com/@thiago.barbosa/8-coisas-para-voce-saber-antes-de-fazer-ciencia-da-computacao-37fdffbc6156"
        self.link.image = "8 Coisas Para Você Saber Antes de Fazer Ciência da Computação"
        self.category.links.append(link)
        //2
        self.link.titulo = "Ganhando experiência em uma nova área"
        self.link.url = "https://medium.com/@edersantana/ganhando-experiência-em-uma-nova-área-de-trabalho-sem-pedir-permissão-pra-ninguém-a57fdfaae8ae"
        self.link.image = "ganhando experiencia em uma nova area"
        self.category.links.append(link)
        //3
        self.link.titulo = "10 cursos para quem gosta de tecnologia"
        self.link.url = "https://vaidebolsa.com.br/cursos-para-quem-gosta-de-tecnologia/"
        self.link.image = "10 cursos para quem gosta de tecnologia"
        self.category.links.append(link)
        //4
        self.link.titulo = "Áreas de atuação em computação"
        self.link.url = "https://blog.enem.com.br/areas-de-atuacao-em-computacao/"
        self.link.image = "areas de atuacao em computacao"
        self.category.links.append(link)
        
        
        //subcategorias
        //MARK:-Seguranca da informacao
        
        self.subcategory.title = "Segurança da Informação"
        self.subcategory.content = "É a área responsável por montar uma  barreira de segurança para que dados não estejam ao alcance de golpistas e ataques digitais."
        self.subcategory.image = "seguranca da informacao"
        self.subcategory.imageCapa = "segurancaCapa"
        
        //links
        //1
        self.link.titulo = "Por onde começar em Segurança da Informação ? — Breve Introdução"
        self.link.url = "https://medium.com/@soaresligia/por-onde-começar-em-segurança-da-informação-breve-introdução-9ae0b7960d4a"
        self.link.image = "por onde comecar em seguranca da informacao"
        self.subcategory.links.append(link)
        //2
        self.link.titulo = "Segurança da informação. O que faz? Para que serve?"
        self.link.url = "https://www.infonova.com.br/artigo/seguranca-da-informacao-o-que-faz-para-que-serve/"
        self.link.image = "seguranca da informacao o que faz"
        self.subcategory.links.append(link)
        //3
        self.link.titulo = "Como iniciar a carreira de Segurança da Informação?"
        self.link.url = "https://seginfo.com.br/2019/04/12/dicas-de-como-iniciar-na-carreira-de-seguranca-da-informacao/"
        self.link.image = "como iniciar a carreira de seguranca da informacao"
        self.subcategory.links.append(link)
        //4
        self.link.titulo = "Como é trabalhar como Analista de Segurança da Informação"
        self.link.url = "https://medium.com/trainingcenter/como-%C3%A9-trabalhar-como-analista-de-seguran%C3%A7a-da-informa%C3%A7%C3%A3o-por-c%C3%A1ssio-b-pereira-2d0ea62c40"
        self.link.image = "como e trabalhar como analista de seguranca"
        self.subcategory.links.append(link)
        
        //subcategorias
        //1
        var subcategorySI = Subcategory()
        subcategorySI.title = "Análise de vulnerabilidade"
        subcategorySI.content = "A análise de vulnerabilidade trata do processo de identificação de brechas e de falhas presentes no ambiente e que acabam expondo-o a possíveis ameaças. Essa análise precisa identificar e acabar sistematicamente com as vulnerabilidades do sistema.\n\n Nesse processo, são considerados problemas de segurança de aplicativos de terceiros, as configurações de redes, softwares que apresentam potencial para causar futuras falhas em uma infraestrutura, entre outros. Sendo assim, faz o mapeamento de todos os sistemas que possam conter brechas e falhas e delimita esses resultados a partir de relatórios gerenciais e técnicos.\n\nDesse modo, com todos os dados mapeados, é possível atenuar as possíveis vulnerabilidades que foram encontradas."
        subcategorySI.image = "analise de vulnerabilidade 2"
        subcategorySI.imageCapa = "segurancaCapa"
        
        //links
        //1
        self.link.titulo = "Análise de vulnerabilidade: o que é e qual é a sua importância?"
        self.link.url = "https://www.indyxa.com.br/blog/analise-de-vulnerabilidade-o-que-e-e-qual-e-a-sua-importancia/"
        self.link.image = "analise de vulnerabilidade"
        subcategorySI.links.append(link)
        //2
        self.link.titulo = "Análise de Vulnerabilidade: porque ela é tão importante para a segurança da informação"
        self.link.url = "https://www.ibliss.com.br/analise-de-vulnerabilidade-porque-ela-e-tao-importante-para-a-seguranca-da-informacao/"
        self.link.image = "seguranca da informacao"
        subcategorySI.links.append(link)
        //3
        self.link.titulo = "O que é análise de vulnerabilidade?"
        self.link.url = "https://ostec.blog/geral/o-que-e-analise-de-vulnerabilidade/"
        self.link.image = "seguranca da informacao"
        subcategorySI.links.append(link)
      
        self.subcategory.subcategories.append(subcategorySI)
        
        
        //subcategoria 2
        
        subcategorySI = Subcategory()
        subcategorySI.title = "Testes de intrusão"
        subcategorySI.content = "Os testes de invasão, ou PenTests são um conjunto de técnicas e ferramentas utilizadas para identificar falhas de segurança em sistemas e redes corporativas. Através dessas técnicas, o profissional Pentester irá identificar as vulnerabilidades existentes na arquitetura da empresa, explorá-las e entregar um relatório à empresa, que deverá então tomar as devidas ações para corrigir as falhas de segurança.\n\n Um Pentest não é apenas um scaneamento de portas e vulnerabilidades, ele faz uso de softwares e ferramentas (pentest tools) para explorar as vulnerabilidades identificadas, buscando identificar que tipo de informação pode ser obtida através daquela falha."
        subcategorySI.image = "testes de intrusao"
        subcategorySI.imageCapa = "segurancaCapa"

        
        //links
        //1
        self.link.titulo = "APentest – Os Testes de Intrusão"
        self.link.url = "http://profissaohacker.com/pentest/"
        self.link.image = "pentest os testes de intrusao"
        subcategorySI.links.append(link)
        //2
        self.link.titulo = "Teste de intrusão: o que é, a importância e como utilizar"
        self.link.url = "https://blog.ccmtecnologia.com.br/post/teste-de-intrusao-o-que-e-a-importancia-e-como-utilizar"
        self.link.image = "seguranca da informacao"
        subcategorySI.links.append(link)
        //3
        self.link.titulo = "Guia dos testes de invasão"
        self.link.url = "https://www.ibliss.digital/guia-dos-testes-de-invasao-da-ibliss/"
        self.link.image = "guia dos testes de invasao"
        subcategorySI.links.append(link)
      
        self.subcategory.subcategories.append(subcategorySI)
        
        //subcategoria 3
        
        subcategorySI = Subcategory()
        subcategorySI.title = "Auditoria de Segurança"
        subcategorySI.content = "A auditoria é uma avaliação sistemática da segurança do sistema de informações de uma empresa, medindo o quanto ele está em conformidade com um conjunto de critérios estabelecidos. Uma auditoria completa, normalmente, avalia a segurança da configuração da infraestrutura, do ambiente, dos sistemas, de softwares, dos processos de manipulação de informações e de práticas dos usuários.\n\n Essa medida se preocupa em como as políticas de segurança da empresa estão sendo aplicadas."
        subcategorySI.image = "auditoria de seguranca"
        subcategorySI.imageCapa = "segurancaCapa"

        
        //links
        //1
        self.link.titulo = "Política de segurança da informação: o que é e como funciona?"
        self.link.url = "https://www.hscbrasil.com.br/politica-de-seguranca-da-informacao/"
        self.link.image = "politica de seguranca da informacao"
        subcategorySI.links.append(link)
        //2
        self.link.titulo = "Como funciona a auditoria de segurança em TI?"
        self.link.url = "https://blog.ccmtecnologia.com.br/post/como-funciona-auditoria-de-seguranca-em-ti"
        self.link.image = "como funciona a auditoria de seguranca"
        subcategorySI.links.append(link)
        //3
        self.link.titulo = "Auditoria em segurança da informação como maneira de proteger os dados da empresa"
        self.link.url = "http://www.scurra.com.br/blog/auditoria-em-seguranca-da-informacao-como-maneira-de-proteger-os-dados-da-empresa/"
        self.link.image = "auditoria em seguranca da informacao"
        subcategorySI.links.append(link)
      
        self.subcategory.subcategories.append(subcategorySI)
        
        self.category.subcategories.append(subcategory)
        
        //MARK:-engenharia de software
        
        subcategory = Subcategory()
        self.subcategory.title = "Engenharia de Software"
        self.subcategory.content = "A Engenharia de Software capacita as pessoas com a utilização de teorias, técnicas e ferramentas da Ciência da Computação para a produção e desenvolvimento de sistemas de softwares.\n\n Os profissionais da engenharia de softare projetam e guiam o desenvolvimento de programas, aplicativos e sistemas, de forma que atendam aos requisitos e cumpram as funções determinadas.\n\n Entre as principais atribuições do engenheiro de software, estão:\n  - Desenvolver softwares e apps,\n  - Gerenciar projetos ligados aos softwares,\n  - Arquitetar o design estrutural dos programas, e\n  - Realizar testes nos sistemas.\n\n Além destas, estes engenheiros podem ter funções ligadas à administração de bancos de dados, manutenção dos sistemas e até algumas de documentação, relacionadas à gestão de projetos e à composição dos manuais de instruções."
        self.subcategory.image = "engenharia de software"
        self.subcategory.imageCapa = "engdesoftwareCapa"

                
        //links
        //1
        self.link.titulo = "Engenharia de Software"
        self.link.url = "https://guiadoestudante.abril.com.br/profissoes/engenharia-de-software/"
        self.link.image = "engenharia de software 2"
        self.subcategory.links.append(link)
        //2
        self.link.titulo = "Descubra o que faz um engenheiro de software"
        self.link.url = "https://www.guiadacarreira.com.br/carreira/o-que-faz-um-engenheiro-de-software/"
        self.link.image = "descubra o que faz um engenheiro de software"
        self.subcategory.links.append(link)
        //3
        self.link.titulo = "Curso de Engenharia de Software"
        self.link.url = "https://www.mundovestibular.com.br/cursos/curso-de-engenharia-de-software"
        self.link.image = "curso de engenharia de software"
        self.subcategory.links.append(link)
        //4
        self.link.titulo = "O que é, o que faz (e como se tornar) um engenheiro de software"
        self.link.url = "https://www.napratica.org.br/profissao-engenheiro-de-software/"
        self.link.image = "o que e e o que faz um engenheiro de software"
        self.subcategory.links.append(link)
        
        //subcategorias de engenharia de software
        //subcategoria 1
        
        var subcategoryES = Subcategory()
        subcategoryES.title = "Gerenciamento de projetos"
        subcategoryES.content = "Gestão de projetos é o conjunto de conhecimentos, habilidades, técnicas e ferramentas utilizadas para planejar, executar e monitorar um projeto. Está diretamente ligada a execução e controle do projeto, o gerenciamento de mudanças, alterações no escopo etc., portanto, tem o papel de garantir a finalização do projeto dentro dos recursos estimados ou o mais similar do que foi planejado inicialmente.\n\n De forma resumida: Gestão de Projetos nada mais é que o conjunto de conhecimento, técnicas, metodologias e habilidades para garantir o sucesso de um objetivo ou meta.\n\n O gerenciamento serve para que o projeto seja concluído com sucesso. Esse resultado é alcançado quando o projeto é finalizado e atende aos requisitos estabelecidos na etapa de planejamento do projeto. Isso quer dizer que, quando concluído, o resultado deve ser satisfatório em relação ao prazo e aos custos estabelecidos."
        subcategoryES.image = "gerenciamento de projetos"
        subcategoryES.imageCapa = "engdesoftwareCapa"
        
        //links
        //1
        self.link.titulo = "Gestão de Projetos"
        self.link.url = "https://artia.com/blog/gestao-de-projetos-o-que-e-para-que-serve/"
        self.link.image = "gestao de projetos guia completo"
        subcategoryES.links.append(link)
        //2
        self.link.titulo = "Conheça as principais áreas do gerenciamento de projetos"
        self.link.url = "https://www.euax.com.br/2018/07/principais-areas-do-gerenciamento-de-projetos/"
        self.link.image = "conheca as principais areas do gerenciamento de projetos"
        subcategoryES.links.append(link)
        //3
        self.link.titulo = "O que é Gerenciamento de Projetos?"
        self.link.url = "https://escritoriodeprojetos.com.br/o-que-e-gerenciamento-de-projetos"
        self.link.image = "o que e gerenciamento de projetos"
        subcategoryES.links.append(link)
      
        self.subcategory.subcategories.append(subcategoryES)
        
        //subcategoria 2
        
        subcategoryES = Subcategory()
        subcategoryES.title = "Desenvolvimento WEB"
        subcategoryES.content = "O desenvolvimento web pode ser simplesmente definido como o conjunto de processos de criação de aplicativos e websites funcionais para a execução em navegadores web. Trata-se da criação de um software, seja ele um sistema, um app, um portal ou um site, que está conectado a uma rede, podendo ser internet ou intranet (uma rede interna).\n\n Softwares web são desenvolvidos para realizar operações em tempo real. Hoje, a maior parcela do que é desenvolvido é feito para web, permitindo conectividade, integração entre diferentes softwares e ações com resultados instantâneos.\n\n E o papel do desenvolvedor, nesse processo todo, é criar os códigos que definem tanto o que fica visível para as pessoas, quanto o que está escondido nos servidores. A parte visível para os usuários é codificada pelo desenvolvedor front-end, enquanto as regras de negócio, que são a parte lógica da aplicação que fica escondida nos servidores, são codificadas pelo desenvolvedor back-end."
        subcategoryES.image = "desenvolvimento web"
        subcategoryES.imageCapa = "engdesoftwareCapa"

        
        //links
        //1
        self.link.titulo = "Desenvolvimento Web: o que é e como iniciar carreira na área?"
        self.link.url = "https://blog.betrybe.com/carreira/desenvolvimento-web/"
        self.link.image = "desenvolvimento web o que e"
        subcategoryES.links.append(link)
        //2
        self.link.titulo = "Desenvolvimento WEB: o que você precisa saber sobre essa carreira"
        self.link.url = "https://gama.academy/blog/desenvolvimento/desenvolvimento-web-carreira/"
        self.link.image = "como ser um desenvolvedor web"
        subcategoryES.links.append(link)
        //3
        self.link.titulo = "Como ser um Desenvolvedor Web: Por onde começar?"
        self.link.url = "https://www.hostinger.com.br/tutoriais/como-ser-um-desenvolvedor-web/"
        self.link.image = "como ser um desenvolvedor web-1"
        subcategoryES.links.append(link)
        //4
        self.link.titulo = "Cursos e tutoriais gratuitos de Desenvolvimento web"
        self.link.url = "https://www.udemy.com/pt/topic/web-development/free/"
        self.link.image = "udemy"
        subcategoryES.links.append(link)
      
        self.subcategory.subcategories.append(subcategoryES)
        
        // falta subcategorias
        self.category.subcategories.append(subcategory)
        
        //MARK:- ciencia de dados

        subcategory = Subcategory()
        self.subcategory.title = "Ciência de Dados"
        self.subcategory.content = "A ciência de dados é o uso de diversas tecnologias, modelos e metodologias para capturar, armazenar e processar informações, extraindo valor dos dados e gerando valor a um negócio.\n\n Práticas da ciência de dados são aplicadas nos setores de produção, além de vendas, marketing, comunicação, financeiro, jurídico e qualquer área que você possa imaginar.Com tantos dados relevantes à disposição, um gestor tem muito mais subsídios para tomar suas decisões.Ele encontra insumos confiáveis e precisos com grande agilidade, diferente de quando os profissionais precisavam usar sobretudo da intuição ou, então, encomendar pesquisas demoradas, onerosas e nem tão precisas assim.\n\n Esses são alguns exemplos de aplicações práticas da ciência de dados.\n  - Texto: algoritmos podem ler em qualquer idioma e apresentar um resumo traduzido do conteúdo. Útil na área médica, no direito, marketing, jornalismo, segurança pública e outras áreas.\n  - Imagem: a análise automatizada de imagens acelera a detecção de doenças e reduz o tempo no hospital, auxilia na busca de pessoas perdidas e criminosos, facilita a análise do padrão de consumo dos clientes e marcação de ponto nas empresas, etc.\n  - Som: a captura e análise de informações sonoras pode ser usada por robôs de atendimento, no diagnóstico de doenças e para descobrir a opinião dos clientes"
        self.subcategory.image = "ciencia de dados"
        self.subcategory.imageCapa = "cienciadedadosCapa"

        
        //links
        //1
        self.link.titulo = "Como migrar para Ciência de Dados: dicas práticas para iniciar na carreira"
        self.link.url = "https://medium.com/somos-tera/como-migrar-para-ciencia-de-dados-5bef54462419"
        self.link.image = "como migrar"
        self.subcategory.links.append(link)
        //2
        self.link.titulo = "Ciência de Dados"
        self.link.url = "https://www.oracle.com/br/data-science/what-is-data-science.html"
        self.link.image = "ciencia de dados link"
        self.subcategory.links.append(link)
        //3
        self.link.titulo = "Conheça o curso de Ciência de Dados e veja onde estudar"
        self.link.url = "https://www.guiadacarreira.com.br/cursos/curso-ciencia-de-dados/"
        self.link.image = "conheca o curso ciencia de dados"
        self.subcategory.links.append(link)
        
        //falta subcategorias
        self.category.subcategories.append(subcategory)
        
        
        //MARK:-robótica
        
        subcategory = Subcategory()
        self.subcategory.title = "Robótica"
        self.subcategory.content = "A robótica é uma ciência responsável por desenvolver tecnologias presentes em computadores, sistemas, softwares e robôs. Seus circuitos integrados controlam partes mecânicas e automáticas. A robótica é aplicada em indústrias há bastante tempo e isso deve ser cada vez mais frequente, afinal, em ambientes fabris, sobretudo em linhas de produção, as atividades são muito repetitivas.Quando seres humanos desempenham essas tarefas, há grandes chances de desgaste físico, acidentes e falhas.As máquinas, por sua vez, são capazes de executar as operações de maneira rápida e mais eficiente.\n\n Você já ouviu falar em cirurgia robótica? Trata-se de um procedimento cirúrgico feito por robôs.Dessa forma, pode ser conduzido por uma equipe médica a distância.A grande vantagem dessa técnica é que o risco de erro é nulo, uma vez que a máquina é programada para realizar a cirurgia com precisão.\n\n A robótica é aplicada também no contexto de tencologia espacial. As características distintas do ambiente extraterrestre não permitem que seres humanos saiam explorando por aí sem nenhum equipamento.Por essa razão, as máquinas são fundamentais para o estudo de planetas e outras áreas do Universo. Diversos robôs já saíram da superfície terrestre para investigar outros lugares.\n\n Além disso está presente também na automação residencial. Apagar e acender as lâmpadas da sua casa pelo aparelho celular são simples possibilidades da robótica quando o assunto é automação residencial.A tecnologia viabiliza uma série de tarefas, como controlar os equipamentos e sistemas dentro do lar."
        self.subcategory.image = "robotica"
        self.subcategory.imageCapa = "roboticaCapa"

        
        //links
        //1
        self.link.titulo = "Robótica: o STEM em nosso dia a dia"
        self.link.url = "https://medium.com/petrobras/rob%C3%B3tica-o-stem-em-nosso-dia-a-dia-6bd5c88e1383"
        self.link.image = "robotica o stem nosso"
        self.subcategory.links.append(link)
        //2
        self.link.titulo = "O que é Robótica: conceito, história e evolução"
        self.link.url = "https://blog.eletrogate.com/o-que-e-robotica-conceito-historia-e-evolucao/"
        self.link.image = "o que e robotica"
        self.subcategory.links.append(link)
        //3
        self.link.titulo = "O que é robótica? Tendências, importância e áreas de atuação"
        self.link.url = "https://ead.pucgoias.edu.br/blog/o-que-robotica"
        self.link.image = "o que e robotica tendencias"
        self.subcategory.links.append(link)
        self.category.subcategories.append(subcategory)
       
        Data.categories.append(self.category)
    }
    
    func returnCategory() -> Category {
        return self.category
    }
}



