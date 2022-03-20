//
//  ViewController.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2021/05/22.
//

import UIKit
import AVFoundation
<<<<<<< HEAD

final class ViewController: UIViewController {

    @IBOutlet weak private var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "検索"
            searchBar.tintColor = .black
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "キャンセル"
        }
    }
    
    @IBOutlet weak private var musicListTableView: UITableView! {
        didSet {
            musicListTableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            musicListTableView.delegate = self
            musicListTableView.dataSource = self
        }
    }
    
    private var indicator = UIActivityIndicatorView() {
        didSet {
            
            indicator.center = view.center
            indicator.style = .large
            indicator.color = UIColor.gray
            view.addSubview(indicator)
            indicator.isHidden = true
        }
    }
    
    private let cellNibName = "MusicListCell"
    private let cellIdentifier = "MusicListCell"
    private var musics: [Response.Music] = []
    private var player: AVAudioPlayer?
    private var index: Int?
=======
import SDWebImage

final class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var musicListTableView: UITableView!
    
    private let musicListCell = "musicListTableViewCell"
    var player: AVAudioPlayer?
    var videoPath =  String()
    var musicModel = Music()
>>>>>>> main
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func downLoadMusicURL(url: URL) {
        
        var downLoadTask: URLSessionDownloadTask
        downLoadTask = URLSession.shared.downloadTask(with: url, completionHandler: { (url, res, err) in
            if let err = err {
                print("楽曲のダウンロードに失敗しました。", err)
                return
            }
            
            guard let url = url else { return }
            self.playerPlay(url: url)
        })
        
        downLoadTask.resume()
    }
    
    private func playerPlay(url: URL) {
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.delegate = self
            self.player?.prepareToPlay()
            self.player?.volume = 1.0
            self.player?.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    private func reloadData() {
        
<<<<<<< HEAD
        if searchBar.text?.isEmpty != nil {
            
            self.indicator.isHidden = false
            self.indicator.startAnimating()
            let searchText = String(describing: searchBar.text!)
            ITunesAPI().request (resultCount: 50, searchText: searchText, completion: { [weak self] musics, err in
                self?.indicator.stopAnimating()
                self?.indicator.isHidden = true
                if err != nil {
                    return
                }
                
                self?.musics = musics
                self?.musicListTableView.reloadData()
            })
        }
=======
        musicModel.musicDelegate = self
        
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        musicListTableView.register(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: "musicListTableViewCell")
>>>>>>> main
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

extension ViewController: MusicProtocol {
    
    func previewMusic(url: URL, index: Int) {
        
        if let selfIndex = self.index {
            guard let cell = musicListTableView.cellForRow(at: IndexPath(row: selfIndex, section: 0)) as? MusicListCell else { return }
            cell.previewButton.setImage(UIImage(named: "play"), for: UIControl.State())
            player?.stop()
        }
        
<<<<<<< HEAD
        downLoadMusicURL(url: url)
        self.index = index
=======
        let artWorkImageView = cell.contentView.viewWithTag(1) as! UIImageView
        let musicNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        let artistNameLabel = cell.contentView.viewWithTag(3) as! UILabel
        
        artWorkImageView.sd_setImage(with: URL(string: musicModel.artworkUrl100Array[indexPath.row]), completed: nil)
        musicNameLabel.text = musicModel.trackCensoredNameArray[indexPath.row]
        artistNameLabel.text = musicModel.artistNameArray[indexPath.row]
        
        cell.previewButton.addTarget(self, action: #selector(tapPreviewButton), for: .touchUpInside)
        cell.previewButton.tag = indexPath.row
        
        return cell
>>>>>>> main
    }
    
    func stopMusic() {
        
        player?.stop()
    }
}

extension ViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_: AVAudioPlayer, successfully flag: Bool) {
        
<<<<<<< HEAD
        guard let index = index else { return }
        guard let cell = musicListTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? MusicListCell else { return }
        cell.previewButton.setImage(UIImage(named: "play"), for: UIControl.State())
=======
        return musicModel.artistNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
>>>>>>> main
    }
}

extension ViewController: UISearchBarDelegate {
<<<<<<< HEAD
    // 検索を始めた時のメソッド
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // キャンセルボタンを有効にする
        searchBar.showsCancelButton = true
    }
    // キャンセルボタンが押された時のメソッド
=======
    //    検索を始めた時のメソッド
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        キャンセルボタンを有効にする
        searchBar.showsCancelButton = true
    }
    //     キャンセルボタンが押された時のメソッド
>>>>>>> main
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
<<<<<<< HEAD
    // 検索ボタンを押した時のメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = musicListTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MusicListCell else { return UITableViewCell() }
        
        let music = musics[indexPath.row]
        cell.configure(music: music, index: indexPath.row)
        cell.delegate = self
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
=======
    //    検索ボタンを押した時のメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        reloadData()
    }
>>>>>>> main
}
