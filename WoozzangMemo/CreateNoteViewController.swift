//
//  CreateNoteViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/01.
//

import UIKit

class CreateNoteViewController: UIViewController {
  
  var editTarget: Memo?
  
  @IBOutlet weak var memoTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let memo = editTarget {
      navigationItem.title = "Edit memo"
      memoTextView.text = memo.content
    } else {
      navigationItem.title = "New memo"
    }
    
    // Do any additional setup after loading the view.
  }
  // MARK: - IBAction
  @IBAction func cancle(_ sender: Any) {
    dismiss(animated: true, completion: nil)
//    print(#function)
  }
  
  @IBAction func save(_ sender: Any) {
    
    guard let memo = memoTextView.text, memo.count > 0 else {
      alert(message: "메모를 입력하세요.")
      return
    }
    
//    Memo.dummyMemoList.append(Memo(content: text))
    if let target = editTarget {
      target.content = memo
      DataManager.shared.saveContext()
      NotificationCenter.default.post(name: CreateNoteViewController.memoDidEdit, object: nil)
    } else {
      DataManager.shared.addNewMemo(memo)
      NotificationCenter.default.post(name: CreateNoteViewController.newMemoDidInsert, object: nil)
    }
    
    dismiss(animated: true, completion: nil)
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

extension CreateNoteViewController {
  
  static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
  static let memoDidEdit = Notification.Name("memoDidEdit")
}
