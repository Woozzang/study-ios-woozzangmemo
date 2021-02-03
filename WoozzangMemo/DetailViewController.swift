//
//  DetailViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/03.
//

import UIKit

class DetailViewController: UIViewController {
  
  var memo: Memo?
  
  let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .long
    f.timeStyle = .short
    f.locale = Locale(identifier: "Ko_kr")
    return f
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      // Do any additional setup after loading the view.
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}

extension DetailViewController: UITableViewDataSource {
  
  /* 테이블 뷰가 표시할 셀 숫자를 물어볼 때 호출*/
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  /* 테이블 뷰가 어떤 셀을 표시할 지 물어볼 때 호출*/
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
      
      cell.textLabel?.text = memo?.content
      return cell
    
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
      
      cell.textLabel?.text = formatter.string(for: memo?.insertDate)
      
      return cell
      
    default:
      fatalError()
    }
  }
  
  
}
