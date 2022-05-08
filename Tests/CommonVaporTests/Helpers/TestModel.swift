import Vapor

struct TestModel: Content, Equatable {
    let text: String
    let number: Int
    let percent: Float
    let embeddedObject: EmbeddedTestModel
}

struct EmbeddedTestModel: Content, Equatable {
    let identifier: String
}
