import Foundation

public struct ClockTime: CustomDebugStringConvertible, Equatable, Comparable {

    public let hour: Int
    public let minute: Int
    public let second: Int

    public var interval: Int {
        return hour * 60 * 60 + minute * 60 + second
    }

    public var debugDescription: String {
        return "\(hour)h \(minute)m \(second)s"
    }

    public init?(hour: Int, minute: Int, second: Int) {
        guard hour >= 0, minute >= 0, second >= 0,
            hour < 24, minute < 60, second < 60 else { return nil }
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    public init(date: Date, in calendar: Calendar = Calendar.current) {
        self.hour = calendar.component(.hour, from: date)
        self.minute = calendar.component(.minute, from: date)
        self.second = calendar.component(.second, from: date)
    }

    public func isBetween(_ start: ClockTime, and end: ClockTime) -> Bool {
        return self - start.interval <= end - start.interval
    }

    public func matchingDates(from start: Date, to end: Date, in calendar: Calendar = Calendar.current) -> [Date] {
        let dateComponents = DateComponents(hour: hour, minute: minute, second: second)
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

    public static func +(lhs: ClockTime, rhs: Int) -> ClockTime {
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

    public static func -(lhs: ClockTime, rhs: Int) -> ClockTime {
        let day: Int = 24 * 60 * 60
        let count = rhs / day + 1
        let interval = day * count - rhs
        return lhs + interval
    }

}
