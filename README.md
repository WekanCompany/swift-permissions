#  iOS permissions #

A sample in swift to get system permissions for various features


## Usage example ##

### Import pod frameworks ###

* Add [SPPermissions](https://github.com/ivanvorobei/SPPermissions) to pod file
````
pod 'SPPermissions'
````

* Add pod for the respective permissions the app needs

````
pod 'SPPermissions'
pod 'SPPermissions/Camera'
pod 'SPPermissions/Location'
pod 'SPPermissions/Microphone'
pod 'SPPermissions/Contacts'
pod 'SPPermissions/Calendar'
pod 'SPPermissions/PhotoLibrary'
pod 'SPPermissions/Notification'
pod 'SPPermissions/Microphone'
pod 'SPPermissions/Reminders'
pod 'SPPermissions/SpeechRecognizer'
pod 'SPPermissions/Location'
pod 'SPPermissions/Motion'
pod 'SPPermissions/MediaLibrary'
pod 'SPPermissions/Bluetooth'
````

### Add to Info.plist ###

* Open Info.plist as source code. From the below list of various permissions, add whatever permissions the app needs.
````
    <key>NSAppleMusicUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSCalendarsUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSCameraUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSContactsUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSHomeKitUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSLocationUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSMotionUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSRemindersUsageDescription</key>
    <string>Example Describtion</string>
    <key>NSSpeechRecognitionUsageDescription</key>
    <string>Example Describtion</string>
````
    
* Replace Example Description with the appropriate information on the usage of those permissions in your app.
    
### Code in ViewController ###

Have a viewcontroller to select the list of permissions the user requires

* Import framework
````
import SPPermissions
````
* Request permissions

````
var selectedPermissions: [SPPermission] = []
````

The selectedPermissions array should have the permissions that we need to request
````
selectedPermissionsr = [.calendar, .camera, .contacts]
````
Requesting permissions using native alerts
````
func requestPermissions() {
    if selectedPermissions.isEmpty { return }
    let controller = SPPermissions.native(selectedPermissions)
    controller.delegate = self
    controller.present(on: self)
 }
 ````
 
 To check the state of any permission, call ````enum SPPermission````:
````
let state = SPPermission.calendar.isAuthorized
````
Also available is the func ```` isDenied````. This returns false if the permission has not been requested before.


### DataSource & Delegate

* Datasource
For a customized permissions view, implement ````SPPermissionsDataSource````:

````
extension ViewController: SPPermissionsDataSource {
  func configure(_ cell: SPPermissionTableViewCell, for permission: SPPermission) -> SPPermissionTableViewCell {
    return cell
  }
}
````

Using a delegate, you can customize texts, colors, and icons. For a default view configure with the default values. After configuration return the cell.

You can customize:

````
// Titles
cell.permissionTitleLabel.text = "Notifications"
cell.permissionDescriptionLabel.text = "Remind about payment to your bank"
cell.button.allowTitle = "Allow"
cell.button.allowedTitle = "Allowed"

// Colors
cell.iconView.color = .systemBlue
cell.button.allowedBackgroundColor = .systemBlue
cell.button.allowTitleColor = .systemBlue

// If you want set custom image.
cell.set(UIImage(named: "IMAGE-NAME")!)
````
* Delegate

In the delegate, you can implement ```` SPPermissionsDelegate```` with these optional methods:

````
// Events
func didAllow(permission: SPPermission) {}
func didDenied(permission: SPPermission) {}
func didHide(permissions ids: [Int])

// Denied alert. Show alert if permission denied.
func deniedData(for permission: SPPermission) -> SPPermissionDeniedAlertData?
````
You can detect permission values as follows:
````
let permissions = ids.map { SPPermission(rawValue: $0) }
````

Denied alert

If you don't want show an alert if a permission is denied, return nil in the delegate. You can set the text in the alert:
````
func deniedData(for permission: SPPermission) -> SPPermissionDeniedAlertData? {
    if permission == .notification {
        let data = SPPermissionDeniedAlertData()
        data.alertOpenSettingsDeniedPermissionTitle = "Permission denied"
        data.alertOpenSettingsDeniedPermissionDescription = "Please, go to Settings and allow permission."
        data.alertOpenSettingsDeniedPermissionButtonTitle = "Settings"
        data.alertOpenSettingsDeniedPermissionCancelTitle = "Cancel"
        return data
    } else {
        // If returned nil, alert will not show.
        return nil
    }
}
````
If you don't implement this method, the alert will appear with default text. To disable the alert you just need return nil.

### Good Practices

I recommend that you show the user all of the permission options, even if some of them are already allowed. But if you want to request only non-allowed permissions, use this code:
````
let controller = SPPermissions.list([.notification, .reminders].filter { !$0.isAuthorized } )
controller.present(on: self)
````
A good way to check for the need to show a dialog: check that all permissions are currently authorized by the user:
````
let permissions = [.notification, .reminders].filter { !$0.isAuthorized }
if permissions.isEmpty {
    // No need show dialog
} else {
    // Show dialog
}
````
If you request location services, you can show both .locationWhenInUse & .locationAlwaysAndWhenInUse. If the user allowed always mode, they can also change to when in use mode:
````
let controller = SPPermissions.dialog([.locationWhenInUse, .locationAlwaysAndWhenInUse])
controller.present(on: self)
````


