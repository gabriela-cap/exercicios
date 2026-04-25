import SwiftUI

struct Questao {
    var tema: String
    var perguntas: [String]
    var respostas: [([String], Int)]
}

struct QuestaoView: View {
    var questao: Questao
    @State var respostasSelecionadas: [Int?] = [nil, nil, nil , nil, nil]
    @State var concluir: Bool = false
    @Binding var temaSelecionado: String?
    
    var body: some View {
        ScrollView{
        VStack() {
            ForEach(questao.perguntas.indices, id: \.self) {
                indice in Text(questao.perguntas[indice])
                            .font(.title)
                            .bold()
                
                List(questao.respostas[indice].0.indices, id: \.self) { indiceResposta in
                    Button(action: { respostasSelecionadas[indice] = indiceResposta }) {
                        Text(questao.respostas[indice].0[indiceResposta])
                            .font(.body)
                            .foregroundColor(
                                concluir ?
                                    respostasSelecionadas[indice] == indiceResposta ?
                                        (indiceResposta == questao.respostas[indice].1 ? .green : .red)
                                        : .primary
                                    : respostasSelecionadas[indice] == indiceResposta ? .blue : .primary
                            )
                    }
                }
                .padding(.vertical, -30)
                .scrollContentBackground(.hidden)
                .background(Color.white)
                .frame(height: 300)
                
                if concluir && respostasSelecionadas[indice] != questao.respostas[indice].1 {
                    Text("Resposta correta: \(questao.respostas[indice].0[questao.respostas[indice].1])")
                        .foregroundColor(.green)
                        .padding(.bottom, 50)
                        .padding(.top, -50)
                }
            }
            if concluir {
                let corretas = zip(respostasSelecionadas, questao.respostas).filter{$0 == $1.1}.count
                let erradas = zip(respostasSelecionadas, questao.respostas).filter{$0 != nil && $0 != $1.1}.count
                let vazias = respostasSelecionadas.filter{$0 == nil}.count
                Text("Respostas corretas: \(corretas)/\(questao.perguntas.count)")
                Text("Respostas erradas: \(erradas)/\(questao.perguntas.count)")
                Text("Não resolvidas: \(vazias)/\(questao.perguntas.count)")
                
                Button("Escolher novo tema") { temaSelecionado = nil }.padding(.top)
            } else {
                Button("Voltar") { temaSelecionado = nil }
                    .bold()
                Button("Concluir") { concluir = true }
                    .bold()
            }
        }}
    }
}


struct ContentView: View {
    @State var selecionado: String?
    let temas = ["Angular", "Swift", "Python", "Java"]
    let questoes = [
        Questao(tema: "Angular", perguntas: [
            "Qual é a principal função do Angular?",
            "Qual linguagem o Angular utiliza como base?",
            "Qual decorator é usado para definir um componente no Angular?",
            "O que é um módulo (NgModule) no Angular?",
            "Qual diretiva é usada para repetição de elementos em templates Angular?",
        ], respostas: [
            (["Criar bancos de dados relacionais", "Framework para desenvolvimento de aplicações web front-end", "Linguagem de programação back-end", "Sistema operacional web"], 1),
            (["Java", "JavaScript", "TypeScript", "Python"], 2),
            (["@Service", "@NgModule", "@Component", "@Injectable"], 2),
            (["Um agrupador de componentes, diretivas e serviços", "Um arquivo de estilo", "Um tipo de banco de dados", "Um componente do Angular"], 0),
            (["*ngIf", "*ngSwitch", "*ngRepeat", "*ngFor"], 3)
        ]),
        Questao(tema: "Swift", perguntas: [
            "Swift é uma linguagem desenvolvida por qual empresa?",
            "Qual é o principal uso da linguagem Swift?",
            "Como se declara uma constante em Swift?",
            "Qual das opções representa um tipo opcional em Swift?",
            "O que são Optionals em Swift?",
        ], respostas: [
            (["Google", "Microsoft", "Apple", "IBM"], 2),
            (["Desenvolvimento de sistemas embarcados", "Aplicações iOS, macOS, watchOS e tvOS", "Scripts para servidores Linux", "Programação web back-end"], 1),
            (["var", "let", "const", "final"], 1),
            (["Int", "String", "Int?", "Optional(Int)"], 2),
            (["Variáveis globais", "Tipos que nunca podem ser nulos", "Tipos que podem ou não conter um valor", "Funções assíncronas"], 2),
        ]),

        Questao(tema: "Python", perguntas: [
            "Python é classificado como qual tipo de linguagem?",
            "Qual palavra-chave é usada para definir uma função em Python?",
            "Qual estrutura de dados é imutável em Python?",
            "Qual símbolo é usado para comentários em Python?",
            "Qual comando é usado para instalar pacotes em Python?",
        ], respostas: [
            (["Compilada e tipada estaticamente", "Interpretada e tipada dinamicamente", "Compilada apenas para mobile", "Exclusiva para sistemas embarcados"], 1),
            (["func", "function", "def", "lambda"], 2),
            (["Lista", "Dicionário", "Conjunto (set)", "Tupla"], 3),
            (["//", "<!-- -->", "#", "/* */"], 2),
            (["python install", "apt-get install", "pip install","conda run"], 2),
        ]),

        Questao(tema: "Java", perguntas: [
            "Java é conhecido por qual princípio?",
            "Qual é a função da JVM?",
            "Qual palavra-chave é usada para herança em Java?",
            "Qual modificador de acesso permite acesso apenas dentro da mesma classe?",
            "Qual estrutura é usada para tratar exceções em Java?",
        ], respostas: [
            (["Executar apenas em Windows", "Escreva uma vez, execute em qualquer lugar", "Não usa orientação a objetos", "Funciona apenas em servidores"], 1),
            (["Criar interfaces gráficas", "Executar bytecode Java", "Compilar código diretamente para hardware", "Gerenciar banco de dados"], 1),
            (["inherits", "implements", "extends", "super"], 2),
            (["public", "protected", "default", "private"], 3),
            (["if / else", "switch", "try / catch", "for / while"], 2),
        ]),

    ]
    
    var body: some View {
        VStack {
            if selecionado == nil {
                Text("Escolha um tema")
                    .font(.title)
                
                List(temas, id: \.self) {
                    tema in Button(tema) {
                        selecionado = tema
                    }
                    .foregroundColor(.black)
                    .bold()
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            } else {
                let questao = questoes.first(where: { $0.tema == selecionado! })!
                QuestaoView(questao: questao, temaSelecionado: $selecionado)
            }
        }
        .background(Color.white)
        .padding()
    }
}

#Preview {
    ContentView()
}
