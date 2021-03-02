import SwiftUI

struct SwitchCalc: View {
    @State var calcMode: String = "Normal"

    var body: some View {
        VStack{
            HStack{
                Button(action: { calcMode = "Normal" }) {
                    Text("Normal")
                        .fontWeight(.semibold)
                        .font(.title)
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color(.white))
                        .background(Color(red:0.0, green: 0.2, blue: 0.4, opacity: 1.0))
                        .cornerRadius(5)
                }
                Button(action: { calcMode = "Tax" }) {
                    Text("Tax")
                        .fontWeight(.semibold)
                        .font(.title)
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color(.white))
                        .background(Color(red:0.0, green: 0.4, blue: 0.4, opacity: 1.0))
                        .cornerRadius(5)
                }
            }
            if (calcMode == "Normal") {
                NormalCalc()
            } else {
                TaxCalc()
            }
        }
    }
}

struct SwitchCalc_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            SwitchCalc(ObSwitch: ObservedSwitch(calcMode: "Normal"))
            SwitchCalc()
        }
    }
}
