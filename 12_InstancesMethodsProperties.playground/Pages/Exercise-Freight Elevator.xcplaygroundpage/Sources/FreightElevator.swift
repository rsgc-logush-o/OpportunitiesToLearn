import Foundation


public struct TreehousePulley: CustomStringConvertible {
    public let weightCapacity: Int
    private var currentWeight: Int

    public init(weightCapacity: Int) {
        self.weightCapacity = weightCapacity
        self.currentWeight = 0
    }

    public func canHandleAdditionalLoad(_ load: Int) -> Bool {
        if currentWeight + load > weightCapacity {
            return false
        } else {
            return true
        }
    }

    mutating func addLoadToBasket(loadWeight: Int) {
        currentWeight += loadWeight
    }

    mutating func removeLoad(loadWeight: Int) {
        currentWeight -= loadWeight
    }

    public var description: String {
        return "capacity: \(weightCapacity); current load: \(currentWeight)"
    }
}


