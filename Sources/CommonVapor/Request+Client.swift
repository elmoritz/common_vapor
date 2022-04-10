import Vapor

public extension Request {
    func get(_ url: URI,
                         headers: HTTPHeaders = [:],
                         beforeSend: (inout ClientRequest) throws -> () = { _ in }) async throws -> ClientResponse {
        return try await self.client.get(url, headers: headers, beforeSend: beforeSend)
    }
    
     func post(_ url: URI,
              headers: HTTPHeaders = [:],
               beforeSend: (inout ClientRequest) throws -> () = { _ in })async throws -> ClientResponse {
         return try await self.client.post(url, headers: headers, beforeSend: beforeSend)
     }
    
     func patch(_ url: URI,
               headers: HTTPHeaders = [:],
                beforeSend: (inout ClientRequest) throws -> () = { _ in })async throws -> ClientResponse {
         return try await self.client.patch(url, headers: headers, beforeSend: beforeSend)
     }
    
     func put(_ url: URI,
             headers: HTTPHeaders = [:],
              beforeSend: (inout ClientRequest) throws -> () = { _ in })async throws -> ClientResponse {
         return try await self.client.put(url, headers: headers, beforeSend: beforeSend)
     }
    
     func delete(_ url: URI,
                headers: HTTPHeaders = [:],
                 beforeSend: (inout ClientRequest) throws -> () = { _ in })async throws -> ClientResponse {
         return try await self.client.delete(url, headers: headers, beforeSend: beforeSend)
     }
}

