//
//  MovieRequest.swift
//  IOS_boost_Movie
//
//  Created by 남수김 on 10/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//


/*
 movies: [
 {
 date: "2017-12-20",
 user_rating: 7.98,
 grade: 12,
 thumb: "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg?type=m99_141_2",
 title: "신과함께-죄와벌",
 reservation_rate: 35.5,
 reservation_grade: 1,
 id: "5a54c286e8a71d136fb5378e"
 },
 }
 */
import Foundation

struct JsonResponse: Codable {
    let movies: [Model]
}

struct Model: Codable {

    let date: String
    let userRating: Float
    let grade: Int
    let thumb: String
    let title: String
    let reservationRate: Float
    let reservationGrade: Int
    let id: String
    
    enum CodingKeys: String, CodingKey{
        case date
        case userRating = "user_rating"
        case grade, thumb, title
        case reservationRate = "reservation_rate"
        case reservationGrade = "reservation_grade"
        case id
    }
    
    var info: String {
        return
            "평점: \(self.userRating) 예매순위: \(self.reservationGrade) 예매율: \(self.reservationRate)"
    }

}
