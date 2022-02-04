//
//  iCloudBackUpModel.swift
//  iCloudDataBackUp
//
//  Created by Yong Jun Cha on 2022/02/03.
//

import Foundation
import SwiftUI

/// Mark: - iCloudBackUpModel
/// Feature: iCloud Drive에 데이터 백업을 위한 메소드들이 모여있는 클래스
class iCloudBackUpModel : ObservableObject {
    fileprivate var TEST_DATA_FILE_NAME = "iCloud_BackUp_Data.txt"
    
    /// Mark: - uploadDataAtCloud
    /// Feature: FileManager를 사용하여 테스트데이터를 로컬 디렉토리 내부에 생성하고,
    /// 이 데이터를 iCloud Driver에 복사하는 function
    func uploadDataAtCloud() {
        
        // Set Local Docs URL Here
        let localDocsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        
        // Set File Name
        // * File이름을 계속 같게 해도, 가장 최근에 생성한 파일로 덮어쓴다.
        let localFile = localDocsURL.appendingPathComponent(TEST_DATA_FILE_NAME)
        
        // Make Test Data Contents Here
        let testData = NSString(string: "iCLOUD BACK UP TEST FILE")
        
        do {
            // Write Test Data Here
            try testData.write(to: localFile, atomically: true, encoding: String.Encoding.utf8.rawValue)
            print("DATA BACK UP :: MAKING TEST DATA SUCCESS")
        }
        catch let error as NSError {
            print("DATA BACK UP :: MAKING TEST DATA FAIL \(error)")
        }
        
        // Set iCloudDocsURL Here & Do Nil Check
        if let iCloudDocsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
            
            // Set File Name
            /* iCloud Driver에서는 파일 이름을 같게하면 동일명의 파일이 존재한다고 에러가 생기기 때문에
             * 이 곳에서는 파일명 뒤에 Date()를 붙여 파일명의 중복을 피한다.
             * 개발을 진행할 때도 이 상황을 항상 고려할 것.
             */
            let iCloudFile = iCloudDocsURL.appendingPathComponent(TEST_DATA_FILE_NAME)
            
            // Check File Path Exist Or Not
            if !FileManager.default.fileExists(atPath: iCloudDocsURL.path, isDirectory: nil) {
                // Case File Path Doesn't Exist, Make Directory Here
                try? FileManager.default.createDirectory(at: iCloudDocsURL, withIntermediateDirectories: true, attributes: nil)
                print("DATA BACK UP :: CREATE iCLOUD DIRECTORY")
            }
            do {
                // Copy Local Directory File Contents To iCloud Driver
                try FileManager.default.copyItem(at: localFile, to: iCloudFile)
                print("DATA BACK UP :: UPLOAD SUCCESS TO iCLOUD DRIVER")
            }
            catch let error as NSError {
                // Handling Exception Here When You Developing
                print("DATA BACK UP :: UPLOAD FAIL TO iCLOUD DRIVER \(error) ")
            }
        } else {
            // Handling Exception Here When You Developing
            print("DATA BACK UP :: iCLOUD URL IS NIL CHECK XCODE SETTING")
        }
    }
    
    
    /// Mark: - getDataFromiCloud
    /// Feature: iCloud Drive에서 데이터를 Local AppDirectory로 복사하는 function
    /// 경로가 없거나, 백업 데이터가 없으면 그에 따른 로그를 찍게 만들었으며
    /// 개발을 진행할 경우 저 곳에서 Alert를 띄워주거나 Exception Handling을 진행하면 되겠다.
    func getDataFromiCloud() {
        
        // Set iCloudDocsURL Here & Do Nil Check
        if let iCloudDocsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
            
            // Set File Name Which One We Will Download
            let iCloudFile = iCloudDocsURL.appendingPathComponent(TEST_DATA_FILE_NAME)
            
            // Check File Path Exist Or Not
            if !FileManager.default.fileExists(atPath: iCloudDocsURL.path, isDirectory: nil) {
                // Exception Handling
                // Alert Here
                print("DATA BACK UP :: FILE DOESN'T EXIST CHECK BACK UP DATA")
            } else {
                
                // Set Local Docs URL Here
                let localDocsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
                
                // Set File Name Which One Downloaded From iCloud Drive
                let localFile = localDocsURL.appendingPathComponent("\(TEST_DATA_FILE_NAME)_\(Date()).txt")
                
                do {
                    // Copy iCloud Drive Data To Local Directory File Contents
                    try FileManager.default.copyItem(at: iCloudFile, to: localFile)
                    print("DATA BACK UP :: GET BACK UP DATA SUCCESS")
                }
                catch let error as NSError {
                    // Handling Exception Here When You Developing
                    print("DATA BACK UP :: GET BACK UP DATA FAIL FROM iCLOUD DRIVER \(error.localizedDescription) ")
                }
            }
            
        } else {
            // Handling Exception Here When You Developing
            print("DATA BACK UP :: iCLOUD URL IS NIL CHECK XCODE SETTING")
        }
        
    }
    
    /// Mark: - deleteCloudDataByFilePath
    /// Feature: iCloud Drive에 있는 데이터를 지우는 function
    /// 데이터가 지워진다고 디렉토리가 사라지지 않는다.
    /// 테스트용으로 따로 따로 만들었지만, path만 받아서 재사용 가능하게 만들어도 괜찮을 것 같다.
    func deleteCloudDataByFilePath() {
        
        if let iCloudDocsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents"){
            let iCloudFile = iCloudDocsURL.appendingPathComponent(TEST_DATA_FILE_NAME)
            do {
                try FileManager.default.removeItem(at: iCloudFile)
                print("DATA BACK UP :: DELETE CLOUD DATA SUCCESS")
            }
            catch let error as NSError {
                print("DATA BACK UP :: DELETE CLOUD DATA FAIL \(error.localizedDescription)")
            }
        } else {
            // Handling Exception Here When You Developing
            print("DATA BACK UP :: iCLOUD URL IS NIL CHECK XCODE SETTING")
        }
    }
    
    /// Mark: - deleteLocalDataByFilePath
    /// Feature: Local App Directory 내부의 데이터를 지우는 function
    /// 데이터가 지워지면 디렉토리도 사라진다.
    /// 테스트용으로 따로 따로 만들었지만, path만 받아서 재사용 가능하게 만들어도 괜찮을 것 같다.
    func deleteLocalDataByFilePath() {
        
        // Set Local Docs URL Here
        let localDocsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!

        // Set File Name Which One Downloaded From iCloud Drive
        let localFile = localDocsURL.appendingPathComponent(TEST_DATA_FILE_NAME)
        
        do {
            try FileManager.default.removeItem(at: localFile)
            print("DATA BACK UP :: DELETE SUCCESS")
        }
        catch let error as NSError {
            print("DATA BACK UP :: DELETE DATA FAIL \(error.localizedDescription)")
        }
    }
    
    /// Mark: - checkIsUserUseiCloud
    /// - Returns: iCloud 경로가 있는지 없는지에 대한 Bool 값
    /// Feature: 코드랩 하면서 여러가지 자료들을 찾아봤는데 백업을 시도하는 많은 사람들이
    /// 경로의 유무로 iCloud drive를 사용하고 있는지 아닌지로 체크를 했다.
    /// 로직이 실행되기 전에 이 Function을 사용하면 될 것 같다.
    /// Test Result : iCloud Drive를 활성화 했는지, 안 했는지 테스트를 해봤는데
    /// 유저가 비활성화를 하면 Path가 없는 것으로 나오고
    /// 유저가 활성화를 하면 Path가 있는 것으로 나와서 현재로서는 유저의 활성화 여부를 알 수 있는 유일한 방법이다.
    /// 로직이 시작하기 전에 메소드로 체크하고 시작하면 될 것 같다.
    func checkIsUserUseiCloud() -> Bool {
        if let iCloudDocsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
            print("DATA BACK UP :: USER USE iCLOUD DRIVE, HAVE A PATH")
            return true
        } else {
            print("DATA BACK UP :: USER DOES NOT USE iCLOUD DRIVE NO CLOUD PATH")
            return false
        }
    }
}
