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

class ElementProvider {
    var todos = [TODOsPODO]([TODOsPODO(title: "Loading", userId: 0, completed: false)])
    var count: Int {
            return todos.count
    }
    subscript(index: Int) -> TODOsPODO {
        return todos[index]
    }
}
