//
//  CreateNoteViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/01.
//

import UIKit

class CreateNoteViewController: UIViewController {
  @IBOutlet weak var memoTextView: UITextView!
  
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
  // MARK: - IBAction
  @IBAction func cancle(_ sender: Any) {
    dismiss(animated: true, completion: nil)
//    print(#function)
  }
  
  @IBAction func save(_ sender: Any) {
    guard let text = memoTextView.text, text.count > 0 else {
      alert(message: "메모를 입력하세요.")
      return
      
    }
//    Memo.dummyMemoList.append(Memo(content: text))
    
    NotificationCenter.default.post(name: CreateNoteViewController.newMemoDisInsert, object: nil)
    
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
  static let newMemoDisInsert = Notification.Name(rawValue: "newMemoDidInsert")
}
