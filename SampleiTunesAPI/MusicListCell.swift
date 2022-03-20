//
//  MusicListCell.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2021/05/23.
//

import UIKit
import Kingfisher

protocol MusicProtocol: AnyObject {
    
    func previewMusic(url: URL, index: Int)
    func stopMusic()
}

class MusicListCell: UITableViewCell {
    
    @IBOutlet weak private var artWorkImageView: UIImageView!
    @IBOutlet weak private var musicNameLabel: UILabel!
    @IBOutlet weak private var artistNameLabel: UILabel!
    @IBOutlet weak var previewButton: UIButton!
    
    private let playImage = UIImage(named: "play")
    private let stopImage = UIImage(named: "stop")
    private var audioUrl: URL?
    private var trackCensoredName: String?
    private var artistName: String?
    private var index: Int?
    weak var delegate: MusicProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        artWorkImageView.layer.cornerRadius = 5
        previewButton.setImage(playImage, for: UIControl.State())
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        artWorkImageView.image = nil
        musicNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(music: Response.Music, index: Int) {
        
        let artWorkImage = URL(string: music.artworkUrl100)
        let noImage = UIImage(named: "noImage")
        artWorkImageView.kf.indicatorType = .activity
        artWorkImageView.kf.setImage(with: artWorkImage, placeholder: noImage, options: nil)
        musicNameLabel.text = music.trackCensoredName
        artistNameLabel.text = music.artistName
        trackCensoredName = music.trackCensoredName
        artistName = music.artistName
        audioUrl = URL(string: music.previewUrl)
        self.index = index
    }
    
    @IBAction func preview(_ sender: Any) {
        
        guard let url = audioUrl else { return }
        guard let index = index else { return }
        if previewButton.currentImage != playImage {
            delegate?.stopMusic()
            UIView.animate(withDuration: 0.1, animations: {
                self.previewButton.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                self.previewButton.setImage(self.playImage, for: UIControl.State())
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.previewButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
                }) { (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.previewButton.transform = .identity
                    })
                }
            }
        } else {
            delegate?.previewMusic(url: url, index: index)
            UIView.animate(withDuration: 0.1, animations: {
                self.previewButton.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                self.previewButton.setImage(self.stopImage, for: UIControl.State())
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.previewButton.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
                }) { (_) in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.previewButton.transform = .identity
                    })
                }
            }
        }
    }}
