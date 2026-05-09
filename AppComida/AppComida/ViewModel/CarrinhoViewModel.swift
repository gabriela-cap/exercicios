import Foundation
internal import Combine
import SwiftUI

class CarrinhoViewModel: ObservableObject {
    @Published var produtos: [Produto] = []
    var total: Double {
        produtos.reduce(0) { resultado, produto in
            resultado + (produto.preco * Double(produto.quantidade))
        }
    }

    
    func addProduto(produto: Produto) {
        if let index = produtos.firstIndex(where: {$0.id == produto.id}) {
            var novo = produtos[index]
            novo.quantidade += 1
            produtos[index] = novo
        } else {
            let novoProduto = Produto(id: produto.id,
                                      nome: produto.nome,
                                      preco: produto.preco,
                                      quantidade: 1)
            produtos.append(novoProduto)
        }
    }
    
    func removeUnidadeProduto(produto: Produto) {
        guard let index = produtos.firstIndex(where: {$0.id == produto.id}) else { return }
        if produtos[index].quantidade == 1 {
            produtos.remove(at: index)
        } else {
            produtos[index].quantidade -= 1
        }
    }
    
    func removeProduto(at offsets: IndexSet) {
        produtos.remove(atOffsets: offsets)
    }
}
