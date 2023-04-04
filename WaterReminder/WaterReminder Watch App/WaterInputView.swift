import SwiftUI

struct WaterInputView: View {
    @Binding var waterAmount: Double
    @State private var isFocused: Bool = false
    
    var body: some View {
        VStack {
            Text("Добавить воду")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 50)
            
            TextField("0", value: $waterAmount, formatter: NumberFormatter())
                .frame(width: 200, height: 50, alignment: .center)
                .textFieldStyle(PlainTextFieldStyle())
                .focusable(isFocused)
                .onSubmit {
                    isFocused = false
                }
                .onTapGesture {
                    isFocused = true
                }
            
            HStack {
                Spacer()
                
                Button(action: {
                    waterAmount += 100
                }) {
                    Text("+100 мл")
                        .bold()
                }
                .padding(.trailing, 20)
            }
            .padding(.top, 20)
        }
    }
}

struct WaterInputView_Previews: PreviewProvider {
    static var previews: some View {
        WaterInputView(waterAmount: .constant(0))
    }
}

