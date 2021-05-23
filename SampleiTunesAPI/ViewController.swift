//
//  ViewController.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2021/05/22.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicListTableView: UITableView!
    
    private let musicListCell = "musicListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "検索"
        searchBar.delegate = self
        
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "musicListTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = musicListTableView.dequeueReusableCell(withIdentifier: "musicListTableViewCell") as! MusicListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
}

extension ViewController: UISearchBarDelegate {
    
}
