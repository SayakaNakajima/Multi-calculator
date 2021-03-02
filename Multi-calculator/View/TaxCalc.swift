import SwiftUI

struct TaxCalc: View {
    @State var numStr: String = ""
    @State var doneFlag: Bool = false
    @State var taxStr: String = ""
    @State var taxInStr: String = ""
    
    @State var numDouble: Double? = 0.0
    @State var numResult: Double = 0.0

    // ボタン共通の挙動
    private func setBtn() -> Void {
        if (doneFlag) {
            numStr = ""
            taxStr = ""
            taxInStr = ""
            doneFlag = false
        }
    }
    // 数値ボタンの挙動
    private func setNumBtn(num: String) -> Void {
        setBtn()
        if (numStr == "" && num == "0") {
            numStr = ""
        } else if (numStr.count < 12) {
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
    // 税率ボタン挙動
    // 税率ボタン見た目
    fileprivate func TaxButton(TextContent: String) -> some View {
        return Text("\(TextContent)")
            .fontWeight(.semibold)
            .font(.title)
            .frame(width: 120, height: 60)
            .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
            .background(Color(red:0.9, green: 0.83, blue: 0.68, opacity: 1.0))
            .cornerRadius(5)
    }
    // 税率ボタンの挙動
    private func setTaxBtn(num: Double) -> Void {
        setBtn()
        if (numStr == "") {
            numStr = ""
        } else {
            numDouble = Double(numStr)
            if numDouble != nil {
                numResult = numDouble! * num
                taxInStr = String(Int(round(numResult)))
                taxStr = String(Int(round(numResult - numDouble!)))
            }
            doneFlag = true
            
        }
    }
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Tax")
                        .font(.subheadline)
                        .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                    Text("\(taxStr)")
                        .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                }
                Spacer()
                VStack{
                    Text("original price")
                        .font(.subheadline)
                        .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                        
                    Text("\(numStr)")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                }
            }
            Spacer()
            VStack{
                Text("Tax in")
                    .font(.subheadline)
                    .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                Text("\(taxInStr)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red:0.30, green: 0.21, blue: 0.07, opacity: 1.0))
                
            }
            .padding(10)
            Spacer()
            VStack (alignment: .center, spacing: 10) {
                HStack{
                    Button (action: { setTaxBtn(num: 1.08)
                    }) {
                        TaxButton(TextContent:"8%")
                    }
                    Button (action: { setTaxBtn(num: 1.10)
                    }) {
                        TaxButton(TextContent:"10%")
                    }
                }
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
                Button(action: {
                    setNumBtn(num: "0")
                }) {
                    NumButton(TextContent:"0")
                }
            }
        }

    }
}

struct TaxCalc_Previews: PreviewProvider {
    static var previews: some View {
        TaxCalc()
    }
}
