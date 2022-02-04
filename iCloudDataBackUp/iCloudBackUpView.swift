//
//  ContentView.swift
//  iCloudDataBackUp
//
//  Created by Yong Jun Cha on 2022/02/03.
//

import SwiftUI

struct iCloudBackUpView: View {
    @StateObject var cloudBackUpModel = iCloudBackUpModel()
    var body: some View {
        VStack{
            Text("데이터 백업 테스트")
                .padding()
            
            HStack{
                Button {
                    cloudBackUpModel.uploadDataAtCloud()
                } label: {
                    Rectangle()
                        .foregroundColor(Color.pink)
                        .cornerRadius(15)
                        .frame(width: 120, height: 60)
                        .overlay(
                            Text("데이터 백업하기")
                                .foregroundColor(Color.white)
                        )
                }
                
                Button {
                    cloudBackUpModel.getDataFromiCloud()
                } label: {
                    Rectangle()
                        .foregroundColor(Color.green)
                        .cornerRadius(15)
                        .frame(width: 120, height: 60)
                        .overlay(
                            Text("데이터 내려받기")
                                .foregroundColor(Color.white)
                        )
                }
                
                Button {
                    cloudBackUpModel.deleteCloudDataByFilePath()
                    cloudBackUpModel.deleteLocalDataByFilePath()
                } label: {
                    Rectangle()
                        .foregroundColor(Color.yellow)
                        .cornerRadius(15)
                        .frame(width: 120, height: 60)
                        .overlay(
                            Text("데이터 삭제하기")
                                .foregroundColor(Color.white)
                        )
                }
            }
        }
        .onAppear {
            cloudBackUpModel.checkIsUserUseiCloud()
        }
    }
    
}

struct iCloudBackUpView_Previews: PreviewProvider {
    static var previews: some View {
        iCloudBackUpView()
    }
}
