import Vapor
import Fluent

public protocol ModuleInterface {
    var router: RouteCollection? { get }
    var migrations: [Migration] { get }
    
    func configure(_ app: Application) throws
}

public extension ModuleInterface {
    
    func configure(_ app: Application) throws {
        for migration in migrations {
            app.migrations.add(migration)
        }
        if let router = router {
            try router.boot(routes: app.routes)
        }
    }
}
