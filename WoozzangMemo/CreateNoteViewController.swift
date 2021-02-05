//
//  CreateNoteViewController.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/01.
//

import UIKit

class CreateNoteViewController: UIViewController {
  
  var editTarget: Memo?
  var originalMemoContent: String?
  
  @IBOutlet weak var memoTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let memo = editTarget {
      navigationItem.title = "Edit memo"
      memoTextView.text = memo.content
      originalMemoContent = memo.content
    } else {
      navigationItem.title = "New memo"
    }
    
    memoTextView.delegate = self
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.presentationController?.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.presentationController?.delegate = nil
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

extension CreateNoteViewController: UITextViewDelegate {
  /* 텍스트뷰를 편집할 때마다 반복적으로 호출*/
  func textViewDidChange(_ textView: UITextView) {
    if let original = originalMemoContent, let edited = textView.text {
      isModalInPresentation = original != edited
    }
  }
}

extension CreateNoteViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
    let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
      self?.save(action)
    }
    alert.addAction(okAction)
    
    let cancleAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] (action) in
      self?.cancle(action)
    }
    alert.addAction(cancleAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
    print(#function)
  }
}

extension CreateNoteViewController {
  
  static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
  static let memoDidEdit = Notification.Name("memoDidEdit")
}
