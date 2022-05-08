import Vapor

public protocol Responding {
    func wrap<C: Content>(_ object: C) -> Response
    func wrapErrorReport<R: ErrorReportContentful>(_ errorReport: R) -> Response
    func wrapError<E: Error>(_ error: E) -> Response
    func wrapExtendedError<E: ExtendedError>(_ extendedError: E) -> Response
    
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
        if let extendedError = error as? ExtendedError {
            return unwrapExtendedError(extendedError)
        }
        
        return wrapSimpleError(error)
    }
    
    private func wrapSimpleError(_ error: Error) -> Response {
        let response = Response(status: .internalServerError,
                                version: .http2)
        let content = ["error":"\(error)"]
        try? response.content.encode(content)
        return response
    }
    
    func wrapExtendedError<E: ExtendedError>(_ extendedError: E) -> Response {
        return unwrapExtendedError(extendedError)
    }
    
    private func unwrapExtendedError(_ extendedError: ExtendedError) -> Response {
        let response = Response(status: extendedError.statusCode,
                                version: .http2)
        var content = ["error":"\(extendedError)"]
       
        if let source = extendedError.source {
            content["source"] = source
        }
        
        if let reason = extendedError.reason {
            content["reason"] = reason
        }
        
        if let additionalInfo = extendedError.additionalInfo {
            content["additionalInfo"] = additionalInfo
        }
        
        try? response.content.encode(content)
        return response
    }
}
