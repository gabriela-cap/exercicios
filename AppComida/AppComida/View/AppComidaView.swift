import SwiftUI

struct AppComidaView: View {
    @State var mostrarCarrinho = false
    @StateObject var carrinhoViewModel = CarrinhoViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                AbaView(categoria: Categoria.salgados, carrinhoViewModel: carrinhoViewModel)
                    .tabItem {
                        Label("Salgados", systemImage: "fork.knife")
                }
                
                AbaView(categoria: Categoria.doces, carrinhoViewModel: carrinhoViewModel)
                    .tabItem {
                        Label("Doces", systemImage: "birthday.cake")
                }
                
                AbaView(categoria: Categoria.bebidas, carrinhoViewModel: carrinhoViewModel)
                    .tabItem {
                        Label("Bebidas", systemImage: "cup.and.saucer")
                }
            }.navigationTitle("App Comida")
                .toolbar{
                    Button {
                        mostrarCarrinho = true
                    } label: { Image(systemName: "cart") }
                }
        }.sheet(isPresented: $mostrarCarrinho) {
            ModalCarrinhoView(carrinhoViewModel: carrinhoViewModel)
        }
    }
}


#Preview {
    AppComidaView()
}
