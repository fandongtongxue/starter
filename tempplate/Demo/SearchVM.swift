//
//  SearchViewModel.swift
//  RxProject
//
//  Created by isoftstone on 2023/5/19.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import FDLibrary

class SearchVM {
    var songs: BehaviorRelay<[SearchModelResultSongs]> = BehaviorRelay(value: [])
    var searchText: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    private var disposeBag = DisposeBag()
    
    init() {
        searchText.asObservable()
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[SearchModelResultSongs]> in
//                let url = "https://netease-cloud-music-api-five-nu.vercel.app/search?keywords=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                return RxAlamofire.requestJSON(.get, url!)
//                    .debug("RxAlamofire")
//                    .map { (response, json) -> [SearchModelResultSongs] in
//                        guard let body = json as? [String: Any] else { return [] }
//                        let songsResponse = SearchModel.deserialize(from: body) ?? SearchModel()
//                        return songsResponse.result?.songs ?? []
//                    }
                return RxFDNetwork.getSongs(key: query).map({ $0.result?.songs ?? [] })
            }
            .bind(to: songs)
            .disposed(by: disposeBag)
    }
}

extension RxFDNetwork {
    static func getSongs(key: String) -> Observable<SearchModel> {
        fdJSON(getRequest(url: "https://netease-cloud-music-api-five-nu.vercel.app/search?keywords=\(key)"))
    }
}
