import SwiftUI

struct NormalCalc: View {
    // result
    @State var resultScreen = ""
    @State var numStr: String = ""
    
    // 内部計算用
    @State var formulaArray: [String] = []
    @State var minFormulaArray: [String] = []
    @State var opInd: Int = 0
    @State var backBraInd: Int = 0
    @State var openBraInd: Int = 0
    @State var braRangeDiff: Int = 0
    @State var totalNum: Double = 0.0
    @State var calcNum: Double = 0.0
    // 各種フラグ
    @State var doneFlag: Bool = false
    @State var resultFlag: Bool = false
    // 未入力の back bracket をカウントする
    @State var openBracket: String = ""
    @State var backBracket: String = ""
    @State var unclosedBracketCount: Int = 0
    
    @State var setSigns: String = ""
    @State var stack: String = ""
    
    let stackArray: [String] = ["÷", "×", "+", "-"]
    
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
            .background(Color(red:0.0, green: 0.2, blue: 0.4, opacity: 1.0))
            .cornerRadius(5)
    }
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 5) {

            Spacer()
            
            // 計算経過が表示される
            Text(resultScreen)
                .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                .padding(15)
                .lineLimit(2)
            
            HStack {
                if (doneFlag) {
                    Text(openBracket)
                        .font(.system(size: 48))
                        .foregroundColor(Color.gray)
                } else {
                    Text(openBracket)
                        .font(.system(size: 48))
                }
                
                // 記号を書いた後はグレーになる
                if (resultFlag) {
                    Text(numStr)
                        .font(.system(size: 48))
                        
                } else if (doneFlag) {
                    Text(numStr)
                        .font(.system(size: 48))
                        .foregroundColor(Color.gray)
                        
                } else {
                    Text(numStr)
                        .font(.system(size: 48))
                        
                }
                
                Text(backBracket)
                    .font(.system(size: 48))
                    .foregroundColor(Color.gray)
            }
            .padding(10)
            
            Spacer()
            
            HStack{
                Spacer()

/// (

                Button(action: {
                    if (resultFlag) {
                        resultScreen = ""
                        numStr = ""
                        resultFlag = false
                        doneFlag = false
                    } else if (doneFlag){
                        stack = formulaArray.popLast()!
                        if (stack == ")") {
                            formulaArray.append(stack)
                            formulaArray.append("×")
                        } else if (stackArray.contains(stack)) {
                            formulaArray.append("×")
                        }
                        resultScreen = formulaArray.joined()
                        doneFlag = false
                    } else if (numStr != "") {
                        formulaArray.append(numStr)
                        formulaArray.append("×")
                        resultScreen = formulaArray.joined()
                        numStr = ""
                    }
                    openBracket += "("
                    unclosedBracketCount += 1
                    backBracket += ")"
                }) {
                    NumButton(TextContent:"(")
                }
                Spacer()

/// )

                Button(action: {
                    if (resultFlag) {
                        return
                    } else if (unclosedBracketCount > 0) {
                        
                        if (openBracket.count == unclosedBracketCount) {
                            formulaArray.append("(")
                            openBracket = String(openBracket.prefix(openBracket.count - 1))
                            numStr += "("
                        }
                        // done -> 何かしらやった後
                        if (doneFlag || numStr == "") {
                            stack = formulaArray.popLast()!
                            // ["÷", "×", "+", "-"] のどれか
                            if (stackArray.contains(stack)) {
                                formulaArray.append(")")
                                formulaArray.append(stack)
                            } else {
                                formulaArray.append(stack)
                                formulaArray.append(")")
                            }
                        } else {
                            // openBracket
                            if (numStr.suffix(1) == ".") {
                                numStr += "0"
                            }
                            formulaArray.append(numStr)
                            formulaArray.append(")")
                        }
                        
                        // 1つ削除
                        unclosedBracketCount -= 1
                        backBracket = String(backBracket.prefix(backBracket.count - 1))
                        resultScreen = formulaArray.joined()
                        numStr = numStr + ")"
                        stack = ""
                        doneFlag = true
                    }
                    // unclosed == 0 の時　-> 動作しない
                    else {
                        return
                    }
                }) {
                    NumButton(TextContent:")")
                }
                Spacer()
                
                // % has done
                Button(action: {
                    //setNumBtn()
                    if (numStr == "") {
                        return
                    } else {
                        calcNum = Double(numStr)!
                        calcNum /= 100
                        numStr = String(calcNum)
                    }
                }) {
                    NumButton(TextContent:"%")
                }
                Spacer()
                
                // ÷ has not done yet
                Button(action: {
                    if (doneFlag && numStr == "") {
                        return
                    } else if (doneFlag) {
                        stack = formulaArray.popLast()!
                        if (stack == ")") {
                            formulaArray.append(stack)
                            formulaArray.append("÷")
                        } else if (stackArray.contains(stack)) {
                            formulaArray.append("÷")
                        }
                        resultScreen = formulaArray.joined()
                        stack = ""
                        doneFlag = true
                    } else if (numStr == "") {
                        return
                    } else if (numStr.suffix(1) == ")") {
                        formulaArray.append("÷")
                    } else if (openBracket.count > 0) {
                        formulaArray.append("(")
                        openBracket = String(openBracket.prefix(openBracket.count - 1))
                        formulaArray.append(numStr)
                        formulaArray.append("÷")
                    } else {
                        formulaArray.append(numStr)
                        formulaArray.append("÷")
                    }
                    resultScreen = formulaArray.joined()
                    doneFlag = true
                }) {
                    NumButton(TextContent:"÷")
                }
                Spacer()
            }
            .padding(5)
            
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
                
                // × has not done yet
                Button(action: {
                    if (doneFlag && numStr == "") {
                        return
                    } else if (doneFlag) {
                        stack = formulaArray.popLast()!
                        if (stack == ")") {
                            formulaArray.append(stack)
                            formulaArray.append("×")
                        } else if (stackArray.contains(stack)) {
                            formulaArray.append("×")
                        }
                        resultScreen = formulaArray.joined()
                        stack = ""
                        doneFlag = true
                    } else if (numStr == "") {
                        return
                    } else if (numStr.suffix(1) == ")") {
                        formulaArray.append("×")
                    } else if (openBracket.count > 0) {
                        formulaArray.append("(")
                        openBracket = String(openBracket.prefix(openBracket.count - 1))
                        formulaArray.append(numStr)
                        formulaArray.append("×")
                    } else {
                        formulaArray.append(numStr)
                        formulaArray.append("×")
                    }
                    resultScreen = formulaArray.joined()
                    doneFlag = true
                }) {
                    NumButton(TextContent:"×")
                }
                Spacer()
            }
            .padding(5)
            
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
                
                // - has done
                Button(action: {
                    resultFlag = false
                    if (numStr == "") {
                        numStr = "-"
                    } else if (numStr == "-") {
                        return
                    } else {
                        formulaArray.append(numStr)
                        formulaArray.append("-")
                        doneFlag = true
                        resultScreen = formulaArray.joined()
                    }
                }) {
                    NumButton(TextContent:"-")
                }
                Spacer()
            }
            .padding(5)
            
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
                
                // + has done
                Button(action: {
                    if (resultFlag == true) {
                        formulaArray.append(numStr)
                        formulaArray.append("+")
                        doneFlag = true
                        resultScreen = formulaArray.joined()
                        resultFlag = false
                    }
                    if (numStr == "" || doneFlag) {
                        return
                    } else if (numStr == "-") {
                        numStr = ""
                    } else {
                        formulaArray.append(numStr)
                        formulaArray.append("+")
                        doneFlag = true
                        resultScreen = formulaArray.joined()
                    }
                }) {
                    NumButton(TextContent:"+")
                }
                Spacer()
            }
            .padding(5)
            
            HStack{
                Spacer()
                Button(action: {
                    setBtn()
                    if (numStr == "0") {
                        return
                    } else {
                        numStr += "0"
                    }
                }) {
                    NumButton(TextContent:"0")
                }
                Spacer()
                
                // . has done
                Button(action: {
                    if (numStr == "" || numStr == "-") {
                        return
                    } else if let _ = numStr.range(of: ".") {
                        return
                    } else {
                        resultFlag = false
                        doneFlag = false
                        numStr += "."
                    }
                }) {
                    NumButton(TextContent:".")
                }
                Spacer()
                
                // C hac done
                Button(action: {
                    if (resultFlag) {
                        formulaArray = []
                        resultScreen = ""
                        resultFlag = false
                        numStr = ""
                    } else if (doneFlag) {
                        if (numStr.count > 0) {
                            numStr = String(numStr.prefix(numStr.count - 1))
                        } else if (formulaArray.count > 0) {
                            formulaArray.removeLast()
                            resultScreen = formulaArray.joined()
                        }
                        doneFlag = false
                    } else if (numStr.count > 0) {
                        numStr = String(numStr.prefix(numStr.count - 1))
                    } else if (formulaArray.count > 0) {
                        formulaArray.removeLast()
                        resultScreen = formulaArray.joined()
                    }
                }) {
                    if (resultFlag) {
                        NumButton(TextContent:"AC")
                    } else {
                        NumButton(TextContent:"C")
                    }
                }
                Spacer()
                
                Button(action: {
                    if (resultFlag) {
                        return
                    } else if (doneFlag) {
                        stack = formulaArray.popLast()!
                        if (stack == ")") {
                            formulaArray.append(stack)
                            formulaArray.append("=")
                        } else if (stackArray.contains(stack)) {
                            formulaArray.append("=")
                        }
                        numStr = ""
                        stack = ""
                    } else if (numStr != "") {
                        formulaArray.append(numStr)
                        formulaArray.append("=")
                    }
                    
                    // 最後()で括る -> 必ず()が入ってくる式にする
                    // 計算式を出力する処理
                    // 未入力分を補完してから出力する
                    if unclosedBracketCount > 0 {
                        if openBracket.count > 0 {
                            for _ in 0..<openBracket.count {
                                formulaArray.insert("(", at: 0)
                            }
                            openBracket = ""
                        }
                        formulaArray.removeLast()
                        for _ in 0..<unclosedBracketCount {
                            formulaArray.append(")")
                        }
                        formulaArray.append("=")
                        backBracket = ""
                        unclosedBracketCount = 0
                    }
                    resultScreen = formulaArray.joined()
                    // 補完後に更に確実に()で囲う
                    formulaArray.removeLast()
                    formulaArray.append(")")
                    formulaArray.insert("(", at: 0)
                    
                    print("formulaArray \(formulaArray)")
                    
                    while (formulaArray.contains(")")) {
                        // ()のインデックスを取得する
                        // まずは一番最初の)から
                        if let checkBackBraInd = formulaArray.firstIndex(of: ")") {
                            backBraInd = checkBackBraInd
                            print("backBraInd \(backBraInd)")
                        }
                        // 次に一番最後の(を取得
                        if let checkOpenBraInd = formulaArray.lastIndex(of: "(") {
                            openBraInd = checkOpenBraInd
                        }
                        
                        // ()のインデックスの差を求める
                        braRangeDiff = backBraInd - openBraInd
                        
                        // 差の数に合わせた方が便利なので修正
                        braRangeDiff += 1
                        
                        // もし差が1の時（現在は2） -> 隣同士なので、特に何も実行しない
                        if (braRangeDiff > 2) {
                            // 最小構成の計算式用配列生成
                            for i in 0..<braRangeDiff {
                                minFormulaArray.append(formulaArray[i + openBraInd])
                            }
                            
                            // minFormulaArrayを計算
                            // ()内最奥部の最小構成から計算
                            while (minFormulaArray.contains("×") || minFormulaArray.contains("÷")) {
                                // × && ÷
                                if (minFormulaArray.contains("×") && minFormulaArray.contains("÷")) {
                                    // まず ×インデックスを取る
                                    if let checkMulIndex = minFormulaArray.firstIndex(of: "×") {
                                        // 次に ÷インデックスを取る
                                        if let checkDivIndex = minFormulaArray.firstIndex(of: "÷") {
                                            // ÷の方が先の場合
                                            if (checkDivIndex < checkMulIndex) {
                                                opInd = checkDivIndex - 1
                                                calcNum = Double(minFormulaArray[opInd])! / Double(minFormulaArray[opInd + 2])!
                                            }
                                            // ×が先の場合
                                            else {
                                                opInd = checkMulIndex - 1
                                                calcNum = Double(minFormulaArray[opInd])! * Double(minFormulaArray[opInd + 2])!
                                            }
                                        }
                                    }
                                } else if (minFormulaArray.contains("×")) {
                                    if let checkMulIndex = minFormulaArray.firstIndex(of: "×") {
                                        opInd = checkMulIndex - 1
                                        calcNum = Double(minFormulaArray[opInd])! * Double(minFormulaArray[opInd + 2])!
                                    }
                                } else {
                                    if let checkDivIndex = minFormulaArray.firstIndex(of: "÷") {
                                        opInd = checkDivIndex - 1
                                        calcNum = Double(minFormulaArray[opInd])! / Double(minFormulaArray[opInd + 2])!
                                    }
                                }
                                
                                for _ in 0..<3 {
                                    minFormulaArray.remove(at: opInd)
                                }
                                minFormulaArray.insert(String(calcNum), at: opInd)
                                opInd = 0
                                calcNum = 0
                            }
                            
                            // totalNum 初期化
                            totalNum = 0
                            
                            // 配列の中から数字と記号を取り出す
                            
                            for i in 0..<minFormulaArray.count {
                                // nilチェック -> ここに入ってくるものはDouble型
                                if let _ = Double(minFormulaArray[i]) {
                                    calcNum = Double(minFormulaArray[i])!
                                    switch setSigns {
                                    case "+":
                                        totalNum += calcNum
                                    case "-":
                                        totalNum -= calcNum
                                    default:
                                        totalNum += calcNum
                                    }
                                } else {
                                    setSigns = minFormulaArray[i]
                                }
                            }
                            
                            // 最小構成の中の計算は終わっているはず
                            minFormulaArray = []
                            // formulaArrayにtotalNumをinsertする
                            formulaArray.insert(String(totalNum), at: backBraInd + 1)
                        }
                        // ()を削除する
                        for _ in 0..<braRangeDiff {
                            formulaArray.remove(at: openBraInd)
                        }
                        print(formulaArray)
                        
                    }
                    
                    // 表示
                    stack = String(Int(totalNum))
                    if (totalNum == Double(stack)!) {
                        numStr = stack
                    } else {
                        numStr = String(totalNum)
                    }
                    // 初期化
                    stack = ""
                    totalNum = 0
                    formulaArray = []
                    doneFlag = true
                    resultFlag = true
                }) {
                    NumButton(TextContent:"=")
                }
                
                Spacer()
            }
            .padding(5)
        }
    }
}

struct NormalCalc_Previews: PreviewProvider {
    static var previews: some View {
        NormalCalc()
    }
}
