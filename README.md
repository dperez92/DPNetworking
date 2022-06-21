# DPNetworking
Library that provides you all you need to make a request to your app.

# How to use it.

- Create a file to define the URL and path constants strings.
- Create an API file that's going to have all the operations that you app is going to support.
- Then you have extend ``APIProtocol`` to the APIFile that you created in the last step. This extension will have all the additional data that you need to make the request. (HttpMethodType, Queryparams, etc).
- Finally, you will have to define logic class that it's going to hold all the request information

# Example 


## Constant File

```
struct ServicesConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com/users"
    static let path = "/v0.1/checkouts"
}


```

## API file definition

```
enum ExampleAPI {
    case getUsers
}
```

## API file extension

```
extension ExampleAPI: APIProtocol {
    var httpMethodType: HTTPMethod {
        var methodType = HTTPMethod.get
        switch self {
        case .getUsers:
            methodType = .get
        }
        return methodType
    }
    
    var apiBasePath: String {
        switch self {
        case .getUsers:
            return ServicesConstants.baseURL + ServicesConstants.path
        }
    }
    
    var apiEndPath: String {
        return ""
    }
}
```

## Logic Class

```
struct ExampleServiceRequest {
    func getUsers() async throws -> [Users] {
        let requestModel = APIRequestModel(api: HelloFreshAPI.getUsers, parameters: nil)
        do {
            let response: [Users] = try await DPServiceRequest().request(apiModel:requestModel )
            return response
        } catch {
            throw ServiceError.failResponse
        }
    }
}

```

