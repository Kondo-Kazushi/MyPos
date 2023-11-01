import SwiftUI

struct ContentView: View {
    @State private var orderItems: [OrderItem] = []
    @State private var selectedBentoIndex = 0
    @State private var newQuantity = 0
    @State private var newPrice = 0
    @State private var newTotalPrice = 0
    
    let bentoList: [BentoItem] = [
        BentoItem(name: "ランチ", basePrice: 350),
        BentoItem(name: "お好み", basePrice: 500),
        BentoItem(name: "唐揚げ", basePrice: 400)
    ]
    
    var selectedBento: BentoItem {
        return bentoList[selectedBentoIndex]
    }

    
    var body: some View {
        Form {
            Section(header: Text("Order")) {
                Picker("弁当", selection: $selectedBentoIndex) {
                    ForEach(0..<bentoList.count, id: \.self) { index in
                        Text(bentoList[index].name)
                    }
                }
                TextField("Quantity", value: $newQuantity, formatter: NumberFormatter())
                Button("Add") {
                    newPrice = selectedBento.basePrice
                    newTotalPrice = newPrice * newQuantity
                    let newItem = OrderItem(name: selectedBento.name, quantity: newQuantity, price: newPrice, totalPrice: newTotalPrice)
                    orderItems.append(newItem)
                    newQuantity = 0
                    newTotalPrice = 0
                }
            }
        }.padding()
        
        Section(header: Text("Bento Items")) {
            Table(orderItems) {
                TableColumn("Name") { order in
                    Text(order.name)
                }
                TableColumn("Price") { order in
                    Text("\(order.price)")
                }
                TableColumn("Quantity") { order in
                    Text("\(order.quantity)")
                }
                TableColumn("合計金額") { order in
                    Text("\(order.totalPrice)")
                }
            }
            
        }
        .navigationTitle("Order List")
    }
}


struct OrderItem: Identifiable {
    var id = UUID()
    var name: String
    var quantity: Int
    var price: Int
    var totalPrice: Int
}

struct BentoItem {
    var name: String
    var basePrice: Int
}
