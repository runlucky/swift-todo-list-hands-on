import SwiftUI

struct CheckmarkStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            Image(systemName: getSystemName(configuration))
                .foregroundStyle(getForegroundColor(configuration))
                .font(.title2)
        }
    }
    
    private func getSystemName(_ configuration: Configuration) -> String {
        configuration.isOn ? "checkmark.circle.fill" : "circle"
    }
    
    private func getForegroundColor(_ configuration: Configuration) -> Color {
        configuration.isOn ? .green : .gray
    }
}

extension ToggleStyle where Self == CheckmarkStyle {
    static var checkmark: CheckmarkStyle { CheckmarkStyle() }
}

#Preview {
    @Previewable @State var isOn = true
    Toggle("", isOn: $isOn)
        .toggleStyle(.checkmark)
}

