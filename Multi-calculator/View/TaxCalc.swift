import SwiftUI

struct TaxCalc: View {
    @State var resultScreen = ""
    @State var numStr: String = ""
    @State var resultFlag: Bool = false
    @State var doneFlag: Bool = false

    // ボタン共通の挙動
    private func setBtn() -> Void {
        if (resultFlag) {
            resultScreen = ""
            resultFlag = false
        }
        if (doneFlag) {
            numStr = ""
            doneFlag = false
        }
    }
    // 数値ボタンの挙動
    private func setNumBtn(num: String) -> Void {
        setBtn()
        if (numStr.count < 12) {
            numStr += "\(num)"
        }
    }
    // ボタン見た目
    fileprivate func NumButton(TextContent: String) -> some View {
        return Text("\(TextContent)")
            .fontWeight(.semibold)
            .font(.title)
            .frame(width: 70, height: 60)
            .foregroundColor(Color(.white))
            .background(Color(red:0.0, green: 0.4, blue: 0.4, opacity: 1.0))
            .cornerRadius(5)
    }
    
    var body: some View {
        VStack (alignment: .center){
            
            Spacer()
            HStack{
                Text("8%")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 120, height: 60)
                    .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                    .background(Color(red:0.9, green: 0.83, blue: 0.68, opacity: 1.0))
                    .cornerRadius(5)
                Text("10%")
                    .fontWeight(.semibold)
                    .font(.title)
                    .frame(width: 120, height: 60)
                    .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                    .background(Color(red:0.9, green: 0.83, blue: 0.68, opacity: 1.0))
                    .cornerRadius(5)
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    setNumBtn(num: "7")
                }) {
                    NumButton(TextContent:"7")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "8")
                }) {
                    NumButton(TextContent:"8")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "9")
                }) {
                    NumButton(TextContent:"9")
                }
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    setNumBtn(num: "4")
                }) {
                    NumButton(TextContent:"4")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "5")
                }) {
                    NumButton(TextContent:"5")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "6")
                }) {
                    NumButton(TextContent:"6")
                }
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    setNumBtn(num: "1")
                }) {
                    NumButton(TextContent:"1")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "2")
                }) {
                    NumButton(TextContent:"2")
                }
                Spacer()
                Button(action: {
                    setNumBtn(num: "3")
                }) {
                    NumButton(TextContent:"3")
                }
                Spacer()
            }
            Spacer()
            Button(action: {
                setNumBtn(num: "0")
            }) {
                NumButton(TextContent:"0")
            }
        }
    }
}

struct TaxCalc_Previews: PreviewProvider {
    static var previews: some View {
        TaxCalc()
    }
}
