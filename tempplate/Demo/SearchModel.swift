//
//  RootClass.swift
//
//
//  Created by JSONConverter on 2023/02/25.
//  Copyright © 2023年 JSONConverter. All rights reserved.
//

import Foundation
import FDLibrary

class SearchModel: FDBaseModel {
    var code: Int = 0
    var result: SearchModelResult?
}

class SearchModelResult: FDBaseModel {
    var hasMore: Bool = false
    var songCount: Int = 0
    var songs = [SearchModelResultSongs]()
}

class SearchModelResultSongs: FDBaseModel {
    var album: SearchModelResultSongsAlbum?
    var alias = [String]()
    var artists = [SearchModelResultSongsArtists]()
    var copyrightId: Int = 0
    var duration: Int = 0
    var fee: Int = 0
    var ftype: Int = 0
    var id: Int = 0
    var mark: Int = 0
    var mvid: Int = 0
    var name: String?
    var rtype: Int = 0
    var rUrl: String?
    var status: Int = 0
    var transNames = [String]()
}

class SearchModelResultSongsAlbum: FDBaseModel {
    var artist: SearchModelResultSongsAlbumArtist?
    var copyrightId: Int = 0
    var id: Int = 0
    var mark: Int = 0
    var name: String?
    var picId: Int = 0
    var publishTime: Int = 0
    var size: Int = 0
    var status: Int = 0
}

class SearchModelResultSongsAlbumArtist: FDBaseModel {
    var albumSize: Int = 0
    var alias = [String]()
    var fansGroup: String?
    var id: Int = 0
    var img1v1: Int = 0
    var img1v1Url: String?
    var name: String?
    var picId: Int = 0
    var picUrl: String?
    var trans: String?
}

class SearchModelResultSongsArtists: FDBaseModel {
    var albumSize: Int = 0
    var alias = [String]()
    var fansGroup: String?
    var id: Int = 0
    var img1v1: Int = 0
    var img1v1Url: String?
    var name: String?
    var picId: Int = 0
    var picUrl: String?
    var trans: String?
}
