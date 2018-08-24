
extension Collection {
    
    public func groupBy(_ grouper: (Element, Element) -> Bool) -> [[Element]] {
        var result : Array<Array<Element>> = []
        
        var previousItem: Element?
        var group = [Element]()
        
        for item in self {
            // Current item will be the next item
            defer {previousItem = item}
            
            // Check if it's the first item
            guard let previous = previousItem else {
                group.append(item)
                continue
            }
            
            if grouper(previous, item) {
                // Item in the same group
                group.append(item)
            } else {
                // New group
                result.append(group)
                group = [Element]()
                group.append(item)
            }
        }
        
        result.append(group)
        
        return result
    }
    
    public func groupBy<T: Equatable>(_ keyPath: KeyPath<Element, T>) -> [[Element]] {
        return groupBy({ l, r -> Bool in
            return l[keyPath: keyPath] == r[keyPath: keyPath]
        })
    }

}

extension Collection where Element: Comparable {
    
    public func uniquelyGroupBy(_ grouper: (Element, Element) -> Bool) -> [[Element]] {
        return sorted().groupBy(grouper)
    }
    
    public func uniquelyGroupBy<T: Equatable>(_ keyPath: KeyPath<Element, T>) -> [[Element]] {
        return sorted().groupBy(keyPath)
    }
    
}
