//
//  DPServiceRequestHelper.swift
//  
//
//  Created by Daniel Perez Olivares on 04-06-22.
//

import Foundation

protocol NetworkProviderProtocol {
    func request<T: Decodable>(apiModel: APIModelType) async throws -> T
}

public struct DPServiceRequest: NetworkProviderProtocol {
    public static func request<T: Decodable>(apiModel: APIModelType) async throws -> T {
        guard let url = URL(string:(apiModel.api.apiBasePath()+apiModel.api.apiEndPath())) else {
            throw ServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = apiModel.api.httpMethodType().rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw ServiceError.unhandledError
            }
            
            switch response.statusCode {
            case 200...299:
                return try JSONDecoder().decode(T.self, from: data)
            case 401:
                throw ServiceError.unauthorized
            default:
                throw ServiceError.serverError
            }
        } catch {
            throw ServiceError.unhandledError
        }
    }
    
}
