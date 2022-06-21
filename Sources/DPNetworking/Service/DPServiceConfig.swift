//
//  DPServiceConfig.swift
//  
//
//  Created by Daniel Perez Olivares on 18-05-22.
//

import Foundation

// MARK: HTTPMethod Enum
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol APIProtocol {
    var httpMethodType: HTTPMethod { get }
    var apiEndPath: String { get }
    var apiBasePath: String { get }
}

public protocol APIModelType {
    var api: APIProtocol { get set }
    var parameters: [String: Any]? { get set }
}

public struct APIRequestModel: APIModelType {
    public var api: APIProtocol
    public var parameters: [String : Any]?
    
    public init(api: APIProtocol, parameters: [String: Any]?) {
        self.api = api
        self.parameters = parameters ?? nil
    }
}

