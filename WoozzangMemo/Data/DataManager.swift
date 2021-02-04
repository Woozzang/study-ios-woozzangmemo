//
//  DataManager.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/04.
//

import Foundation
import CoreData

class DataManager {
  
  static let shared = DataManager()
  private init() {}
  
  var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  var memoList = [Memo]()
  
  // iOS 에서는 DB 에서 data를 가져오는 것을 fetch라고 한다
  func fetchMemo() {
    let request: NSFetchRequest<Memo> = Memo.fetchRequest()
    
    let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
    
    request.sortDescriptors = [sortByDateDesc]
    
    do {
      memoList = try mainContext.fetch(request)
    } catch {
      print(error)
    }

  }
  
  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {

      let container = NSPersistentContainer(name: "WoozzangMemo")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}
