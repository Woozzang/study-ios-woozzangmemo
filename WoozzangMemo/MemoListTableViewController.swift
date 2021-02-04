//
//  MemoListTableViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/01/30.
//

import UIKit

class MemoListTableViewController: UITableViewController {
  
  let formatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .long
    f.timeStyle = .short
    f.locale = Locale(identifier: "Ko_kr")
    return f
  }()
  
  //Notication.default.addObserver 의 반환 타입이 Optional 이 아닌데 옵셔널 타입으로 받는 이유
  // 기존 타입으로 받으면 initializer 를 구현해야 한다
  // token이 런타임에 할당된다
  
  var token: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    token = NotificationCenter.default.addObserver(forName: CreateNoteViewController.newMemoDisInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
      self?.tableView.reloadData()
    }
    
  //    print(#function)
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  deinit {
    if let token = token {
      NotificationCenter.default.removeObserver(token)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    DataManager.shared.fetchMemo()
    tableView.reloadData()
  }
  // MARK: - Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
      if let vc = segue.destination as? DetailViewController {
        vc.memo = DataManager.shared.memoList[indexPath.row]
      }
    }
  }
  
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
    return DataManager.shared.memoList.count
  }

  // 개별 셀을 화면에 표시할때마다 반복적으로 호출
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // 1. 사용할 셀 디자인 가져오기
    let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
    
    // 2. 셀 내용 채우기
    let target = DataManager.shared.memoList[indexPath.row]
    
    cell.textLabel?.text = target.content
    cell.detailTextLabel?.text = formatter.string(for:target.insertDate)

    return cell
  }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
