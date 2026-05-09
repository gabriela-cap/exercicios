struct Produto: Identifiable, Equatable {
    let id: String
    let nome: String
    let preco: Double
    var quantidade: Int = 0
}
