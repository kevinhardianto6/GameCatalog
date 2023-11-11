//
//  GameProvider.swift
//  Catalog
//
//  Created by Kevin Hardianto on 11/10/22.
//

import CoreData
import RxSwift

protocol GameProviderProtocol {
  func checkGameExistOnFavourite(gameId: Int) -> Observable<Bool>
  func getAllFavouriteGames() -> Observable<[GameEntity]>
  func addFavouriteGame(game: GameModel) -> Observable<Bool>
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool>
  func deleteAllFavouriteGames() -> Observable<Bool>
}

final class GameProvider: NSObject {
  static let sharedInstance = GameProvider()
  
  lazy var persistentContainer: NSPersistentContainer = {
    if let bundle = Bundle(identifier: CoreBundle.getIdentifier()), let managedObjectModel = NSManagedObjectModel(contentsOf: bundle.url(forResource: "FavouriteGames", withExtension: "momd")!) {
      let container = NSPersistentContainer(name: "FavouriteGames", managedObjectModel: managedObjectModel)
      
      container.loadPersistentStores { _, error in
        guard error == nil else {
          fatalError("Unresolved error \(error!)")
        }
      }
      container.viewContext.automaticallyMergesChangesFromParent = false
      container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      container.viewContext.shouldDeleteInaccessibleFaults = true
      container.viewContext.undoManager = nil
      
      return container
    } else {
      let container = NSPersistentContainer(name: "FavouriteGames")
      
      container.loadPersistentStores { _, error in
        guard error == nil else {
          fatalError("Unresolved error \(error!)")
        }
      }
      container.viewContext.automaticallyMergesChangesFromParent = false
      container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      container.viewContext.shouldDeleteInaccessibleFaults = true
      container.viewContext.undoManager = nil
      
      return container
    }
  }()
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  private func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteGames")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastMember = try taskContext.fetch(fetchRequest)
        if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int {
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        Logger.printLog(error.localizedDescription)
      }
    }
  }
}

extension GameProvider: GameProviderProtocol {
  func getAllFavouriteGames() -> Observable<[GameEntity]> {
    return Observable<[GameEntity]>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.performAndWait {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteGames")
        do {
          let results = try taskContext.fetch(fetchRequest)
          var games: [GameEntity] = []
          for result in results {
            let game = GameEntity(
              id: result.value(forKeyPath: "id") as? Int,
              gameId: result.value(forKeyPath: "gameId") as? Int,
              name: result.value(forKeyPath: "name") as? String,
              released: result.value(forKeyPath: "released") as? String,
              backgroundImage: result.value(forKeyPath: "image") as? String,
              rating: result.value(forKeyPath: "rating") as? Double,
              ratingTop: result.value(forKeyPath: "ratingTop") as? Int
            )
            
            games.append(game)
          }
          observer.onNext(games)
          observer.onCompleted()
        } catch let error as NSError {
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  func addFavouriteGame(game: GameModel) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.performAndWait {
        if let entity = NSEntityDescription.entity(forEntityName: "FavouriteGames", in: taskContext) {
          let gameData = NSManagedObject(entity: entity, insertInto: taskContext)
          self.getMaxId { id in
            gameData.setValue(id+1, forKeyPath: "id")
            gameData.setValue(game.id, forKeyPath: "gameId")
            gameData.setValue(game.name, forKeyPath: "name")
            gameData.setValue(game.released, forKeyPath: "released")
            gameData.setValue(game.backgroundImage, forKeyPath: "image")
            gameData.setValue(game.rating, forKeyPath: "rating")
            gameData.setValue(game.ratingTop, forKeyPath: "ratingTop")
            
            do {
              try taskContext.save()
              observer.onNext(true)
              observer.onCompleted()
            } catch let error as NSError {
              observer.onError(error)
            }
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func checkGameExistOnFavourite(gameId: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteGames")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
      
      taskContext.performAndWait {
        do {
          let count = try taskContext.count(for: fetchRequest)
          if count > 0 {
            observer.onNext(true)
          } else {
            observer.onNext(false)
          }
          observer.onCompleted()
        } catch let error as NSError {
          observer.onNext(false)
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  func deleteFavouriteGame(gameId: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteGames")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "gameId == \(gameId)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            observer.onNext(true)
            observer.onCompleted()
          }
        }
      }
      return Disposables.create()
    }
  }
  
  func deleteAllFavouriteGames() -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteGames")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
          if batchDeleteResult.result != nil {
            observer.onNext(true)
            observer.onCompleted()
          }
        }
      }
      return Disposables.create()
    }
  }
}
