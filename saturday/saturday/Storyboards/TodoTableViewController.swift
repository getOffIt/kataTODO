import UIKit

class TodoTableViewController: UITableViewController {

    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    var todos: [String] = ["hello", "antoine"]
    var service: TodosService = TodosService()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOCELLreuseIdentifier", for: indexPath)

        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }
}
