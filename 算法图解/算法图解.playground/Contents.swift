import UIKit

var str = "Hello, playground"

/// 4.1 数组求和，分治法，递归求和
func sum(_ array: [Int]) -> Int {
    switch array.isEmpty {
    case true:
        return 0
    case false:
        let first = array.first
        let tailArray = Array(array.dropFirst())
        return first! + sum(tailArray)
    }
}

/// 4.2 求列表个数
func count(_ array: [Int]) -> Int {
    switch array.isEmpty {
    case true:
        return 0
    case false:
        let tailArray = Array(array.dropFirst())
        return 1 + count(tailArray)
    }
}

/// 4.3 求数组最大值
func max(_ array: [Int]) -> Int {
    assert(array.count >= 2, "数组必须包含两个或两个以上元素")
    switch array.count == 2 {
    case true:
        return max(array.first!, array.last!)
    case false:
        let first = array.first
        let tailArray = Array(array.dropFirst())
        return max(first!, max(tailArray))
    }
}

let sum1 = sum([1,2,4,6])
let sum2 = sum([5,1,5,9,11])

let max1 = max([1, 3, 2, 4, 9, 7])
let max2 = max([1, 13, 2, 9, 9, 7, 13])

let count1 = count([1, 3, 2, 4, 9, 7])

/// 4.4 二分查找算法的
/// 基线条件：数组中的一个值与要查找的值相同；
/// 递归条件：每次分隔的中间值与要查找的值不同


/// 快速排序, 最糟O(n²), 平均O(n·㏒n)
func quickSort(_ array: [Int]) -> [Int] {
    guard !array.isEmpty else {
        return []
    }
    switch array.count == 1 {
    case true:
        return array
    case false:
        let pivot = array.first!
        var leftArray: [Int] = []
        var rightArray: [Int] = []
        array.dropFirst().forEach { (element) in
            switch element <= pivot {
            case true:
                leftArray.append(element)
            case false:
                rightArray.append(element)
            }
        }
        return quickSort(leftArray) + [pivot] + quickSort(rightArray)
        
    }
}

let resultArray = quickSort([3, 7, 1, 5, 13, 99, 23, 2, 14])

/// 4.5 打印数组中每个元素的值 O(n)
/// 4.6 将数组中每个元素的值都乘以2 O(n)
/// 4.7 只将数组中第一个元素的值乘以2 O(1)
/// 4.8 根据数组包含的元素创建一个乘法表，即如果数组为[2, 3, 7, 8, 10]，首先将每个元素都乘以2，再将每个元素都乘以3，然后将每个元素都乘以7，以此类推。 O(n²)




/// 异常
enum SearchError: Error {
    // 数据异常
    case dataError
}
/// 节点
struct Node<T>: Hashable where T: Hashable {
    /// 值
    var value: T
    
    /// 初始化
    init(_ value: T) {
        self.value = value
    }
    
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        return lhs.value == rhs.value
//    }
}

/// 队列
struct Queue<T> where T: Hashable {
    
    /// 存储容器
    private var _queue: [Node<T>] = []
    
    /// 队列是否为空
    var isEmpty: Bool {
        return _queue.isEmpty
    }

    /// 初始化
    init(_ elements: [Node<T>]) {
        _queue.append(contentsOf: elements)
    }
    
    /// 入队
    /// - Parameter elements: 入队元素列表
    mutating func enter(_ elements: [Node<T>]) {
        if elements.isEmpty {
            return
        }
        _queue.append(contentsOf: elements)
    }
    
    /// 出队
    /// - Returns: 出队的元素
    mutating func out() -> Node<T> {
        return _queue.removeFirst()
    }
}

/// 广度优先搜索算法
/// - Parameters:
///   - graph: 图
///   - start: 开始节点
///   - target: 结束节点
/// - Throws: 异常
/// - Returns: 路径
func search<T: Hashable>(graph: [T: [Node<T>]],
                         start: Node<T>,
                         target: Node<T>) throws -> [Node<T>]? {
    
    var result: [Node<T>] = []
    guard let startValue = graph[start.value] else { throw SearchError.dataError }
    var queue = Queue(startValue)
//    result.append(start)
    
    while !queue.isEmpty {
        let checkItem = queue.out()
        switch checkItem == target {
        case true:
//            result.append(checkItem)
            debugPrint("get")
        case false:
            guard let nextSequence = graph[checkItem.value] else { throw SearchError.dataError }
            if !nextSequence.isEmpty {
               queue.enter(nextSequence)
            }
        }
    }
    
    
    return nil
}


// 图，散列表存储，用swift字典
/*
let you = Node("you")
let Bob = Node("Bob")
let Claire = Node("Claire")
let Alice = Node("Alice")
let Anuj = Node("Anuj")
let Peggy = Node("Peggy")
let Thom = Node("Thom")
let Jonny = Node("Jonny")
let jxs = Node("jxs")

var graph: [String: [Node<String>]] = [:]
graph[you.value] = [Bob, Claire, Alice]
graph[Bob.value] = [Anuj, Peggy]
graph[Claire.value] = [Thom, Jonny]
graph[Alice.value] = [Peggy]
graph[Anuj.value] = []
graph[Thom.value] = []
graph[Peggy.value] = []
graph[Jonny.value] = [jxs]
graph[jxs.value] = []

let start = Node("you")
let target = Node("jxs")
do {
    let result = try search(graph: graph, start:start, target: target)
} catch {
    debugPrint("异常了")
}
*/

/*
let you = Node(1)
let Bob = Node(2)
let Claire = Node(5)
let Alice = Node(9)
let Anuj = Node(12)
let Peggy = Node(4)
let Thom = Node(50)
let Jonny = Node(40)
let jxs = Node(100)

var graph: [Int: [Node<Int>]] = [:]
graph[you.value] = [Bob, Claire, Alice]
graph[Bob.value] = [Anuj, Peggy]
graph[Claire.value] = [Thom, Jonny]
graph[Alice.value] = [Peggy]
graph[Anuj.value] = []
graph[Thom.value] = []
graph[Peggy.value] = []
graph[Jonny.value] = [jxs]
graph[jxs.value] = []

let start = you
let target = jxs
do {
    let result = try search(graph: graph, start:start, target: target)
} catch {
    debugPrint("异常了")
}
*/

extension Dictionary {
    public subscript(start: Key, end: Key) -> Value? {
        set {
            let subDict = [end: newValue]
            self[start] = subDict as? Value
        }
        get {
            guard let dict = self[start] as? Dictionary<Key, Value> else { return nil }
            return dict[end]
        }
    }
}

/// 迪克斯特拉数据结构
struct DickstraGraph<Key, Value> where Key: Hashable {
    
    /// 内部存储的哈希表
    private var _hashTable : [Key: [Key: Value]] = [:]
    
    /// 下标方法
    ///  start 起始节点
    ///  end 结束节点
    public subscript(start: Key, end: Key) -> Value? {
        set {
            guard let subDict = [end: newValue] as? [Key: Value] else { return }
            _hashTable[start] = subDict
        }
        get {
            let dict = _hashTable[start]
            return dict?[end]
        }
    }
}

/// 乐谱
let yue = Node("yue")
/// 黑胶唱片
let hei = Node("hei")
/// 海报
let hai = Node("hai")
/// 吉他
let jita = Node("jita")
/// 架子鼓
let jia = Node("jia")
/// 钢琴
let gang = Node("gang")


/*
var dickstraDistanceGraph = DickstraGraph<Node<String>, Int>()
dickstraDistanceGraph[yue, hei] = 5
dickstraDistanceGraph[yue, hai] = 0
dickstraDistanceGraph[hei, jia] = 20
dickstraDistanceGraph[hei, jita] = 15
dickstraDistanceGraph[hai, jita] = 30
dickstraDistanceGraph[hai, jia] = 35
dickstraDistanceGraph[jia, gang] = 10
dickstraDistanceGraph[jita, gang] = 20
*/

var dickstraDistanceGraph: [Node<String>: [Node<String>: Int]] = [:]
dickstraDistanceGraph[yue] = [:]
dickstraDistanceGraph[yue]![hei] = 5
dickstraDistanceGraph[yue]![hai] = 0
dickstraDistanceGraph[hei] = [:]
dickstraDistanceGraph[hei]![jia] = 20
dickstraDistanceGraph[hei]![jita] = 15
dickstraDistanceGraph[hai] = [:]
dickstraDistanceGraph[hai]![jia] = 35
dickstraDistanceGraph[hai]![jita] = 30
dickstraDistanceGraph[jia] = [:]
dickstraDistanceGraph[jia]![gang] = 10
dickstraDistanceGraph[jita] = [:]
dickstraDistanceGraph[jita]![gang] = 20

let startNode = yue
let endNode = gang


func dickstraSearch<T>(dickstraGraph: [Node<T>: [Node<T>: Int]],
                              startNode: Node<T>,
                              endNode:  Node<T>) -> [Node<T>]? where T: Hashable {
    var cost: [Node<T>: Int] = [:]
    let d = dickstraGraph[startNode]
    d?.keys.forEach({ (node) in
        cost[node] = d?[node]
    })
    
    
    return nil
}

//dickstraSearch()
