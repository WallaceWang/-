import UIKit

// MARK: - 两数之和

/// 两数之和 O(n²)，知识点哈希表
/// 暴力法
/*
 func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
 for i in 0 ..< nums.count {
     for j in i + 1 ..< nums.count {
         if nums[i] + nums[j] == target {
             return [i, j]
         }
     }
 }
 return [0, 0]
 }
 */

/// 两遍哈希发 O(n²)
/*
 func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
 for i in 0 ..< nums.count  {
     let j = target - nums[i]
     //firstIndex(of: )  O(n)
     let index = nums.firstIndex(of: j)
     if index != nil && index! != i {
         return [i, index!]
     }
 }
 return [0, 0]
 }
 */

/// O(n)
/*
 func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
 var dict: [Int: Int] = [:]
 for i in 0 ..< nums.count  {
     dict[nums[i]] = i
 }
 for i in 0 ..< nums.count {
     let left = target - nums[i]
     let index = dict[left]
     if dict.keys.contains(left) && index != nil && index! != i {
         return [i, index!]
     }
 }
 return []
 }
 */
/// O(n)
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict: [Int: Int] = [:]
    for i in 0 ..< nums.count {
        let left = target - nums[i]
        let index = dict[left]
        if dict.keys.contains(left) && index != nil {
            return [i, index!]
        }
        dict[nums[i]] = i
    }
    return []
}

let result = twoSum([4, 3, 3, 15], 6)

// MARK: - 整数反转

/*
 func reverse(_ x: Int) -> Int {
 let negative = x < 0
 var x1 = x
 if negative {
     x1 = -x
 }
 let s = String(x1)
 let reversedS = s.reversed()
 var str = ""
 for item in reversedS {
     str.append(item)
 }
 guard let i = Int(str) else { return 0 }
 var result = i
 if negative {
     result = -i
 }
 if result > Int32.max || result < Int32.min {
     return 0
 }
 return result
 }
 */

func reverse(_ x: Int) -> Int {
    var num = x
    var re = 0
    var i = 0

    while num != 0 {
        i = num % 10
        num = num / 10
        re = re * 10 + i
    }
    if re > Int32.max || re < Int32.min {
        return 0
    }
    return re
}

// MARK: - 判断回文数

/*
 func isPalindrome(_ x: Int) -> Bool {
 guard x >= 0 else {
     return false
 }
 var re = 0
 var num = x
 var i = 0
 while num != 0  {
     i = num % 10
     num = num / 10
     re = re * 10 + i
 }

 if x == re {
     return true
 } else {
     return false
 }
 }
 */

/// 回文一半数字
func isPalindrome(_ x: Int) -> Bool {
    if x == 0 {
        return true
    }
    guard x > 0, x % 10 != 0 else {
        return false
    }
    var num: Int = x
    var re = 0
    while re < num {
        re = re * 10 + (num % 10)
        num = num / 10
    }
    return re == num || re / 10 == num
}

func longestCommonPrefix(str1: String, str2: String) -> String {
    var common: [Character] = []
    var str1Index = str1.startIndex
    var str2Index = str2.startIndex
    while str1Index < str1.endIndex && str2Index < str2.endIndex {
        if str1[str1Index] == str2[str2Index] {
            let c = str1[str1Index]
            common.append(c)
            str1Index = str1.index(after: str1Index)
            str2Index = str2.index(after: str2Index)
        } else {
            return String(common)
        }
    }
    if common.isEmpty {
        return ""
    }
    return String(common)
}

/// 分治法 O(n²)
func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.isEmpty {
        return ""
    }
    if strs.count == 1 {
        return strs.first!
    }
    if strs.count == 2 {
        return longestCommonPrefix(str1: strs.first!, str2: strs.last!)
    }
    if strs.count == 3 {
        let array = strs.dropFirst()
        let common = longestCommonPrefix(str1: array.first!, str2: array.last!)
        return longestCommonPrefix(str1: strs.first!, str2: common)
    }
    let m = strs.count / 2
    let str1 = longestCommonPrefix(Array(strs[0 ..< m]))
    let str2 = longestCommonPrefix(Array(strs[m ..< strs.count]))
    return longestCommonPrefix(str1: str1, str2: str2)
}

let u = longestCommonPrefix(str1: "hjop", str2: "hjop")
let array = ["hjop", "hjpo", "hjoq", "hjp", "hjopdasfd", "hj"]
let u1 = longestCommonPrefix(array)
// let i1 = reverse(123)
// let i2 = reverse(120)
// let i3 = reverse(-123)
// let i4 = reverse(-1200)
// let i5 = reverse(1534236469)

let result1 = isPalindrome(121)
let result2 = isPalindrome(123)
let result3 = isPalindrome(1221)
let result4 = isPalindrome(-121)
let result5 = isPalindrome(0)
let result6 = isPalindrome(1)

struct Stack {
    var dataArray: [String] = []

    mutating func push(_ element: String) {
        dataArray.append(element)
    }

    mutating func pop() -> String? {
        guard isEmpty() else {
            let element = dataArray.removeLast()
            return element
        }
        return nil
    }

    func isEmpty() -> Bool {
        return dataArray.isEmpty
    }
}

func isValid(_ s: String) -> Bool {
    var stack = Stack()
    for item in s {
        if item == "{" || item == "(" || item == "[" {
            stack.push(String(item))
        } else {
            guard let element = stack.pop() else { return false }
            debugPrint(element)
            switch item {
            case ")":
                if element != "(" {
                    return false
                }
                break
            case "]":
                if element != "[" {
                    return false
                }
                break
            case "}":
                if element != "{" {
                    return false
                }
                break
            default:
                return false
            }
        }
    }
    if stack.isEmpty() {
        return true
    }
    return false
}

func print(_ str: String) {
    var stack = Stack()
    for item in str {
        let s = String(item)
        stack.push(s)
    }
    while !stack.isEmpty() {
        guard let item = stack.pop() else { return }
        debugPrint("item: \(item)")
    }
}

let r = isValid("(")
// print("({[]})")

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() {
        val = 0
        next = nil
    }
    public init(_ val: Int) {
        self.val = val
        next = nil
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

class Solution {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        let mergeList = ListNode.init()
        var r = mergeList
        while let p = l1, let q = l2 {
            if p.val < q.val {
                r.next = p
                l1 = l1?.next
            } else {
                r.next = q
                l2 = l2?.next
            }
            r = r.next!
        }
        r.next = l1 ?? l2
        return mergeList.next
    }
}
