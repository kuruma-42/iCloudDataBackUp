# iCloudDataBackUp
- iCloud를 이용한 데이터 백업

# 개발 동기 
- 데이터 회사에서 데이터는 자산이다. 기기를 옮길 때도 자산을 가지고 옮겨야하기 때문에 백업에 대한 요구가 많았다.
- fileManager로는 앱 하위의 디렉토리에 데이터를 저장하는 것은 가능했지만 디렉토리 외부에 데이터를 저장하는 것은 불가능했다. 
- 결국, 가장 private한 iCloud를 사용하자는 의견이 받아들여져 현재 테스트 코드이다.

# Important Point 
- fileManager를 쓰는 것은 그다지 큰 이슈는 아니었다. 
- 오히려 plist나 capability, developoer account에서 설정을 바꿔주는 것이 어려웠다
- 그 중에서도 plist를 바꾸는 것은 어려웠던 것 보다도 정보가 너무 없었다. 
```swift
<key>NSUbiquitousContainers</key>
	<dict>
		<key>iCloud.io.snplab.myd.backup</key>
		<dict>
			<key>NSUbiquitousContainerIsDocumentScopePublic</key>
			<true/>
			<key>NSUbiquitousContainerSupportedFolderLevels</key>
			<string>One</string>
			<key>NSUbiquitousContainerName</key>
			<string>MydBackUp</string>
		</dict>
	</dict>
```
- 상기의 코드를 plist를 텍스트 편집기를 열고 붙여야 iCloud에 드라이브를 만들고 또 보일 수 있게한다.
- 상기의 코드를 plist에 붙여도 iCloud Drive에 안 보인다면, Entitlement 쪽에 NSUbiquitousContainers에 관련된 Key가 생성되었는지 확인한한다.
- plist와 entitlement development account 쪽 Certificate & identifier 세팅이 잘 안 되면 iCloud Drive 쪽에 폴더가 노출이 안 된다.

# Test View 
<img src="https://user-images.githubusercontent.com/60722292/152463212-4c4ee13b-a326-4c6d-9797-8c19aa3de6e2.PNG" alt="iCloudDataBackUpPhoto" width="30%" height="30%"/></img>
- 상기의 사진에서 버튼을 누르면 네이티브 파일앱에서 데이터가 복사되고 옮겨지는 것을 확인할 수 있다.
- 다운 받아서 Xcode에서 실행해보면 log를 남겨놨으니 참고하면 좋을 것 같다. 

# 리뷰 
- 현재는 filemanager로 업로드 했을 때 용량이 꽉 찬 경우 어떻게 대응해야하는지를 찾고있다. 
- 다른 기기 또는 앱을 지우고 나서 데이터를 백업 클라우드 드라이브에 올려놨던 백업 데이터를 지우는 것은 쉽다.
- 하지만 데이터 백업만 하고 그 Zip파일이나 데이터 파일을 복사하거나 타인에게 뿌리는 행위가 생긴다면 
- 게임에서나 볼 수 있던 돈 복사 아이템 복사의 장이 될 수 있겠다는 생각을 했다. 
- 아마도 암호화나 보안이 엄청 필요해 보인다. 그렇지만 DID 기반의 회사에서 어떻게 유저가 앱을 지웠다 깔았는지 
- 기기만 다르고 같은 유저인지 판별하는 것은 어려울 것 같다. ( 유저의 신원 정보를 받지 않는 이상 ) 
- 좀 더 자세한 방법은 차후에 기술 블로그에 정리되면 기술 블로그를 링크하겠다.

