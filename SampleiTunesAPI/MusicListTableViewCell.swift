//
//  MusicListTableViewCell.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2021/05/23.
//

import UIKit

final class MusicListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
    }
    
}
