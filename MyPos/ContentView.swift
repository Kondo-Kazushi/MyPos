import SwiftUI

struct ContentView: View {
    @State private var showForm: Bool = true
    @State private var orderItems: [OrderItem] = []
    @State private var newCustomerName = ""
    @State private var selectedCustomerIndex = 0
    @State private var newBentoName = ""
    @State private var selectedBentoIndex = 0
    @State private var recordedDate: String = "None"
    @State private var newQuantity = 1
    @State private var newPrice = 0
    @State private var newTotalPrice = 0
    @State private var newNote = ""
    
    let bentoList: [BentoItem] = [
        BentoItem(name: "ランチ", basePrice: 350),
        BentoItem(name: "お好み", basePrice: 500),
        BentoItem(name: "唐揚げ", basePrice: 400),
        BentoItem(name: "おにぎり", basePrice: 100),
        BentoItem(name: "のり弁", basePrice: 330),
        BentoItem(name: "DXのり弁", basePrice: 380),
        BentoItem(name: "その他", basePrice: 0)
    ]
    
    let customerList: [Customer] = [
        Customer(name: "入力してください"),
        Customer(name: "日大印刷"),
        Customer(name: "三和"),
        Customer(name: "ジェームス"),
        Customer(name: "おにぎりおじさん")
    ]
    
    var selectedBento: BentoItem {
        return bentoList[selectedBentoIndex]
    }
    
    var selectedCustomer: Customer {
        return customerList[selectedCustomerIndex]
    }
    
    var body: some View {
        NavigationView {
            HStack {
                if showForm == true {
                    Form {
                        Section(header: Text("Order")) {
                            Picker("Customer", selection: $selectedCustomerIndex) {
                                ForEach(0..<customerList.count, id: \.self) { index in
                                    Text(customerList[index].name)
                                }
                            }
                            if selectedCustomer.name == "入力してください" {
                                TextField("顧客", text: $newCustomerName)
                            }
                            Picker("弁当", selection: $selectedBentoIndex) {
                                ForEach(0..<bentoList.count, id: \.self) { index in
                                    Text(bentoList[index].name)
                                }
                            }
                            if selectedBento.name == "その他" {
                                TextField("品名", text: $newBentoName)
                                TextField("Price", value: $newPrice, formatter: NumberFormatter())
                            }
                            HStack {
                                Stepper("Quantity", value: $newQuantity)
                                TextField("",value: $newQuantity, formatter: NumberFormatter()).frame(maxWidth: 50).textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            HStack {
                                TextField("Note", text: $newNote)
                                Button {
                                    newNote = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }.buttonStyle(.plain)
                            }
                            Button("Add") {
                                let currentDate = Date()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd" // 任意の日付形式に変更可能
                                recordedDate = dateFormatter.string(from: currentDate)
                                if selectedCustomer.name != "入力してください" {
                                    newCustomerName = selectedCustomer.name
                                } else if newCustomerName == "" {
                                    newCustomerName = "名前なし"
                                }
                                if selectedBento.name != "その他" {
                                    newBentoName = selectedBento.name
                                    newPrice = selectedBento.basePrice
                                }
                                newTotalPrice = newPrice * newQuantity
                                let newItem = OrderItem(date: recordedDate, customer: newCustomerName, name: newBentoName, quantity: newQuantity, price: newPrice, totalPrice: newTotalPrice, note: newNote)
                                saveOrderItem(orderItem: newItem)
                                selectedBentoIndex = 0
                                newCustomerName = ""
                                newBentoName = ""
                                newPrice = 0
                                newQuantity = 1
                                newTotalPrice = 0
                                
                            }
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 15)).padding()
                }
                VStack {
                    HStack {
                        Toggle(isOn: $showForm) {
                            Text(showForm ? Image(systemName: "arrow.left.to.line") : Image(systemName: "arrow.right.to.line"))
                        }.toggleStyle(.button)
                        Text("Order")
                        Spacer()
                    }.padding()
                    Table(orderItems) {
                        TableColumn("Date") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.date)").font(.title2).bold()
                                    }
                                    Table(orderItems.filter {$0.date == order.date}) {
                                        TableColumn("Customer") { order in
                                            Text(order.customer).bold()
                                        }
                                        TableColumn("Name") { order in
                                            Text(order.name).bold()
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                }
                            } label: {
                                Text(order.date)
                            }
                        }
                        TableColumn("Customer") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.customer)").font(.title2).bold()
                                    }
                                    Table(orderItems.filter {$0.customer == order.customer}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Name") { order in
                                            Text(order.name).bold()
                                        }
                                        TableColumn("Price") { order in
                                            Text("\(order.price)")
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                }
                            } label: {
                                Text(order.customer).bold()
                            }
                            
                        }
                        TableColumn("Name") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.name)").font(.title2).bold()
                                        Text("￥\(order.price)").bold()
                                    }
                                    Table(orderItems.filter {$0.name == order.name}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Customer") { order in
                                            Text(order.customer).bold()
                                        }
                                        TableColumn("Quantity") { order in
                                            Text("\(order.quantity)")
                                        }
                                        TableColumn("Total") { order in
                                            Text("\(order.totalPrice)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                        TableColumn("") { order in
                                            Button("Delete") {
                                                // 削除ボタンをタップしたときの処理を追加
                                                deleteOrderItem(order)
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Text(order.name).bold()
                            }
                        }
                        TableColumn("Price") { order in
                            Text("\(order.price)")
                        }
                        TableColumn("Quantity") { order in
                            Text("\(order.quantity)")
                        }
                        TableColumn("Total") { order in
                            Text("\(order.totalPrice)")
                        }
                        TableColumn("Note") { order in
                            Text("\(order.note)")
                        }
                        TableColumn("Edit") { order in
                            Button("Delete") {
                                // 削除ボタンをタップしたときの処理を追加
                                deleteOrderItem(order)
                            }
                        }
                    }
                }
                
            }.onAppear {
                loadOrderItems()
            }
        }.navigationViewStyle(.stack).navigationTitle("Order")
    }
    
    //MARK: Func
    func saveOrderItem(orderItem: OrderItem) {
        do {
            if let data = UserDefaults.standard.data(forKey: "orderItems") {
                var savedOrderItems = try JSONDecoder().decode([OrderItem].self, from: data)
                savedOrderItems.append(orderItem)
                if let newData = try? JSONEncoder().encode(savedOrderItems) {
                    UserDefaults.standard.set(newData, forKey: "orderItems")
                }
            } else {
                let newOrderItems = [orderItem]
                if let newData = try? JSONEncoder().encode(newOrderItems) {
                    UserDefaults.standard.set(newData, forKey: "orderItems")
                }
            }
        } catch {
            print("Error saving order item: \(error)")
        }
        loadOrderItems()
        
    }
    func loadOrderItems() {
        if let data = UserDefaults.standard.data(forKey: "orderItems") {
            if let savedOrderItems = try? JSONDecoder().decode([OrderItem].self, from: data) {
                orderItems = savedOrderItems
            }
        }
    }
    func deleteOrderItem(_ item: OrderItem) {
        if let index = orderItems.firstIndex(where: { $0.id == item.id }) {
            orderItems.remove(at: index)
            if let newData = try? JSONEncoder().encode(orderItems) {
                UserDefaults.standard.set(newData, forKey: "orderItems")
            }
            
        }
    }
}

struct OrderItem: Identifiable, Decodable, Encodable {
    var id = UUID()
    var date: String
    var customer: String
    var name: String
    var quantity: Int
    var price: Int
    var totalPrice: Int
    var note: String
}

struct BentoItem {
    var name: String
    var basePrice: Int
}

struct Customer {
    var name: String
}
