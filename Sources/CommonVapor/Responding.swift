import Vapor

public protocol Responding {
    func wrap<C: Content>(_ object: C) -> Response
    func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response
}

public extension Responding {
    func wrap<C: Content>(_ object: C) -> Response {
        let response = Response(status: .ok,
                                version: .http2,
                                headers: HTTPHeaders(),
                                body: Response.Body())
        
        try? response.content.encode(object)
        return response
    }
    
    func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response {
        let response = Response(status: errorReport.statusCode,
                                version: .http2,
                                headers: HTTPHeaders.init(),
                                body: Response.Body())
        
        try? response.content.encode(errorReport.content)
        return response
    }
}
