//
//  Dependency.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

@propertyWrapper
struct Inject<Component>{
    
    var component: Component
    
    init(){
        self.component = Resolver.shared.resolve(Component.self)
    }
    
    public var wrappedValue:Component{
        get { return component}
        mutating set { component = newValue }
    }
    
}
