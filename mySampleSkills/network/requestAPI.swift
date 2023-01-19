//
//  requestAPI.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 18/01/23.
//

import Foundation

final class RequestAPI {
    let endpoint: String = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"

    func fetchFromMock(completionHandler: @escaping (StoreResponse) -> Void) {
        if let path = Bundle.main.path(forResource: "storeMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                if let response =  try? JSONDecoder().decode(StoreResponse.self, from: data) {
                    completionHandler(response)
                }
            } catch {
                // handle error (its a mock)
            }
        }
    }

    func fetch(completionHandler: @escaping (StoreResponse) -> Void) {
        let url = URL(string: endpoint)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Erro ao obter os filmes: \(error)")
            return
          }

          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Erro na resposta. Código de status esperado: \(String(describing: response))")
            return
          }

            if let checkData = data,
            let response = try? JSONDecoder().decode(StoreResponse.self, from: checkData) {
              completionHandler(response)
          }
        })
        task.resume()
    }
}
