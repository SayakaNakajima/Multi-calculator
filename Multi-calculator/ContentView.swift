import Foundation
import Combine
import SwiftUI

struct ContentView: View {
//    @ObservedObject var ObSwitch: ObservedSwitch
    var body: some View {
        VStack{
            SwitchCalc()
//            SwitchCalc(ObSwitch: ObSwitch)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
