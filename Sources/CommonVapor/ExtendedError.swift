import Vapor

public protocol ExtendedError: Error {
    var statusCode: HTTPResponseStatus { get }
    var source: String? { get }
    var reason: String? { get }
    var additionalInfo: String? { get }
}
