import XCTest
import Vapor
@testable import CommonVapor

final class CommonVaporTests: XCTestCase {
    func testRespondingProtocolWrapContent() throws {
        let model = TestModel(text: "text",
                              number: 123,
                              percent: 0.12345,
                              embeddedObject: EmbeddedTestModel(identifier: "1"))
        
        let sut = RespondigShell()
        
        let response = sut.wrap(model)
        XCTAssertEqual(response.status, .ok)
        XCTAssertEqual(response.version, .http2)
        
        let content = try? response.content.decode(TestModel.self)
        XCTAssertEqual(content, model)
    }
    
    func testRespondingProtocolWrapErrorReport() throws {
        let uri = URI(path: "https://www.google.com/")
        let model = BaseErrorReport(statusCode: .internalServerError,
                                    reason: "fake reason",
                                    uri: uri,
                                    blame: "test")
        
        let sut = RespondigShell()
        
        let response = sut.wrapErrorReport(model)
        XCTAssertEqual(response.status, .internalServerError)
        XCTAssertEqual(response.version, .http2)
        
        guard let content = try? response.content.decode([String:String].self) else {
            XCTFail()
            return
        }
        XCTAssertEqual(content["reason"],"fake reason")
        XCTAssertEqual(content["url"],uri.string)
        XCTAssertEqual(content["blame"],"test")
    }
    
    func testRespondingProtocolWrapError() throws {
        let model = TestError.test
        
        let sut = RespondigShell()
        
        let response = sut.wrapError(model)
        XCTAssertEqual(response.status, .internalServerError)
        XCTAssertEqual(response.version, .http2)
        
        guard let content = try? response.content.decode([String:String].self) else {
            XCTFail()
            return
        }
        XCTAssertEqual(content["error"],"test")
    }
    
    func testRespondingProtocolWrapExtendedErrorWithSource() throws {
        let models: [TestExtendedError] = [.testOnlySource, .testSourceAndInfo, .testSourceAndReason, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapExtendedError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["source"])
        }
    }
    
    func testRespondingProtocolWrapErrorWithSource() throws {
        let models: [TestExtendedError] = [.testOnlySource, .testSourceAndInfo, .testSourceAndReason, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["source"])
        }
    }
    
    func testRespondingProtocolWrapExtendedErrorWithReason() throws {
        let models: [TestExtendedError] = [.testOnlyReason, .testSourceAndReason, .testReasonAndInfo, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapExtendedError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["reason"])
        }
    }
    
    func testRespondingProtocolWrapErrorWithReason() throws {
        let models: [TestExtendedError] = [.testOnlyReason, .testSourceAndReason, .testReasonAndInfo, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["reason"])
        }
    }
    
    func testRespondingProtocolWrapExtendedErrorWithAdditionalInfo() throws {
        let models: [TestExtendedError] = [.testOnlyAdditionalInfo, .testReasonAndInfo, .testSourceAndInfo, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapExtendedError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["additionalInfo"])
        }
    }
    
    func testRespondingProtocolWrapErrorWithAdditionalInfo() throws {
        let models: [TestExtendedError] = [.testOnlyAdditionalInfo, .testReasonAndInfo, .testSourceAndInfo, .testAll]
        
        let sut = RespondigShell()
        for model in models {
            let response = sut.wrapError(model)
            XCTAssertEqual(response.status, .internalServerError)
            XCTAssertEqual(response.version, .http2)
            
            guard let content = try? response.content.decode([String:String].self) else {
                XCTFail()
                return
            }
            XCTAssertNotNil(content["additionalInfo"])
        }
    }
}
