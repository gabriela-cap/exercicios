import SwiftUI

struct AbaView: View {
    let categoria: Categoria
    @ObservedObject var carrinhoViewModel: CarrinhoViewModel
    
    var produtos: [Produto] {
        switch categoria {
            case .salgados:
                return [
                    Produto(id: "1", nome: "Coxinha", preco: 6),
                    Produto(id: "12", nome: "Calzone", preco: 12),
                    Produto(id: "13", nome: "Mini Pizza", preco: 20)
                ]
            case .doces:
                return [
                    Produto(id: "14", nome: "Bombom", preco: 3),
                    Produto(id: "15", nome: "Bolo", preco: 15),
                    Produto(id: "16", nome: "Sonho", preco: 7)
                ]
            case .bebidas:
                return [
                    Produto(id: "17", nome: "Água", preco: 3),
                    Produto(id: "18", nome: "Refri", preco: 7),
                    Produto(id: "19", nome: "Cerveja", preco: 12)
                ]
        }
    }
    
    var body: some View {
        List(produtos) { produto in
            let quantidade = carrinhoViewModel.produtos
                .first(where: { $0.id == produto.id })?.quantidade ?? 0

            HStack {
                Text(produto.nome)
                Spacer()
                Text("R$ \(produto.preco, specifier: "%.2f")")
                if quantidade > 0 {
                    Button("-") {
                        carrinhoViewModel.removeUnidadeProduto(produto: produto)
                    }.buttonStyle(.borderless)
                    Text("\(quantidade)")
                }
                Button("+") {
                    carrinhoViewModel.addProduto(produto: produto)
                }.buttonStyle(.borderless)
            }
        }
    }
}
