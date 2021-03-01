import Foundation
import Combine

class ObservedSwitch : ObservableObject {
    @Published var calcMode: String = "Normal"
    
    init(calcMode: String) {
        self.calcMode = calcMode
    }
}
