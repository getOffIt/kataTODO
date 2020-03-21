//Created 14/03/2020

import Foundation

class TodosService {

    struct ResponseData: Decodable {
        let title: String
    }

    func loadJson(filename fileName: String) -> [ResponseData]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ResponseData].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    func retrieve(completionHandler: @escaping (_ todos: [String]) -> Void) {

        retrieveRemote(completionHandler: completionHandler)
    }

    fileprivate func adaptJSONToArray(_ responseData: [TodosService.ResponseData],
                                      completionHandler: @escaping ([String]) -> Void) {
        var titles = [String]()
        for row in responseData {
            titles.append(row.title)
        }
        DispatchQueue.global().async {
            completionHandler(titles)
        }
    }

    func retrieveLocal(completionHandler: @escaping (_ todos: [String]) -> Void) {

        guard let responseData = loadJson(filename: "todossmall") else {
            completionHandler(["had some", "problems"])
            return
        }
        sleep(10)
        adaptJSONToArray(responseData, completionHandler: completionHandler)
    }

    enum Endpoints: String {
        case todos = "https://jsonplaceholder.typicode.com/todos"
    }

    func retrieveRemote(completionHandler: @escaping (_ todos: [String]) -> Void) {
        //request
        // get json out of request
        // return

        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: URL(string: Endpoints.todos.rawValue)!, completionHandler: { data, _, error in
            guard let responseData = data else {
                completionHandler(["Something", "went", "wrong", error.debugDescription])
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ResponseData].self, from: responseData)
                self.adaptJSONToArray(jsonData, completionHandler: completionHandler)
            } catch {
                print("error:\(error)")
            }
        }).resume()
    }
}
