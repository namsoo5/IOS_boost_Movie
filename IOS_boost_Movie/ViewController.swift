//
//  ViewController.swift
//  IOS_boost_Movie
//
//  Created by 남수김 on 10/03/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "예매율 순"
        
        //오른쪽 네비게이션바 아이템만들기
        //UIBarButtonItem(title: "선택", style: .plain , target: self, action: #selector(selectbtAction(_:)))
        let myrightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(sortMovie(_:))
        )
        
        self.navigationItem.rightBarButtonItem = myrightBarButtonItem
        

        
    }
    
    @objc func sortMovie(_ sender: UIBarButtonItem) -> Void {
        let alertController = UIAlertController(title: "정렬방식", message: "영화를 어떤순서로 하시겠습니까", preferredStyle: .actionSheet)
        
        let reservationAction = UIAlertAction(title: "예매율", style: .default, handler: { (UIAlertAction) in
            print("press reservation")
            })
        
        let qrationAction = UIAlertAction(title: "큐레이션", style: .default, handler: { (UIAlertAction) in
            print("press reservation")
        })
        
        let releaseAction = UIAlertAction(title: "개봉일", style: .default, handler: { (UIAlertAction) in
            print("press reservation")
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: { (UIAlertAction) in
            print("press reservation")
        })
        
        alertController.addAction(reservationAction)
        alertController.addAction(qrationAction)
        alertController.addAction(releaseAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: {
            print("alert shown")
        })

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //0일경우 예매율순
        guard let url: URL = URL(string:"http://connect-boxoffice.run.goorm.io/movies?order_type=0") else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //에러시
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            //json 받아오기
            do {
                let apiResponse: JsonResponse = try JSONDecoder().decode(JsonResponse.self, from: data)
                self.movies = apiResponse.movies
                
                //main스레드
                DispatchQueue.main.async {
                    self.tableView.reloadData() //메인에서 구현해야함
                }
                
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
        
        //dataTask 실행
        dataTask.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListTableViewCell
        
        let movie: Model = movies[indexPath.row]
        
        cell.movieTitleLabel.text = movie.title
        cell.movieInfoLabel.text = movie.info
        cell.movieDateLabel.text = movie.date
        //스크롤시 전이미지 안보이도록
        cell.movieAgeImage.image = nil
        cell.moiveImage.image = nil
        
        DispatchQueue.global().async { // 백그라운드 아무데서나 동작하는 기본적인것
            guard let imageURL: URL = URL(string: movie.thumb) else {
                return
            }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else {
                return
            }
            
            //스크롤시 이미지 인덱스안맞을수있음
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        
                        cell.moiveImage.image = UIImage(data: imageData)
                        
                        switch movie.grade {
                        case 0:
                            cell.movieAgeImage.image = UIImage(named: "ic_allages")
                        case 12:
                            cell.movieAgeImage.image = UIImage(named: "ic_12")
                        case 15:
                            cell.movieAgeImage.image = UIImage(named: "ic_15")
                        case 19:
                            cell.movieAgeImage.image = UIImage(named: "ic_19")
                        default:
                            cell.movieAgeImage.image = nil
                        }
                        
                    }
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movie"{
            guard let nextView: ContentViewController = segue.destination as? ContentViewController else { return }
            
            //해당(눌린)셀불러오기
            guard let cell: MovieListTableViewCell = sender as? MovieListTableViewCell else {
                return
            }

            nextView.movietitle = cell.movieTitleLabel.text
        }
        
    }
    
}

