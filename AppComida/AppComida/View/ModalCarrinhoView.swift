import SwiftUI

struct ModalCarrinhoView: View {
    @Environment(\.dismiss) var fechar
    @ObservedObject var carrinhoViewModel: CarrinhoViewModel
    
    var body: some View {
        HStack {
            Text("Carrinho")
                .font(.largeTitle)
            Spacer()
            Button("x") {
                fechar()
            }
        }.padding()
        
        Spacer()
        
        VStack {
            if carrinhoViewModel.produtos.isEmpty {
                Text("Nenhum produto adicionado")
            }
            List {
                ForEach(carrinhoViewModel.produtos) { produto in
                    HStack {
                        Text(produto.nome)
                        Spacer()
                        Text("R$ \(produto.preco * Double(produto.quantidade), specifier: "%.2f")")
                        Button("-") {
                            carrinhoViewModel.removeUnidadeProduto(produto: produto)
                        }.buttonStyle(.borderless)
                        Text("\(produto.quantidade)")
                        Button("+") {
                            carrinhoViewModel.addProduto(produto: produto)
                        }.buttonStyle(.borderless)
                    }
                }
                .onDelete(perform: carrinhoViewModel.removeProduto)
            }.listStyle(.plain)
        }.padding()
        
        Spacer()
        
        
        Text("Total: R$ \(carrinhoViewModel.total, specifier: "%.2f")")
            .font(.title2)
            .bold()
    }
}
