//
//  Music.swift
//  SampleiTunesAPI
//
<<<<<<< HEAD
//  Created by Makoto on 2022/03/20.
//

import Foundation

struct Response: Codable {
    
    let resultCount: Int
    let results: [Music]
    
    struct Music: Codable {
        
        let artistName: String
        let trackCensoredName: String
        let previewUrl: String
        let artworkUrl100: String
=======
//  Created by Makoto on 2021/05/25.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MusicModel {
    
    func catchData(count: Int)
}

class Music {
    
//    アーティスト名
    var artistNameArray = [String]()
//    曲名
    var trackCensoredNameArray = [String]()
//    音源URL
    var previewUrlArray = [String]()
//    ジャケット画像
    var artworkUrl100Array = [String]()
    
    var musicDelegate: MusicModel?
    //JSON解析
    func setData(resultCount: Int,encodeUrlString: String) {
        //通信
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (resuponse) in
            //removeAll()で配列の中身を全て空にする。
            self.artistNameArray.removeAll()
            self.trackCensoredNameArray.removeAll()
            self.previewUrlArray.removeAll()
            self.artworkUrl100Array.removeAll()
            
            switch resuponse.result {
            
            case .success:
                do {
                    
                    let json:JSON = try JSON(data: resuponse.data!)
                    for i in 0...resultCount - 1 {
                        print(i)
                        
                        if json["results"][i]["artistName"].string == nil{
                            print("ヒットしませんでした。")
                            
                            return
                        }
                        
                        self.artistNameArray.append(json["results"][i]["artistName"].string!)
                        self.trackCensoredNameArray.append(json["results"][i]["trackCensoredName"].string!)
                        self.previewUrlArray.append(json["results"][i]["previewUrl"].string!)
                        self.artworkUrl100Array.append(json["results"][i]["artworkUrl100"].string!)
                    }
                    //全てのデータが取得完了している状態。
                    self.musicDelegate?.catchData(count: 1)
                } catch  {
                }
                break
            case .failure(_): break
            }
        }
        //最初ここが呼ばれる。
>>>>>>> main
    }
}
