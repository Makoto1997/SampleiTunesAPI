//
//  ITunesAPI.swift
//  SampleiTunesAPI
//
//  Created by Makoto on 2022/03/20.
//
import Foundation
import Alamofire

final class ITunesAPI {
    
    func request(resultCount: Int, searchText: String, completion: @escaping(([Response.Music], _ err: Error?) -> ())) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&entity=song&country=jp"
        let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseDecodable(of: Response.self) { response in
            
            switch response.result {
            case .success(let res):
                
                for _ in 0...resultCount - 1 {
                    
                    if res.resultCount == 0 {
                        print("ヒットしませんでした。")
                        break
                    }
                }
                
                completion(res.results, nil)
                
            case .failure(let err):
                print("検索に失敗しました。", err)
                completion([], err)
                break
            }
        }
    }
}
