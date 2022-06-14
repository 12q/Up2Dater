# Up2Dater

[![CI Status](https://img.shields.io/travis/12q/Up2Dater.svg?style=flat)](https://travis-ci.org/12q/Up2Dater)
[![Version](https://img.shields.io/cocoapods/v/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)
[![License](https://img.shields.io/cocoapods/l/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)
[![Platform](https://img.shields.io/cocoapods/p/Up2Dater.svg?style=flat)](https://cocoapods.org/pods/Up2Dater)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Your App should be already present in the AppStore 

## Installation

Up2Dater is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Up2Dater'
```

## Usage
```
import Up2Dater

/// configure
func checkAvailableUpdate() {
    let service = Up2Dater()
    service.isNewVersionAvailable { result in
        switch result {
            case.success(let model):
                guard let version = model else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.presentUpdateAlert(for: version)
                }
            case .failure(let error):
                print(error.description)
        }
    }
}

/// present alert
func presentUpdateAlert(for newVersion: VersionModel) {
    let alertTitle = "version: \(newVersion.version) is available"
    let message = """
        Release Notes:
        \(newVersion.releaseNotes)
    """
    
    let alert = UIAlertController(
        title: alertTitle,
        message: message,
        preferredStyle: .alert
    )
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
        if let url = URL(string: newVersion.appStorePath) {
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
