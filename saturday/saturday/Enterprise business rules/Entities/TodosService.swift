//Created 14/03/2020

import Foundation

struct TODOsPODO {
    let title: String
    let userId: Int
}

class TodosService {

    struct Endpoints {
        let todos = "https://jsonplaceholder.typicode.com/todos"
    }

    struct ResponseData: Decodable {
        let title: String
        let userId: Int
    }
    var finalCompletionHandler: ([TODOsPODO]) -> Void = { todo in }

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

    func retrieve(completionHandler: @escaping (_ todos: [TODOsPODO]) -> Void) {
        self.finalCompletionHandler = completionHandler
        retrieveRemote(completionHandler: completionHandler)
    }

    func retrieveRemote(completionHandler: @escaping (_ todos: [TODOsPODO]) -> Void) {

        let session: URLSession = URLSession(configuration: .default)
        guard let todoURL = URL(string: Endpoints().todos) else {
            finishWithError(["bad", "URL"])
            return
        }
        session.dataTask(with: todoURL) { data, _, error in
            guard let responseData = data else {
                self.finishWithError(["Something", "went", "wrong", error.debugDescription])
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ResponseData].self, from: responseData)
                self.adaptJSONToTODOsPODO(jsonData)
            } catch {
                print("error:\(error)")
            }
        }.resume()
    }

    fileprivate func adaptJSONToTODOsPODO(_ responseData: [TodosService.ResponseData]) {
        var todos = [TODOsPODO]()
        for row in responseData {
            let todo = TODOsPODO(title: row.title, userId: row.userId)
            todos.append(todo)
        }
        finishWith(todos)
    }

    fileprivate func finishWith(_ todos: [TODOsPODO]) {
        DispatchQueue.global().async {
            self.finalCompletionHandler(todos)
        }
    }

    fileprivate func finishWithError(_ todos: [String]) {
        var todos = [TODOsPODO]()
        for row in todos {
            let todo = TODOsPODO(title: row.title, userId: 0)
            todos.append(todo)
        }
        self.finishWith(todos)
    }

    fileprivate func finishWithGenericError() {
        finishWithError(["had", "some", "problems"])
    }
}
