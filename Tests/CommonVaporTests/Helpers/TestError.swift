import Vapor
import CommonVapor

enum TestError: Error {    
    case test
}

enum TestExtendedError: ExtendedError {
    case testOnlySource
    case testOnlyReason
    case testOnlyAdditionalInfo
    case testSourceAndReason
    case testSourceAndInfo
    case testReasonAndInfo
    case testAll
    
    var statusCode: HTTPResponseStatus {
        return .internalServerError
    }
    
    var source: String? {
        switch self {
            case .testOnlySource:
                return "testOnlySource"
            case .testOnlyReason:
                return nil
            case .testOnlyAdditionalInfo:
                return nil
            case .testSourceAndReason:
                return "testSourceAndReason"
            case .testSourceAndInfo:
                return "testSourceAndInfo"
            case .testReasonAndInfo:
                return nil
            case .testAll:
                return "testAll"
        }
    }
    
    var reason: String? {
        switch self {
            case .testOnlySource:
                return nil
            case .testOnlyReason:
                return "testOnlyReason"
            case .testOnlyAdditionalInfo:
                return nil
            case .testSourceAndReason:
                return "testSourceAndReason"
            case .testSourceAndInfo:
                return nil
            case .testReasonAndInfo:
                return "testReasonAndInfo"
            case .testAll:
                return "testAll"
        }
    }
    
    var additionalInfo: String? {
        switch self {
            case .testOnlySource:
                return nil
            case .testOnlyReason:
                return nil
            case .testOnlyAdditionalInfo:
                return "testOnlyAdditionalInfo"
            case .testSourceAndReason:
                return nil
            case .testSourceAndInfo:
                return "testSourceAndInfo"
            case .testReasonAndInfo:
                return "testReasonAndInfo"
            case .testAll:
                return "testAll"
        }
    }
}
