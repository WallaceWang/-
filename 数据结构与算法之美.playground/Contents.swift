import UIKit

// MARK: - 单链表反转

class Node: NSObject {
    
    var value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
}

struct ListIterator: IteratorProtocol {
    var currentNode: Node?
    
    init(node: Node?) {
        self.currentNode = node
    }
    
    mutating func next() -> Int? {
        guard let node = currentNode else {
            return nil
        }
        let value = node.value
        currentNode = node.next
        return value
    }
}

/// 链表
class LinkedList: NSObject, ExpressibleByArrayLiteral, Sequence {
    
    
    var head: Node?
    var tail: Node?
    
    required init(arrayLiteral elements: Int...) {
        super.init()
        guard let firstValue = elements.first, let lastValue = elements.last else { return }
        head = Node.init(value: firstValue, next: nil)
        tail = Node.init(value: lastValue, next: nil)
        var p = head
        elements.dropFirst().dropLast().forEach { (value) in
            let node = Node.init(value: value, next: nil)
            p!.next = node
            p = node
        }
        p!.next = tail
    }
    
    func makeIterator() -> ListIterator {
        return ListIterator.init(node: head)
    }
    
    func print() {
        for node in self {
            debugPrint(node)
        }
    }
    
    /// 链表反转
    func reversed() {
        var p = head
        var q = p?.next
        var r = q?.next
        p?.next = nil
        while p != tail {
            q?.next = p
            p = q
            q = r
            r = r?.next
        }
        head = tail
    }
    
    /// 链表中环的检测
    /// 扩展：求入环点、环长
    func haveCircle() -> Bool {
        var p = head
        var q = head
        var haveCircle = false
        while q != nil {
            p = p?.next
            q = q?.next?.next
            if p?.value == q?.value {
                haveCircle = true
            }
        }
        return haveCircle
    }
    
    // 删除链表倒数第n个节点
    // 求链表的中间节点（快慢指针）
}

//let list: LinkedList = [1, 2, 7, 8, 9, 10, 12]
//list.print()

//list.reversed()
//list.print()

/*
let node1 = Node.init(value: 1, next: nil)
let node2 = Node.init(value: 2, next: nil)
let node3 = Node.init(value: 3, next: nil)
let node4 = Node.init(value: 4, next: nil)
let node5 = Node.init(value: 5, next: nil)

node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
node5.next = node2

let circleList: LinkedList = LinkedList()
circleList.head = node1
let circle = circleList.haveCircle()
*/


/// 归并排序（分治法，递归的方式实现）
func merge(a1: [Int], a2: [Int]) -> [Int] {
    var result: [Int] = []
    var i = 0, j = 0
    while i < a1.count && j < a2.count {
        if a1[i] < a2[j] {
            result.append(a1[i])
            i += 1
        } else {
            result.append(a2[j])
            j += 1
        }
    }
    if i < a1.count {
        result.append(contentsOf: a1[i..<a1.count])
    }
    if j < a2.count {
        result.append(contentsOf: a2[j..<a2.count])
    }
    return result
}

func mergeSortC(_ array: [Int], start: Int, end: Int) -> [Int] {
    let a = array
    if start >= end {
        return Array(a[start...end])
    }
    let middle = (start + end) / 2
    let a1 = mergeSortC(a, start: start, end: middle)
    let a2 =  mergeSortC(a, start: middle + 1, end: end)
    return merge(a1: Array(a1), a2: Array(a2))
}


/// 分治法：想清楚每一步是干什么 1.先分后治 2.每一步都有结果
/// 快速排序
extension Array where Element == Int {
    
    /// 分区函数 （把分区函数看成原子操作）
    mutating func partition(start: Int, end: Int) -> Int{
        let pivot = self[end]
        var i = start
        for j in start...end-1 {
            if self[j] < pivot {
                let temp = self[i]
                self[i] = self[j]
                self[j] = temp
                i += 1
            }
        }
        let temp = self[i]
        self[i] = self[end]
        self[end] = temp
        return i
    }
    
    mutating func quickSortC(start: Int, end: Int) {
        if start >= end {
            return
        }
        let p = self.partition(start: start, end: end)
        quickSortC(start: start, end: p - 1)
        quickSortC(start: p + 1, end: end)
    }
    
    mutating func findMax(with maxIndex: Int, start: Int, end: Int) -> Int {
        let pivot = self.partition(start: start, end: end)
//        debugPrint("pivot: \(pivot)")
//        debugPrint("b: \(self)")
        if pivot > maxIndex - 1 {
            return findMax(with: maxIndex, start: start, end: pivot - 1)
        }
        if pivot < maxIndex - 1 {
            return findMax(with: maxIndex, start: pivot + 1, end: end)
        }
//        debugPrint("pivot: \(pivot)")
        return self[pivot]
    }
}


//let a = mergeSortC([2, 1, 3, 6, 0, 5, 9], start: 0, end: 6)

var b = [2, 1, 3, 6, 0, 5, 9]
var b1 = [2]
var b2 = [2, 1]
//b.quickSortC(start: 0, end: 6)
let maxK = b.findMax(with: 5, start: 0, end: 6)
debugPrint("b: \(b)")
