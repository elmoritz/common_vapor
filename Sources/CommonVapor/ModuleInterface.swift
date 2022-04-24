import Vapor
import Fluent

public protocol ModuleInterface {
    var routers: [RouteCollection] { get }
    var migrations: [Migration] { get }
    
    func configure(_ app: Application) throws
}

public extension ModuleInterface {
    func configure(_ app: Application) throws {
        // add migrations
        for migration in migrations {
            app.migrations.add(migration)
        }
        
        // register Routes
        for router in routers {
            try router.boot(routes: app.routes)
        }
    }
}
