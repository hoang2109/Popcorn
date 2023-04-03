//
//  URLSessionHTTPClient.swift
//  Popcorn
//
//  Created by Hoang Nguyen on 3/4/23.
//

import Foundation
import RxSwift

class URLSessionHTTPClient {
    
    private let configuration: NetworkConfiguration
    
    init(with configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    private func request(_ request: URLRequest,
                         deliverQueue: DispatchQueue = DispatchQueue.main,
                         completion: @escaping (Result<Data, NetworkError>) -> Void) -> URLSessionTask {
        print( "request: [\(request)]" )
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                deliverQueue.async {
                    completion( .failure(.requestFailed) )
                }
                return
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                if let data = data {
                    deliverQueue.async {
                        completion( .success( data ))
                    }
                } else {
                    deliverQueue.async {
                        completion( .failure(  .invalidData ))
                    }
                }
            } else {
                deliverQueue.async {
                    completion( .failure( NetworkError(response: httpResponse) ))
                }
            }
        }
        task.resume()
        return task
    }
}

extension URLSessionHTTPClient: DataTransferService {
    
    func request<Element>(_ router: EndPoint, _ decodingType: Element.Type) -> Observable<Element> where Element: Decodable {
        return Observable<Element>.create { [unowned self] (event) -> Disposable in
            
            let task = self.request( router.getUrlRequest(with: self.configuration)) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let resp = try decoder.decode(decodingType, from: data)
                        event.on( .next(resp) )
                    } catch {
                        print("error to Decode: [\(error)]")
                        event.on( .error(error))
                    }
                case .failure(let error):
                    print("error server: [\(error)]")
                    event.on( .error(error) )
                }
                event.onCompleted()
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
