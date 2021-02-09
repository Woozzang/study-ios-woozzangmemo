//
//  DetailViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/03.
//

import UIKit

class DetailViewController: UIViewController {
  
  var memo: Memo?
  @IBOutlet weak var memoTableView: UITableView!
  var token: NSObjectProtocol?
  
  let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .long
    f.timeStyle = .short
    f.locale = Locale(identifier: "Ko_kr")
    return f
  }()
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination.children.first as? CreateNoteViewController {
      vc.editTarget = memo
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    token = NotificationCenter.default.addObserver(forName: CreateNoteViewController.memoDidEdit, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
      self?.memoTableView.reloadData()
    }
    // Do any additional setup after loading the view.
  }
  
  deinit {
    if let token = token {
      NotificationCenter.default.removeObserver(token)
    }
  }
  
  // MARK: IBActions
  @IBAction func deleteMemo(_ sender: Any) {
    let alert = UIAlertController(title: "경고", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
      DataManager.shared.deleteMemo(self?.memo)
      
      // 여기에서는 navigation controller 가 transition 을 담당하고 있기 때문이다.
      self?.navigationController?.popViewController(animated: true)
    }
    alert.addAction(okAction)
    
    let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(cancleAction)
    
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func share(_ sender: Any) {
    
    guard let memo = memo?.content else {return}
    
    let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
    
    present(vc, animated: true, completion: nil)
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
