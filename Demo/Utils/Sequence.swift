//
//  Sequence.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import Foundation

extension Sequence {
    
    func splitBefore(separator isSeparator: (Iterator.Element) throws -> Bool) rethrows -> [AnySequence<Iterator.Element>] {
        var result: [AnySequence<Iterator.Element>] = []
        var subSequence: [Iterator.Element] = []
        
        var iterator = self.makeIterator()
        while let element = iterator.next() {
            if try isSeparator(element) {
                if !subSequence.isEmpty {
                    result.append(AnySequence(subSequence))
                }
                subSequence = [element]
            }
            else {
                subSequence.append(element)
            }
        }
        result.append(AnySequence(subSequence))
        return result
    }
}
