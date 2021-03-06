//Created 14/03/2020

import Foundation

struct TODOsPODO {
    let title: String
    let userId: Int
    let completed: Bool
    var authorName: String
}

class TodosService {

    struct Endpoints {
        let todos = "https://jsonplaceholder.typicode.com/todos"
        let users = "https://jsonplaceholder.typicode.com/users"
    }

    struct ResponseDataTODOS: Decodable {
        let title: String
        let userId: Int
        let completed: Bool
    }

    struct ResponseDataUsers: Decodable {
        let id: Int
        let name: String
    }
    var finalCompletionHandler: ([TODOsPODO]) -> Void = { todo in }

    func loadJson(filename fileName: String) -> [ResponseDataTODOS]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ResponseDataTODOS].self, from: data)
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
                let jsonData = try decoder.decode([ResponseDataTODOS].self, from: responseData)
                self.adaptJSONToTODOsPODO(jsonData)
            } catch {
                print("error:\(error)")
            }
        }.resume()
    }

    fileprivate func adaptJSONToTODOsPODO(_ responseData: [TodosService.ResponseDataTODOS]) {
        var todos = [TODOsPODO]()
        for row in responseData {
            let todo = TODOsPODO(title: row.title, userId: row.userId, completed: row.completed, authorName: "")
            todos.append(todo)
        }
        addRemoteusersToTodos(todos)
    }

    fileprivate func finishWith(_ todos: [TODOsPODO]) {
        DispatchQueue.global().async {
            self.finalCompletionHandler(todos)
        }
    }

    fileprivate func addRemoteusersToTodos(_ todos: [TODOsPODO]) {
        guard let usersURL = URL(string: Endpoints().users) else {
            finishWithError(["url error for users"])
            return
        }
        URLSession(configuration: .default).dataTask(with: usersURL) {data, _, _ in
            guard let responseData = data else {
                self.finishWithError(["error reading user data"])
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ResponseDataUsers].self, from: responseData)
                self.addUserDatatoTodos(todos, users: jsonData)
            } catch {
                self.finishWithError(["error unpacking user data"])
            }
        }.resume()
    }

    fileprivate func addUserDatatoTodos(_ todos: [TODOsPODO], users: [ResponseDataUsers]) {
        var updatedTodos = [TODOsPODO]()
        for todo in todos {
            let authorName: String = users.filter { $0.id == todo.userId }[0].name
            let updatedTodo = TODOsPODO(title: todo.title, userId: todo.userId,
                                        completed: todo.completed, authorName: authorName)
            updatedTodos.append(updatedTodo)
        }
        finishWith(updatedTodos)
    }

    fileprivate func finishWithError(_ todos: [String]) {
        var newTodos = [TODOsPODO]()
        for row in todos {
            let todo = TODOsPODO(title: row, userId: 0, completed: false, authorName: "")
            newTodos.append(todo)
        }
        self.finishWith(newTodos)
    }

    fileprivate func finishWithGenericError() {
        finishWithError(["had", "some", "problems"])
    }
}
