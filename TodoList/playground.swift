import Foundation
import Playgrounds

#Playground {
    func greet(language: String) {
        let message = "Hello, \(language)!"
        print(message)
    }
    
    greet(language: "Swift")
}


#Playground {
    // 引数名の省略、オプショナル
    func greet(_ language: String?) {
        // guard句、シャドーイング
        guard let language else {
            print("Hello, world!")
            return
        }
        
        print("Hello, \(language)!")
    }
    
    greet("Swift")
    greet(nil)
}

#Playground {
    // エラーの定義
    enum GreetError: Error {
        case someError
    }
    
    func greet() throws {
        throw GreetError.someError
    }
    
    // do-try-catch, error
    do {
        try greet()
    } catch {
        print(error)
    }
}

#Playground {
    func greet(_ languages: [String]) {
        
        languages.forEach {
            print("Hello, \($0)!")
        }
    }
    
    greet(["Swift", "TypeScript", "Python"])
}

