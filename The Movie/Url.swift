//
//  Url.swift
//  The Movie
//
//  Created by elfakharany on 7/9/19.
//  Copyright © 2019 Mohamed Elfakharany. All rights reserved.
//

import Foundation
struct Urls {
    
let imageurl = "https://image.tmdb.org/t/p/w185//7IiTTgloJzvGI1TAYymCfbfl3vT.jpg?api_key=a619ffd371a3fc63c02faefe0478df7d"

static let BaseUrl = "http://api.themoviedb.org/3/"
static let api_key = "?api_key=a619ffd371a3fc63c02faefe0478df7d"
static let TopRated = BaseUrl + "movie/top_rated" + api_key + "&page="
static let GetToken = BaseUrl + "authentication/token/new" + api_key
static let loginUrl    =  BaseUrl + "authentication/token/validate_with_login" + api_key + "&request_token="

}
