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
            Text("Hello, world!")
                .padding()
        }
        .onAppear {
//            cloudBackUpModel.makeDummyDataOnLocal()
            cloudBackUpModel.uploadDataAtCloud()
        }
    }

}

struct iCloudBackUpView_Previews: PreviewProvider {
    static var previews: some View {
        iCloudBackUpView()
    }
}
