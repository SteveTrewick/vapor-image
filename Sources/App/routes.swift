import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }


    // Param .../hello/param
    app.get("hello", ":name") { req -> String in
      
      guard let name = req.parameters.get("name") else {
        throw Abort(.internalServerError)
      }
      
      return "Hello, \(name)!"
    }
    
    
    // JSON POST
    
    app.post("info") { req -> String in
      
      let data = try req.content.decode(InfoData.self)
      
      return "Hello \(data.name)!"
    }
    
    app.post("info1") { req -> InfoResponse in
      let data = try req.content.decode(InfoData.self)
      // 2
      return InfoResponse(request: data)
    }
    
}


struct InfoData: Content {
 let name: String
}
struct InfoResponse: Content {
  let request: InfoData
}
// OK, super simple. Obvs there's no auth or data, but this is
// what the top end looks like to serve a REST API.

// mainly from https://www.raywenderlich.com/11555468-getting-started-with-server-side-swift-with-vapor-4
