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

        guard let responseData = loadJson(filename: "todossmall") else {
            completionHandler(["had some", "problems"])
            return
        }
        var titles = [String]()
        for row in responseData {
            titles.append(row.title)
        }
        DispatchQueue.global().async {
            completionHandler(titles)
        }
    }
}
