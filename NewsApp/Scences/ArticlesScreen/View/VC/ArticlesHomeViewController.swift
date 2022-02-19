//
//  ArticlesHomeViewController.swift
//  NewsApp
//
//  Created by Ahmed on 14/02/2022.
//

import UIKit
enum StatusMode {
    case firstTime
    case secondTime
}
protocol ArticlesHomeViewProtocol: LoaderViewProtocol, AlertHandlerViewProtocol {
    func reloadTableView()
}

class ArticlesHomeViewController: UIViewController {

    //MARK: - Vars
    var presenter: ArticleHomePresenterProtocol!
    var statusMode: StatusMode = .firstTime
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! 
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        updateView()
    }
    
    init(statusMode: StatusMode) {
        self.statusMode = statusMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        title = "Articles"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ArticleTableViewCell.self)
        tableView.rowHeight = 190
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeYourSelectedCategory()

    }

    func changeYourSelectedCategory () {
        switch statusMode {
        case .firstTime:
            setupNavBackButton()
        case .secondTime:
            setRightButton(title: "Change Categories")

        }
    }
}

//MARK: - TableViewDataSource And Delegate
extension ArticlesHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let modeType = presenter.getModeType
        switch modeType {
        case .defaultMode:
            return presenter.getNumberOfSections
        case .searchMode:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let modeType = presenter.getModeType
        switch modeType {
        case .defaultMode:
            return presenter.getNumbersOfRowsFor(section: section)?.count ?? 0
        case .searchMode:
            return presenter.getNumberOfSearchedArticles
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 10, y: 0.0, width: tableView.frame.size.width , height: 70.0))
        view.backgroundColor = .mainColor
        let sectionCategoryLabel = UILabel(frame: view.frame)
        sectionCategoryLabel.textColor = .mainWhite
        sectionCategoryLabel.text = presenter.getCategoryNameFor(section)
        view.addSubview(sectionCategoryLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let modeType = presenter.getModeType
        switch modeType {
        case .defaultMode:
            return 70
        case .searchMode:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ArticleTableViewCell.self, for: indexPath)
        presenter.config(cell: cell, for: indexPath.row, in: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = presenter.didSelect(at: indexPath.row, for: indexPath.section)
        openUrl(url: url)
    }
    
}

//MARK: - SearchBar Config
extension ArticlesHomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didChange(text: searchText)
    }
}
    
//MARK: - View Protocol
extension ArticlesHomeViewController: ArticlesHomeViewProtocol {
    func reloadTableView() {
        self.tableView.reloadData()
    }
}



