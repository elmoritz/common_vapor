import Vapor

public protocol ErrorReportContentful {
    var content: [String: String] { get }
    var statusCode: HTTPResponseStatus { get }
}

public struct BaseErrorReport: ErrorReportContentful {
    public let statusCode: HTTPResponseStatus
    public let reason: String
    public let uri: URI
    public let blame: String
    
    public var content: [String: String] {
        var content = [String:String]()
        content["reason"] = reason
        content["url"] = uri.string
        content["blame"] = blame
        return content
    }
}
    

