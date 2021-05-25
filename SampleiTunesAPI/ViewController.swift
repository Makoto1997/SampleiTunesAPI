//
//  ViewController.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2021/05/22.
//

import UIKit
import AVFoundation
import SDWebImage

final class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicListTableView: UITableView!
    
    private let musicListCell = "musicListTableViewCell"
    var player: AVAudioPlayer?
    var videoPath =  String()
    var musicModel = Music()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = "検索"
        searchBar.delegate = self
        
        musicModel.musicDelegate = self
        
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "musicListTableViewCell")
    }
    
    private func preview(url: URL) {
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
        }
    }
    
    @objc func tapPreviewButton(_ sender: UIButton) {
        
        //音楽が流れていたら止める。
        if player?.isPlaying == true {
            
            player?.stop()
        }
        
        let url = URL(string: musicModel.previewUrlArray[sender.tag])
        downLoadMusicURL(url: url!)
    }
    
    private func downLoadMusicURL(url: URL) {
        
        var downLoadTask: URLSessionDownloadTask
        downLoadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (url, res, err) in
            print(res as Any)
            self.preview(url: url!)
        })
        
        downLoadTask.resume()
    }
    
    private func reloadData() {
        
        if searchBar.text?.isEmpty != nil {
            
            let urlSting = "https://itunes.apple.com/search?term=\(String(describing:searchBar.text!))&entity=song&country=jp"
            
            let encodeUrlString: String = urlSting.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            musicModel.setData(resultCount: 50, encodeUrlString: encodeUrlString)
        }
    }
}

extension ViewController: MusicModel {
    
    func catchData(count: Int) {
        if count == 1 {
            
            musicListTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = musicListTableView.dequeueReusableCell(withIdentifier: "musicListTableViewCell") as! MusicListTableViewCell
        
        let artWorkImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let musicNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        let artistNameLabel = cell.contentView.viewWithTag(3) as! UILabel
        
        artWorkImageView.sd_setImage(with: URL(string: musicModel.artworkUrl100Array[indexPath.row]), completed: nil)
        musicNameLabel.text = musicModel.trackCensoredNameArray[indexPath.row]
        artistNameLabel.text = musicModel.artistNameArray[indexPath.row]
        
        cell.previewButton.addTarget(self, action: #selector(tapPreviewButton), for: .touchUpInside)
        cell.previewButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musicModel.artistNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    //    検索を始めた時のメソッド
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        キャンセルボタンを有効にする
        searchBar.showsCancelButton = true
    }
    //     キャンセルボタンが押された時のメソッド
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    //    検索ボタンを押した時のメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        reloadData()
    }
}
