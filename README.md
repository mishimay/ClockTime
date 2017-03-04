# ClockTime
Simple clock model written in Swift.

## Usage
### Add seconds
```swift
ClockTime(hour: 23, minute: 59, second: 59)! + 1
// -> 0h 0m 0s
```

### Subtract seconds
```swift
ClockTime(hour: 0, minute: 0, second: 0)! - 1
// -> 23h 59m 59s
```

### Compare two clock times
```swift
ClockTime(hour: 0, minute: 0, second: 0)! == ClockTime(hour: 0, minute: 0, second: 0)!
// -> true
ClockTime(hour: 0, minute: 0, second: 1)! > ClockTime(hour: 0, minute: 0, second: 0)!
// -> true
```

### Determine whether it is between two clock times
```swift
ClockTime(hour: 0, minute: 0, second: 0)!.
    isBetween(
        beginning: ClockTime(hour: 23, minute: 59, second: 59)!,
        end: ClockTime(hour: 0, minute: 0, second: 1)!
    )
// -> true
```

## Requirements
Swift 3

## Installation
```ruby
pod "ClockTime"
```

## License
ClockTime is available under the MIT license. See the LICENSE file for more info.
