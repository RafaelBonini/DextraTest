//
//  Api.swift
//  DextraGithubTest
//
//  Created by Rafael Bonini on 9/21/19.
//  Copyright © 2019 Rafael Bonini. All rights reserved.
//

import Foundation
import Alamofire

#if RELEASE
let debugRequests = false
#else
let debugRequests = true
#endif

class Api {
    
    let alamofireManager = Alamofire.SessionManager.default
    
    static let downloadManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3 * 60
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    func isInternetConnection() -> Bool {
        return true
    }
    
    public func requestCodable<T>(metodo: wMethods,
                                  url: String? = nil,
                                  objeto: T.Type,
                                  parametros: [String: Any],
                                  onSuccess: @escaping (_ response: HTTPURLResponse, _ objeto: T) -> Void,
                                  onFail: @escaping (_ response: HTTPURLResponse?, _ erroDescription: String) -> Void)
        where T: Codable {
            
            if !Utils.isConnectedToNetwork() {
                onFail(nil, "Please check your internet connection and try again.")
                return
            }
            
            let tipoRequisicao = getTipoRequisicao(tipo: metodo)

            var urlRequisicao = ""
            
            if debugRequests && metodo == .POST {
                print("\n\n===========JSON===========")
                parametros.printJson()
                print("===========================\n\n")
            }
            
            if let url = url {
                urlRequisicao = url
            } else {
                print("An error has occurred, no method & URL has been defined!")
            }
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
            ]
            
            var encoded: ParameterEncoding = JSONEncoding.default
            
            if tipoRequisicao == .get {
                encoded = URLEncoding.default
            }
            
            Alamofire.request(urlRequisicao,
                              method: tipoRequisicao,
                              parameters: parametros, encoding: encoded, headers: headers)
                .responseJSON { (response) in
                    
                    if debugRequests {
                        print("""
                            \nDevice ID: \(UIDevice.current.identifierForVendor!.uuidString)
                            \n\nRequest: \(String(describing: response.request))
                            \nParametros: \n\(parametros)
                            \nTipo requisição:\(tipoRequisicao)\n\n
                            """)
                        print(response)
                    }
                    
                    if response.response?.statusCode == 401 {
                        onFail(nil, "Sorry, we could not complete the operation. Please try again later.")
                    }
                    
                    switch response.result {
                        
                    case .success:
                        
                        do {
                            let objeto = try JSONDecoder().decode(objeto.self, from: response.data!)
                            onSuccess(response.response!, objeto)
                        } catch (let error) {
                            print("\n\n===========Error===========")
                            print("Error Code: \(error._code)")
                            print("Error Messsage: \(error.localizedDescription)")
                            if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                                print("Server Error: " + str)
                            }
                            debugPrint(error as Any)
                            print("===========================\n\n")
                        }
                        
                    case .failure(let error):
                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                        }
                        debugPrint(error as Any)
                        print("===========================\n\n")
                        onFail(response.response, "The server is not responding (cod.80).")
                    }
            }
    }
    
    private func getTipoRequisicao(tipo: wMethods) -> HTTPMethod {
        switch tipo {
        case .GET:
            return .get
        case .POST:
            return .post
        }
    }
}
