
import Foundation

class Resolver{
  
    static let shared = Resolver()
    var factoryDict: [String: () -> Any] = [:]
    
    func add<Component>(type: Component.Type, _ factory: @escaping () -> Component) {
        factoryDict[String(describing: type.self)] = factory
    }
    
    func resolve<Component>() -> Component {
        resolve(Component.self)
    }

    func resolve<Component>(_ type: Component.Type) -> Component {
        let component: Component = factoryDict[String(describing:Component.self)]?() as! Component
        return component
    }
}


