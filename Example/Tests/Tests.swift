import Quick
import Nimble
import ClockTime

class ClockTimeSpec: QuickSpec {

    override func spec() {
        describe("ClockTime") {
            it("cannot be initialized with invalid values") {
                expect(ClockTime(hour: 0, minute: 0, second: 0)).notTo(beNil())
                expect(ClockTime(hour: 24, minute: 0, second: 0)).to(beNil())
                expect(ClockTime(hour: 0, minute: 60, second: 0)).to(beNil())
                expect(ClockTime(hour: 0, minute: 0, second: 60)).to(beNil())
            }

            it("can be added seconds") {
                expect(ClockTime(hour: 23, minute: 59, second: 59)! + 1) == ClockTime(hour: 0, minute: 0, second: 0)
            }

            it("can be subtracted seconds") {
                expect(ClockTime(hour: 0, minute: 0, second: 0)! - 1) == ClockTime(hour: 23, minute: 59, second: 59)
            }

            it("is comparable") {
                expect(ClockTime(hour: 1, minute: 2, second: 3)) == ClockTime(hour: 1, minute: 2, second: 3)
                expect(ClockTime(hour: 1, minute: 2, second: 2)!) < ClockTime(hour: 1, minute: 2, second: 3)!
                expect(ClockTime(hour: 1, minute: 3, second: 2)!) > ClockTime(hour: 1, minute: 2, second: 3)!
            }

            it("determines whether it is between two clock times") {
                expect(ClockTime(hour: 23, minute: 59, second: 59)!.isBetween(beginning: ClockTime(hour: 23, minute: 59, second: 59)!, end: ClockTime(hour: 23, minute: 59, second: 59)!)) == false
                expect(ClockTime(hour: 23, minute: 59, second: 59)!.isBetween(beginning: ClockTime(hour: 23, minute: 59, second: 59)!, end: ClockTime(hour: 0, minute: 0, second: 0)!)) == true
            }
        }
    }

}
