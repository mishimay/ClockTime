import Foundation

public struct ClockTime: CustomDebugStringConvertible, Equatable, Comparable {

    public let hour: UInt
    public let minute: UInt
    public let second: UInt

    public var interval: UInt {
        return hour * 60 * 60 + minute * 60 + second
    }

    public var debugDescription: String {
        return "\(hour)h \(minute)m \(second)s"
    }

    public init?(hour: UInt, minute: UInt, second: UInt) {
        guard hour < 24, minute < 60, second < 60 else { return nil }
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    public init(date: Date, in calendar: Calendar = Calendar.current) {
        self.hour = UInt(calendar.component(.hour, from: date))
        self.minute = UInt(calendar.component(.minute, from: date))
        self.second = UInt(calendar.component(.second, from: date))
    }

    public func isBetween(_ start: ClockTime, and end: ClockTime) -> Bool {
        return self - start.interval <= end - start.interval
    }

    public func matchingDates(from start: Date, to end: Date, in calendar: Calendar = Calendar.current) -> [Date] {
        let dateComponents = DateComponents(hour: Int(hour), minute: Int(minute), second: Int(second))
        var matching = [Date]()
        if self == ClockTime(date: start, in: calendar) {
            matching.append(start)
        }
        var date = start
        while true {
            guard let nextDate = calendar.nextDate(after: date, matching: dateComponents, matchingPolicy: .nextTime, direction: .forward),
                nextDate <= end else { break }
            matching.append(nextDate)
            date = nextDate
        }
        return matching
    }

    public static func ==(lhs: ClockTime, rhs: ClockTime) -> Bool {
        return lhs.hour == rhs.hour && lhs.minute == rhs.minute && lhs.second == rhs.second
    }

    public static func <(lhs: ClockTime, rhs: ClockTime) -> Bool {
        return lhs.interval < rhs.interval
    }

    public static func +(lhs: ClockTime, rhs: UInt) -> ClockTime {
        var hour = lhs.hour
        var minute = lhs.minute
        var second = lhs.second
        second += rhs
        minute += second / 60
        second = second % 60
        hour += minute / 60
        minute = minute % 60
        hour = hour % 24
        return ClockTime(hour: hour, minute: minute, second: second)!
    }

    public static func -(lhs: ClockTime, rhs: UInt) -> ClockTime {
        let day: UInt = 24 * 60 * 60
        let count = rhs / day + 1
        let interval = day * count - rhs
        return lhs + interval
    }

}
