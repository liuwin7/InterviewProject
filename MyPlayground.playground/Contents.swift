//: Playground - noun: a place where people can play

import Cocoa

/// x = 毽子 , y = 跳绳
/// return (Int, Int) （毽子的个数， 跳绳的个数）
func plansFor(total: Int, x_price: Int, y_price: Int) ->[(Int, Int)] {
    var x_count = 0, y_count = 0
    let x_per = x_price, y_per = y_price
    
    var plans = [(Int, Int)]()
    while x_count * x_per <= total {
        y_count = 0
        while(x_count * x_per + y_count * y_per <= total) {
            if x_count * x_per + y_count * y_per == total {
                plans.append((x_count, y_count))
            }
            y_count++
        }
        x_count++
    }
    return plans
}

func plans2For(total: Int, x_price: Int, y_price: Int) ->[(Int, Int)] {
    var plans = [(Int, Int)]()
    var x_count = 0, y_count = 0
    let x_per = x_price, y_per = y_price

    while (x_count * x_per <= total) {
        if (total - x_count * x_per) % y_per == 0 {
            y_count = (total - x_count * x_per) / y_per
            plans.append((x_count, y_count))
        }
        x_count++
    }
    
    return plans
}

let total = 35
let x_per = 3, y_per = 5

print("x: 毽子, y: 跳绳")

var date1 = NSDate()
let plans2 = plans2For(total, x_price: x_per, y_price: y_per)
var date2 = NSDate()

print("time spend \(date2.timeIntervalSince1970 * 1000 - date1.timeIntervalSince1970 * 1000) ms")

if plans2.count == 0 {
    print("没有方案")
} else {
    for plan in plans2 {
        let x_count = plan.0
        let y_count = plan.1
        print("x:\(x_count), y:\(y_count) (\(x_count) * \(x_per) + \(y_count) * \(y_per) = \(x_count * x_per + y_count * y_per))")
    }
}

print("_________________")
date1 = NSDate()
let plans = plansFor(total, x_price: x_per, y_price: y_per)
date2 = NSDate()
print("time spend \(date2.timeIntervalSince1970 * 1000 - date1.timeIntervalSince1970 * 1000) ms")

if plans.count == 0 {
    print("没有方案")
} else {
    for plan in plans {
        let x_count = plan.0
        let y_count = plan.1
        print("x:\(x_count), y:\(y_count) (\(x_count) * \(x_per) + \(y_count) * \(y_per) = \(x_count * x_per + y_count * y_per))")
    }
}
