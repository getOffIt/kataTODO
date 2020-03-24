import UIKit

class TodoViewController: UIViewController {

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    var todos: ElementProvider = ElementProvider()
    var service: TodosService = TodosService()
    @IBOutlet weak private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        service.retrieve { elements in
            self.todos.todos = elements
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    @IBAction func segmentControllerValueDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            todos.completionFilter = .all
        case 1:
            todos.completionFilter = .active
        case 2:
            todos.completionFilter = .completed
        default:
            todos.completionFilter = .all
        }
        tableView.reloadData()
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

            cell.textLabel?.text = todos[indexPath.row].title
            return cell
        }
    }

    enum CompletionFilter {
        case all
        case active
        case completed
    }

    class ElementProvider {
        var todos = [TODOsPODO]([TODOsPODO(title: "Loading", userId: 0, completed: false, authorName: "")])
        var completionFilter = CompletionFilter.all
        lazy private var activeTodos = todos.filter { $0.completed == false }
        lazy private var completedTodos = todos.filter { $0.completed == true }

        var count: Int {
            switch completionFilter {
            case .all:
                return todos.count
            case .active:
                return activeTodos.count
            case .completed:
                return completedTodos.count
            }
        }
        subscript(index: Int) -> TODOsPODO {
            switch completionFilter {
            case .all:
                return todos[index]
            case .active:
                return activeTodos[index]
            case .completed:
                return completedTodos[index]
            }
        }
}
