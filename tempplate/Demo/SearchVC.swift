//
//  ViewController.swift
//  RxProject
//
//  Created by isoftstone on 2023/5/19.
//

import UIKit
import RxSwift
import FDLibrary

class SearchVC: BaseVC {
    
    let viewModel = SearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(CGFloat.navigationBarHeight)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        
        viewModel.songs.bind(to: tableView.rx.items(cellIdentifier: "SongsCell", cellType: SearchCell.self)) { (rows, songs, cell) in
            cell.textLabel?.text = "\(songs.name ?? "") - \(songs.artists.first?.name ?? "")"
        }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    }
    
    @objc private func doneAction() {
        dismiss(animated: true)
    }
    
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.contentInset = .init(top: 0, left: 0, bottom: .safeAreaBottomHeight, right: 0)
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SongsCell")
        return tableView
    }()
    
    lazy var searchBar: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "请输入歌曲名"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { _ in
            textField.resignFirstResponder()
        }).disposed(by: disposeBag)
        return textField
    }()


}

