import SwiftUI

struct ContentView: View {
    @State private var showForm: Bool = true
    @State private var orderItems: [OrderItem] = []
    @State private var newCustomerName = ""
    @State private var selectedCustomerIndex = 0
    @State private var newBentoName = ""
    @State private var selectedBentoIndex = 0
    @State private var newSize = "普通"
    @State private var newCustomValue = 0
    @State private var recordedDate: String = "None"
    @State private var recordedDateSmall: String = "None"
    @State private var newQuantity = 1
    @State private var eatin: Bool = false
    @State private var newTaxRate = 8
    @State private var newTax = 0
    @State private var newPrice = 0
    @State private var newTotalPrice = 0
    @State private var newNote = ""
    @State private var tax10: Double = 0.0
    @State private var tax10include = 0
    @State private var tax10notInclude = 0
    @State private var tax8: Double = 0.0
    @State private var tax8include = 0
    @State private var tax8notInclude = 0
    
    let bentoList: [BentoItem] = [
        BentoItem(name: "ランチ", basePrice: 380),
        BentoItem(name: "その他", basePrice: 0),
        BentoItem(name: "特上幕の内弁当(五目弁当)", basePrice: 600),
        BentoItem(name: "DX幕の内弁当", basePrice: 500),
        BentoItem(name: "幕の内弁当", basePrice: 400),
        BentoItem(name: "幕の外弁当", basePrice: 350),
        BentoItem(name: "DXくっく弁当", basePrice: 600),
        BentoItem(name: "くっく弁当", basePrice: 500),
        BentoItem(name: "うなぎ弁当", basePrice: 700),
        BentoItem(name: "DXのり弁当", basePrice: 380),
        BentoItem(name: "のり弁", basePrice: 330),
        BentoItem(name: "DXてりやき弁当", basePrice: 480),
        BentoItem(name: "DXエビ＆ハンバーグ弁当", basePrice: 500),
        BentoItem(name: "エビ＆ハンバーグ弁当", basePrice: 480),
        BentoItem(name: "DXハンバーグ弁当", basePrice: 430),
        BentoItem(name: "ハンバーグ弁当", basePrice: 380),
        BentoItem(name: "SPハンバーグ弁当", basePrice: 580),
        BentoItem(name: "ロコモコハンバーグ", basePrice: 400),
        BentoItem(name: "鮭弁当", basePrice: 330),
        BentoItem(name: "コロッケ弁当", basePrice: 300),
        BentoItem(name: "酢豚弁当", basePrice: 600),
        BentoItem(name: "エビフライ弁当", basePrice: 500),
        BentoItem(name: "カキフライ弁当", basePrice: 400),
        BentoItem(name: "唐揚げ弁当", basePrice: 400),
        BentoItem(name: "とり天弁当", basePrice: 400),
        BentoItem(name: "野菜炒め弁当", basePrice: 400),
        BentoItem(name: "サバ弁当", basePrice: 400),
        BentoItem(name: "カニクリームコロッケ弁当", basePrice: 40),
        BentoItem(name: "ヒレカツ", basePrice: 680),
        BentoItem(name: "お好み弁当", basePrice: 500),
        BentoItem(name: "みそ串カツ弁当", basePrice: 450),
        BentoItem(name: "（味噌）ロースカツ弁当", basePrice: 500),
        BentoItem(name: "（ソース）ロースカツ弁当", basePrice: 500),
        BentoItem(name: "（味噌）プレミアムロースカツ弁当", basePrice: 680),
        BentoItem(name: "（ソース）プレミアムロースカツ弁当", basePrice: 680),
        BentoItem(name: "お子様弁当", basePrice: 350),
        BentoItem(name: "シューマイ弁当", basePrice: 500),
        BentoItem(name: "チキンカツ弁当", basePrice: 500),
        BentoItem(name: "DX焼きうどん弁当", basePrice: 450),
        BentoItem(name: "焼きうどん弁当", basePrice: 380),
        BentoItem(name: "DX焼きそば弁当", basePrice: 450),
        BentoItem(name: "焼きそば弁当", basePrice: 380),
        BentoItem(name: "DX焼肉弁当", basePrice: 500),
        BentoItem(name: "焼肉弁当", basePrice: 400),
        BentoItem(name: "牛肉スタミナ弁当", basePrice: 550),
        BentoItem(name: "豚肉生姜焼き弁当", basePrice: 500),
        BentoItem(name: "牛モツ元気弁当", basePrice: 550),
        BentoItem(name: "チキン南蛮弁当", basePrice: 500),
        BentoItem(name: "カレーうどん", basePrice: 480),
        BentoItem(name: "カレーライス", basePrice: 380),
        BentoItem(name: "カツカレー", basePrice: 600),
        BentoItem(name: "エビカレー", basePrice: 550),
        BentoItem(name: "ハンバーグカレー", basePrice: 550),
        BentoItem(name: "コロッケカレー", basePrice: 400),
        BentoItem(name: "唐揚げカレー", basePrice: 580),
        BentoItem(name: "四川麻婆豆腐丼", basePrice: 450),
        BentoItem(name: "玉子丼", basePrice: 400),
        BentoItem(name: "カツ丼", basePrice: 580),
        BentoItem(name: "天丼", basePrice: 550),
        BentoItem(name: "親子丼", basePrice: 450),
        BentoItem(name: "カルビ丼", basePrice: 500),
        BentoItem(name: "中華丼", basePrice: 550),
        BentoItem(name: "天津丼", basePrice: 500),
        BentoItem(name: "牛丼", basePrice: 480),
        BentoItem(name: "豚メンマ丼", basePrice: 450),
        BentoItem(name: "エビピラフ", basePrice: 400),
        BentoItem(name: "高菜ピラフ", basePrice: 400),
        BentoItem(name: "チキンピラフ", basePrice: 400),
        BentoItem(name: "ドライカレーピラフ", basePrice: 400),
        BentoItem(name: "鮭ご飯", basePrice: 350),
        BentoItem(name: "五目ご飯", basePrice: 380),
        BentoItem(name: "（鮭）おにぎり", basePrice: 100),
        BentoItem(name: "（昆布）おにぎり", basePrice: 100),
        BentoItem(name: "（しぐれ）おにぎり", basePrice: 100),
        BentoItem(name: "（うめ）おにぎり", basePrice: 100),
        BentoItem(name: "（たらこ）おにぎり", basePrice: 100),
        BentoItem(name: "（おかか）おにぎり", basePrice: 100)
    ]
    
    let customList: [Custom] = [
        Custom(name: "普通", value: 0),
        Custom(name: "大盛り", value: 50),
        Custom(name: "小盛り", value: -50),
        Custom(name: "おかず大盛り", value: 100),
        Custom(name: "両大", value: 150)
    ]
    
    let customerList: [Customer] = [
        Customer(name: "入力してください"),
        Customer(name: "店内"),
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
                    VStack {
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
                                if selectedBento.name.contains("おにぎり") {
                                } else {
                                    Picker("カスタム", selection: $newSize) {
                                        ForEach(customList, id: \.name) { custom in
                                            Text(custom.name)
                                        }
                                    }.pickerStyle(.segmented)
                                }
                                if selectedCustomer.name == "店内" {
                                    Text("イートイン　消費税率10％")
                                } else {
                                    Toggle("イートイン", isOn: $eatin)
                                }
                                HStack {
                                    Stepper("Quantity", value: $newQuantity)
                                    TextField("",value: $newQuantity, formatter: NumberFormatter()).frame(maxWidth: 50).textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                HStack {
                                    TextField("Note", text: $newNote)
                                    if newNote != "" {
                                        Button {
                                            newNote = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                        }.buttonStyle(.plain)
                                    }
                                }
                                Button("Add") {
                                    let currentDate = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd"
                                    recordedDate = dateFormatter.string(from: currentDate)
                                    recordedDateSmall = dateFormatter.string(from: currentDate)
                                    if selectedCustomer.name != "入力してください" {
                                        newCustomerName = selectedCustomer.name
                                    } else if newCustomerName == "" {
                                        newCustomerName = "名前なし"
                                    }
                                    
                                    if newCustomerName == "店内" {
                                        self.eatin = true
                                    }
                                    if selectedBento.name != "その他" {
                                        newBentoName = selectedBento.name
                                        newPrice = selectedBento.basePrice
                                    }
                                    if eatin == true {
                                        newTaxRate = 10
                                    } else {
                                        newTaxRate = 8
                                    }
                                    if let selectedCustom = customList.first(where: { $0.name == newSize }) {
                                        newCustomValue = selectedCustom.value
                                        newPrice += newCustomValue
                                    }
                                    newTotalPrice = newPrice * newQuantity
                                    let newItem = OrderItem(date: recordedDate, customer: newCustomerName, name: newBentoName, size: newSize, quantity: newQuantity, price: newPrice, taxRate: newTaxRate, tax: newTax, totalPrice: newTotalPrice, note: newNote)
                                    saveOrderItem(orderItem: newItem)
                                    selectedBentoIndex = 0
                                    newCustomerName = ""
                                    newBentoName = ""
                                    newPrice = 0
                                    newQuantity = 1
                                    newTotalPrice = 0
                                    newSize = "普通"
                                    newCustomValue = 0
                                    eatin = false
                                }.keyboardShortcut(.defaultAction)
                            }
                        }
                        Button("Delete All Userdefaults") {
                            orderItems.removeAll()
                            if let newData = try? JSONEncoder().encode(orderItems) {
                                UserDefaults.standard.set(newData, forKey: "orderItems")
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
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
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
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)")
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
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
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
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)%")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        if tax8include != 0 {
                                            GridRow {
                                                Text("8%")
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            }
                                        }
                                        if tax10include != 0 {
                                            GridRow {
                                                Text("10%")
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
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
                                        TableColumn("カスタム") { order in
                                            Text("\(order.size)")
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
                                        TableColumn("Tax") { order in
                                            Text("\(order.taxRate)")
                                        }
                                        TableColumn("Note") { order in
                                            Text("\(order.note)")
                                        }
                                    }
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        if tax8include != 0 {
                                            GridRow {
                                                Text("8%")
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            }
                                        }
                                        if tax10include != 0 {
                                            GridRow {
                                                Text("10%")
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
                                }
                            } label: {
                                Text(order.name).bold()
                            }
                        }
                        TableColumn("カスタム") { order in
                            Text("\(order.size)")
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
                        TableColumn("Tax") { order in
                            NavigationLink {
                                VStack {
                                    HStack {
                                        Text("\(order.taxRate)%").font(.title2).bold()
                                        if order.taxRate == 8 {Text("配達・テイクアウト")} else { Text("イートイン") }
                                    }
                                    Table(orderItems.filter {$0.taxRate == order.taxRate}) {
                                        TableColumn("Date") { oeder in
                                            Text(order.date)
                                        }
                                        TableColumn("Customer") { order in
                                            Text("\(order.customer)")
                                        }
                                        TableColumn("商品名") { order in
                                            Text("\(order.name)")
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
                                    Grid {
                                        GridRow {
                                            Text("税率")
                                            Text("税抜価格")
                                            Text("税金")
                                            Text("税込価格")
                                        }
                                        GridRow {
                                            Text("\(order.taxRate)")
                                            if order.taxRate == 8 {
                                                Text("\(tax8notInclude)")
                                                Text(String(format: "%.1f", tax8))
                                                Text("\(tax8include)")
                                            } else {
                                                Text("\(tax10notInclude)")
                                                Text(String(format: "%.1f", tax10))
                                                Text("\(tax10include)")
                                            }
                                        }
                                    }.padding().font(.title3)
                                }.onAppear {
                                    tax8include = orderItems.filter { $0.taxRate == 8 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax8 = Double(tax8include) * 1.08 - Double(tax8include)
                                    tax8notInclude = tax8include - Int(tax8)
                                    tax10include = orderItems.filter { $0.taxRate == 10 && $0.customer == order.customer }.reduce(0) { $0 + $1.totalPrice }
                                    tax10 = Double(tax10include) * 1.1 - Double(tax10include)
                                    tax10notInclude = tax10include - Int(tax10)
                                }
                            } label: {
                                Text("\(order.taxRate)%").bold()
                            }
                        }
                        TableColumn("Note") { order in
                            Text("\(order.note)")
                        }
                        TableColumn("Edit") { order in
                            Button("Delete") {
                                deleteOrderItem(order)
                            }
                        }.width(70)
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
    var size: String
    var quantity: Int
    var price: Int
    var taxRate: Int
    var tax: Int
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

struct Custom {
    var name: String
    var value: Int
}
