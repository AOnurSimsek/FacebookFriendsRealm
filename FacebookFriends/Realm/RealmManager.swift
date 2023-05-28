//
//  RealmManager.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 28.05.2023.
//

import Foundation
import RealmSwift

enum RealmOperationTypes {
    case read
    case write
    case update
}

final class RealmManager {
    private var realmModel: RealmAllUsersModel?
    
    init() { }
    
    func hasRealmModel(userName: String) -> Bool {
        let realm = try! Realm()
        let userModel = realm.objects(RealmAllUsersModel.self)
        let filteredUserModel = userModel.where {
            $0.userName == userName
        }
        realmModel = filteredUserModel.first
        
        return !filteredUserModel.isEmpty
    }
    
    func getUsersData() -> [UserResponseModel]? {
        guard let stringData = realmModel?.allUsersData
        else { return nil }
        
        let data = stringData.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let userData = try decoder.decode([UserResponseModel]?.self, from: data)
            return userData
        } catch {
            return nil
        }
        
    }
    
    func addRealmModel(userName: String,
                       userModels: [UserResponseModel],
                       operationType: RealmOperationTypes) {
        let encoder = JSONEncoder()
        do {
            let userModelsData = try encoder.encode(userModels)
            guard let userModelsString = String(data: userModelsData,
                                                encoding: .utf8)
            else { return }
            
            switch operationType {
            case .write:
                let model = RealmAllUsersModel()
                model.allUsersData = userModelsString
                model.userName = userName
                writeRealmData(data: model)
                
            case .update:
                guard let _ = realmModel
                else { return }
                
                updateRealmData(usersString: userModelsString)
                
            default:
                return
            }
            
        } catch {
            print("Error at addRealmModel")
        }
        
    }
    
    private func writeRealmData(data: RealmAllUsersModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error at writeRealmData")
        }
        
    }
    
    private func updateRealmData(usersString: String) {
        do {
            let realm = try Realm()
            try realm.write {
                realmModel?.allUsersData = usersString
            }
        } catch {
            print("Error at updateRealmData")
        }
        
    }
    
}
