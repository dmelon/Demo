//
//  DependencyGraph.swift
//  Mini
//
//  Created by 陈东 on 2019/7/16.
//  Copyright © 2019 陈东. All rights reserved.
//

import Foundation

struct Pod: Hashable {
    let name: String
    var dependencies: Set<String> = []
}

class Node: Hashable, CustomStringConvertible {
    let name: String
    /// 向下依赖哪些
    var dependOn: Set<Node> = []
    /// 作为哪些的依赖
    var serveFor: Set<Node> = []
    
    init(_ name: String) {
        self.name = name
    }
    
    static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(self.name)
    }
    
    var description: String {
        return self.name
    }
}

extension Sequence where Self.Element == Pod {
    
    func create(node name: String, ifNotExist dic: inout [String: Node]) -> Node {
        let node = dic[name] ?? Node(name)
        dic[name] = node
        return node
    }
    
    func buildNodes() -> [String: Node] {
        
        var dic: [String: Node] = [:]
        
        for pod in self {
            let node = create(node: pod.name, ifNotExist: &dic)
            for dependency in pod.dependencies {
                let depend = create(node: dependency, ifNotExist: &dic)
                node.dependOn.insert(depend)
                depend.serveFor.insert(node)
            }
        }
        
        return dic
    }
    
    func dependencyGraph(reversed: Bool) -> [Int: [Node]] {
        
        var dic = buildNodes()
        
        var layer = 0
        var result: [Int: [Node]] = [:]
        
        while !dic.isEmpty {
            var nodes: [Node] = []
            for node in dic.values {
                let found = (reversed ? node.serveFor : node.dependOn).firstIndex(where: { dic[$0.name] != nil }) != nil
                if !found {
                    nodes.append(node)
                }
            }
            for node in nodes {
                dic.removeValue(forKey: node.name)
            }
            result[layer] = nodes
            layer += 1
        }
        
        return result
    }
}

func test() {
    
    let pods: [Pod] = [
        Pod(name: "Core", dependencies: []),
        Pod(name: "Base", dependencies: ["Core"]),
        Pod(name: "MRN", dependencies: ["Core"]),
        Pod(name: "Extension", dependencies: ["Base"]),
        Pod(name: "Mach", dependencies: [])
    ]
    
    var graph = pods.dependencyGraph(reversed: false)
        .sorted { (p0, p1) -> Bool in
            return p0.key < p1.key
    }
    print(graph)
    
    graph = pods.dependencyGraph(reversed: true)
        .sorted { (p0, p1) -> Bool in
            return p0.key < p1.key
    }
    print(graph)
}

