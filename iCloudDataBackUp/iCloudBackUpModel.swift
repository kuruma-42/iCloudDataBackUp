//
//  iCloudBackUpModel.swift
//  iCloudDataBackUp
//
//  Created by Yong Jun Cha on 2022/02/03.
//

import Foundation

/// Mark: - iCloudBackUpModel
/// Feature: iCloud Drive에 데이터 백업을 위한 메소드들이 모여있는 클래스
class iCloudBackUpModel : ObservableObject {
    
    /// Mark: - uploadDataAtCloud
    /// Feature: FileManager를 사용하여 테스트데이터를 로컬 디렉토리 내부에 생성하고,
    /// 이 데이터를 iCloud Driver에 복사하는 function
    func uploadDataAtCloud() {
        
        // Set Local Docs URL Here
        let localDocsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        
        // Set File Name
        // * File이름을 계속 같게 해도, 가장 최근에 생성한 파일로 덮어쓴다.
        let localFile = localDocsURL.appendingPathComponent("Youtube_Keyword_data.txt")
        
        // Make Test Data Contents Here
        let testData = NSString(string: "KEYWORD TEST FILE")
        
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
            let iCloudFile = iCloudDocsURL.appendingPathComponent("Youtube_Keyword_data_\(Date()).txt")
            
            // Check File Path Exsits Or Not
            if !FileManager.default.fileExists(atPath: iCloudDocsURL.path, isDirectory: nil) {
                // Case File Path Doesn't Exist, Make Directory Here
                try? FileManager.default.createDirectory(at: iCloudDocsURL, withIntermediateDirectories: true, attributes: nil)
                print("DATA BACK UP :: CREATE iCLOUD DIRECTORY HERE")
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
}
