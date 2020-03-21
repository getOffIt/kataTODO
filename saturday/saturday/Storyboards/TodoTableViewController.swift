import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    var todos: [String] = ["hello", "antoine"]
    var service: TodosService = TodosService()
    @IBOutlet weak private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        service.retrieve { elements in
            self.todos = elements
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

extension TodoViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOCELLreuseIdentifier", for: indexPath)

        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }
}
