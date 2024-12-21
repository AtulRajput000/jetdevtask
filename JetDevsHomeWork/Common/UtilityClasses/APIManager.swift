
import Foundation
import UIKit

enum RequestType: String {
    
    case GET = "GET"
    case POST = "POST"
}

class APIManager: NSObject {
    
    // MARK: - Properties
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    // MARK: - Server Communication Methods
    func callAPIWithParameters(apiPath: String,
                               requestType: RequestType,
                               requestTimeOut: TimeInterval = 30.0,
                               header: [String: String]? = nil,
                               parameters: [String: Any]? = nil,
                               completionHandler :@escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let apiPathURL = apiPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let apiURL = URL(string: apiPathURL) else {
            return
        }
        
        var request = URLRequest(url: apiURL, timeoutInterval: requestTimeOut)
        request.httpMethod = requestType.rawValue
        
        if let parameters = parameters {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            
            request.httpBody = httpBody
        }
        
        if let header = header {
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(data, response, error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(data, response, error)
            }
        }

        dataTask?.resume()
    }
    
    func cancelRequestWithURL(_ url: URL) {
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .filter { $0.originalRequest?.url == url }.first?
                .cancel()
        }
    }
}
