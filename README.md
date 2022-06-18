# Up2Dater

[![Version](https://img.shields.io/cocoapods/v/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)
[![License](https://img.shields.io/cocoapods/l/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)
[![Platform](https://img.shields.io/cocoapods/p/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)

## Requirements

Your App should be already present in the AppStore 

## Installation

Up2Dater is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Up2Dater'
```

## Usage
```swift
import Up2Dater

    func checkNewVersion() {
        let versionManager = AppStoreVersionManager()
        versionManager.checkNewVersionAfter { [weak self] result in
            switch result {
                case .success(let version):
                    guard let version = version else { return }
                    self?.presentUpdateAlert(for: version)
                case .failure(let error):
                    Logger.log(error.description)
            }
        }
    }
    
    func presentUpdateAlert(for appStoreVersion: AppStoreVersion) {
        let alertTitle = "Version: \(appStoreVersion.version) is available"
        let message = """
            Release Notes:
            \(appStoreVersion.releaseNotes)
        """
        let alert = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] _ in
            self?.versionManager.setSkipVersion(appStoreVersion.version)
        }
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            if let url = URL(string: appStoreVersion.appStorePath) {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(updateAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
```
that's all 🙂

## Author

Slava Plisco, observleer@gmail.com

## License

Up2Dater is available under the MIT license. See the LICENSE file for more info.
