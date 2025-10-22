import SwiftUI
import SwiftData

struct ItemView: View {
    @Bindable var item: Item
    
    var body: some View {
        HStack {
            Toggle("", isOn: $item.isCompleted)
                .toggleStyle(.checkmark)
            
            TextField("項目を入力", text: $item.text)
                .textFieldStyle(.roundedBorder)
        }
    }
    
}
    
@Model
class Item {
    var text: String
    var isCompleted: Bool
    var order: Int
    
    init(text: String, isCompleted: Bool, order: Int) {
        self.text = text
        self.isCompleted = isCompleted
        self.order = order
    }
}

#Preview {
    @Previewable var previewItem = Item(text: "test", isCompleted: true, order: 0)
    ItemView(item: previewItem)
}
