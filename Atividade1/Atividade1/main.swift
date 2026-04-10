struct Contato {
    var nome: String
    var idade: Int
    var telefone: String
    var email: String
}

extension String {
    var nilIfEmpty: String? { isEmpty ? nil : self }
}

var lista: Array<Contato> = []
var continuar = true

while continuar {
    print("Escolha uma opção")
    print(" 1: Listar Contatos")
    print(" 2: Cadastrar Contato")
    print(" 3: Alterar Contato")
    print(" 4: Exluir Contato")
    print(" 5: Sair")
    print()
    let opcao = readLine()
    print()
    
    switch opcao {
        case "1":
            listar()
        case "2":
            cadastrar()
        case "3":
            alterar()
        case "4":
            remover()
        case "5":
            continuar = false
        default:
            print("Opção inválida")
            print()
    }
}

private func obterDados(_ contato: Contato?) -> Contato? {
    print("Nome:")
    let nome = readLine()!.nilIfEmpty ?? contato?.nome
    print("Idade:")
    let idade = readLine()!.nilIfEmpty ?? (contato != nil ? String(contato?.idade ?? 0) : nil)
    print("Telefone:")
    let telefone = readLine()!.nilIfEmpty ?? contato?.telefone
    print("Email:")
    let email = readLine()!.nilIfEmpty ?? contato?.email
    
    if nome == nil || idade == nil || Int(idade!) == nil || telefone == nil || email == nil {
        print()
        print("Dados inválidos. Informe todos os campos")
        print()
        return nil
    }
    return Contato(nome: nome!, idade: Int(idade!)!, telefone: telefone!, email: email!)
}

private func escolherContato() -> Int? {
    if lista.isEmpty {
        print("Sem contatos cadastrados")
        print()
        return nil
    }
    
    print("Escolha um contato por nome ou número")
    for (i, contato) in lista.enumerated() {
        print(" \(i): \(contato.nome)")
    }
    
    guard let indexOuNome = readLine() else {
        print()
        print("Opção inválida")
        print()
        return nil
    }
    
    return obterIndex(indexOuNome)
}

private func obterIndex(_ indexOuNome: String) -> Int? {
    var index = Int(indexOuNome) ?? nil
    if (index != nil) {
        if index! > lista.count {
            print()
            print("Número inválido")
            print()
            return nil
        }
    } else {
        index = lista.firstIndex(where: { $0.nome == indexOuNome })
        if index == nil {
            print()
            print("Contato não encontrado")
            print()
            return nil
        }
    }
    return index!
}

func listar() {
    if lista.isEmpty {
        print("Sem contatos cadastrados")
        print()
        return
    }
    for contato in lista {
        print("\(contato.nome) -> Idade: \(contato.idade) anos, Telefone: \(contato.idade), Email: \(contato.email)")
        print()
    }
}

func cadastrar() {
    guard let contato = obterDados(nil) else { return }
    let existente = lista.first(where: { $0.nome == contato.nome })
    if existente == nil {
        lista.append(contato)
        print()
        print("Contato cadastrado")
        print()
        return
    }
    print()
    print("Contato com este nome já existe")
    print()
}

func alterar() {
    guard let index = escolherContato() else { return }
    guard let contato = obterDados(lista[index]) else { return }
    
    lista[index] = contato
    print()
    print("Contato atualizado")
    print()
}

func remover() {
    guard let index = escolherContato() else { return }
    
    lista.remove(at: index)
    print()
    print("Contato removido")
    print()
}
