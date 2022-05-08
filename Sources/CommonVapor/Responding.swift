import Vapor

public protocol Responding {
    func wrap<C: Content>(_ object: C) -> Response
    func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response
    func wrapError<E: Error>(_ error: E) -> Response
    func wrapExtendedError<E: ExtendedError>(_ error: E) -> Response
    
}

public extension Responding {
    func wrap<C: Content>(_ object: C) -> Response {
        let response = Response(status: .ok,
                                version: .http2)
        
        try? response.content.encode(object)
        return response
    }
    
    func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response {
        let response = Response(status: errorReport.statusCode,
                                version: .http2)
        
        try? response.content.encode(errorReport.content)
        return response
    }
    
    func wrapError<E: Error>(_ error: E) -> Response {
        let response = Response(status: .internalServerError,
                                version: .http2)
        let content = ["error":"\(error)"]
        try? response.content.encode(content)
        return response
    }
    
    func wrapExtendedError<E: ExtendedError>(_ error: E) -> Response {
        let response = Response(status: error.statusCode,
                                version: .http2)
        var content = ["error":"\(error)"]
       
        if let source = error.source {
            content["source"] = source
        }
        
        if let reason = error.reason {
            content["reason"] = reason
        }
        
        if let additionalInfo = error.additionalInfo {
            content["additionalInfo"] = additionalInfo
        }
        
        try? response.content.encode(content)
        return response
    }
}
