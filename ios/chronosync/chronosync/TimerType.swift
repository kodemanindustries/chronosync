import Foundation

protocol TimerType {
    var title: String { get }
    var identifier: UUID { get }

    /// Is the `Timer` actually running
    var isRunning: Bool { get }

    /// Has the `Timer` started, but is now stopped and not running?
    var hasStarted: Bool { get }

    /// The `Time` the `Timer` started in milliseconds (starting uptime value)
    var startTime: Time { get }

    /// The `Time` the `Timer` stopped in milliseconds (stopped uptime value)
    var stopTime: Time { get }

    /// The `Time` the `Timer` resumed in milliseconds (`resumeTime` - `stopTime` provides an offset that needs to be used in the calculation to get the total time)
    var resumeTime: Time { get }

    /// The `Time` the `Timer` paused in milliseconds (uptime since `startTime`)
    var pausedTime: Time { get }

    /// The `Time` that the `Timer` displays
    var tickingTime: Time { get }

    /// Start the `Timer` now
    func startNow()

    /// Stop the `Timer` now
    func stopNow()

    /// Resume the `Timer` now
    func resumeNow()

    /// Reset the `Timer`
    func reset()
}
