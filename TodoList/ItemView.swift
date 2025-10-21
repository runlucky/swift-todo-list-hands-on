import SwiftUI

struct ItemView: View {
    @Binding var item: Item
    
    var body: some View {
        HStack {
            Button(action: {
                item.isCompleted.toggle()
            }) {
                Image(systemName: getSystemName())
                    .foregroundColor(item.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            
            TextField("項目を入力", text: $item.text)
                .textFieldStyle(.roundedBorder)
        }
    }
    
    func getSystemName() -> String {
        item.isCompleted ? "checkmark.circle.fill" : "circle"
    }
}
    
struct Item: Identifiable {
    let id = UUID()
    var text: String
    var isCompleted: Bool
}

#Preview {
    @Previewable @State var previewItem = Item(text: "test", isCompleted: true)
    return ItemView(item: $previewItem)
}
