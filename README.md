# Barkoder Flutter

Flutter demo app showcases Barkoder's barcode scanner, featuring a full suite of barcode scanning capabilities with customizable template settings

## Prerequisites

Flutter is Google's SDK for crafting beautiful, fast user experiences for mobile, web, and desktop from a single codebase. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.

### Text Editor or IDE
Choose a text editor or integrated development environment (IDE) for coding. Recommended options include:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Sublime Text](https://www.sublimetext.com/)
 
Install [Git for version control](https://git-scm.com/) and project management. Git will help you track changes and collaborate with others on the project.

### Command Line Interface (CLI)

Ensure you have a command line interface (CLI) installed and accessible, as Cordova commands are executed via the command line. Popular options include:

- Terminal (macOS/Linux)
- Command Prompt (Windows)
- PowerShell (Windows)

iOS Development: Install [Xcode](https://developer.apple.com/xcode/) (macOS only) for iOS development. Xcode provides the necessary tools and emulators for testing your app on iOS devices.

Android Development: Install [Android Studio](https://developer.android.com/studio) for Android development. Android Studio includes the Android SDK and an emulator for testing your app on Android devices.

## Flutter requirements

### Installation and setup

Depending on the platform you plan to use, this will be different for your use-case, however, flutter covers all major platforms and the installation is pretty straight forward.

Install [Flutter SDK](https://docs.flutter.dev/get-started/install) and follow the [Set up an editor](https://docs.flutter.dev/get-started/editor?tab=vscode) instructions to install the Dart and Flutter extensions (also called plugins).

### Creating a new project

To create a new Flutter project from the Flutter starter app template:

- Go to `View` > `Command Palette...` (You can also press `Ctrl` / `Cmd` + `Shift` + `P`)
- Type `flutter`.
- Select the **Flutter: New Project**.
- Press `Enter`.
- Select **Application**.
- Press `Enter`.
- Select a **Project location**.
- Enter your desired **Project name**.

## barKoder Barcode Scanner SDK plugin for Flutter

Integrating the barKoder SDK with the Flutter platform is a straightforward and seamless process, designed to empower developers with powerful barcode scanning capabilities in their cross-platform mobile applications. To begin, simply add the barKoder SDK as a dependency in your Flutter project's pubspec.yaml file. Once the dependency is added, developers can access a range of easy-to-use widgets and APIs offered by the SDK. To implement barcode scanning functionalities, developers can utilize the BarkoderScanView widget, which provides a native camera view for scanning barcodes. With just a few lines of code, you can configure the widget to enable different barcode types, customize UI elements, and set scanning options to suit your specific application requirements. The SDK efficiently handles barcode recognition, instantly returning accurate results upon successful scans.

Whether you're building an inventory management app or a retail application, the barKoder SDK integration with Flutter streamlines the process, enabling you to create a seamless and native-feeling barcode scanning experience for both Android and iOS users.

### Add our flutter package

There are multiple ways to add the barkoder_flutter package to your Flutter project  (or we should say, at least for now, two ways):

1. To use the **barkoder_flutter** package in your Flutter project, you have two options: using the **barkoder_flutter** package from [pub.dev](https://pub.dev/packages/barkoder_flutter);
2. Referencing it from a local path.

To use the package from [pub.dev](https://pub.dev/packages/barkoder_flutter), add the package name and version to your project's dependencies:

```
dependencies:
    flutter:
      sdk: flutter
   barkoder_flutter: <package version>
```

If you prefer to use a local package, download the package from https://barkoder.com and set the package path in your project's dependencies:

```
dependencies:
      flutter:
        sdk: flutter
        barkoder_flutter:
        path: <package local path>
```

### Install dependencies

To install the specified dependencies in your Flutter project, run the following command in the terminal:

```
flutter pub get
```

This command will fetch and install the required dependencies for your project.

In the demo app we also used the following dependencies:

```
url_launcher: ^6.1.8
shared_preferences: ^2.0.0
share_plus: ^10.0.0
cupertino_icons: ^1.0.6
```

### Import package

Import the barkoder_flutter package in your project with:

```
import 'package:barkoder_flutter/barkoder_flutter.dart';
```

### BarkoderView

At this stage, assuming that the barkoder_flutter package is installed and imported into your project, you can proceed to add the BarkoderView widget to your layout. Make sure to set the licenseKey parameter and the onBarkoderViewCreated callback. Here's an example of how to accomplish this:

```
@override
Widget build(BuildContext context) {
    return Scaffold(
    //...,
    body: BarkoderView(
                licenseKey: 'KEY',
                onBarkoderViewCreated: _onBarkoderViewCreated),
    //...
    );
```

The license key is a string composed of alphanumeric characters, meaning it can contain both letters (A-Z, a-z) and numbers (0-9). See section Licensing to learn how to get a valid license.

### Ready to Scan Event

Inside the _onBarkoderViewCreated callback function the SDK is fully initialized and ready for configuration or to start the scanning process

```
void _onBarkoderViewCreated(barkoder) {
    _barkoder = barkoder;
    _barkoder.setBarcodeTypeEnabled(BarcodeType.qr, true);
    _barkoder.setRegionOfInterestVisible(true);

    //... add other code here
}
void _scanPressed() {
    _barkoder.startScanning((result) {
    // The result from successful scan is received here
    });
} 
```

For the complete usage of the barkoder_flutter plugin please check our demo app.

### Make sure you have the necessary permissions, such as camera

permissions, configured in your app for the barcode scanner to function
properly. 

1. For Android, the permission is set in the manifest from the plugin. Here's an example of how to add the camera permission:

- Open the AndroidManifest.xml file located in the **android/app/src/main** directory of your Flutter project.
- Locate the <**manifest**> tag and add the following permission declaration inside it:

```
uses-permission android:name="android.permission.CAMERA" />
```

2. For iOS you need to specify camera permission in Info.plist file inside your project

```
<key>NSCameraUsageDescription</key>
<string>Camera permission</string>
```

### Minimum SDK

The plugin requires a minimum SDK version of 21, but if your Flutter project's Android SDK version is set to 20 or lower, you'll need to update the minSdkVersion in your build.gradle file to at least 21:

```
android {
	compileSdkVersion 33

	defaultConfig {
	    applicationId "com.example.my_flutter_app"
	    minSdkVersion 21  // Updated to 21
	    targetSdkVersion 33
	    versionCode 1
	    versionName "1.0"
	
	    multiDexEnabled true
	}
	
	...
}
```

### Run the App

Run your Flutter app using `flutter run`.

## Demo App

Barcode Scanner by barKoder showcases the enterprise-grade performance of the barKoder Barcode Scanner SDK along with most of its features in a wide variety of scanning scenarios.

Wheter from 1D or 2D barcodes, the barKoder API can capture the data reliably, accurately and suprisingly fast, even under very challnging conditions and environments.

You can test the barKoder Barcode Scanner SDK at your convenience by signing up for a free trial

### Barcode types

#### 1D Barcodes:
```
BarcodeType.code93,
BarcodeType.code39,
BarcodeType.codabar,
BarcodeType.code11,
BarcodeType.upcA,
BarcodeType.upcE,
BarcodeType.ean13,
BarcodeType.ean8,
BarcodeType.code25,
BarcodeType.interleaved25,
BarcodeType.itf14,
BarcodeType.telepen,
```

#### 2D Barcodes:
```
BarcodeType.aztec,
BarcodeType.aztecCompact,
BarcodeType.qr,
BarcodeType.qrMicro,
BarcodeType.datamatrix,
BarcodeType.pdf417,
BarcodeType.pdf417Micro,
BarcodeType.dotcode,
```

### Flutter - barKoder API Reference

#### Decoding Speed

Sets the decoding speed for barcode scanning.

Example usage:

```
DecodingSpeed speed = DecodingSpeed.fast;
_barkoder.setDecodingSpeed(speed);
print('Decoding speed set to:$speed');
```

#### barKoder Resolution

Sets the resolution for barcode scanning.

Example usage:

```
BarkoderResolution resolution = BarkoderResolution.HIGH;
await _barkoder.setBarkoderResolution(resolution);
print('Barkoder resolution set to:$resolution');
```

#### Continuous Scanning

To add continuous scanning we need to disable close session on result and image result:

```
_barkoder.setCloseSessionOnResultEnabled(false);
_barkoder.setImageResultEnabled(false);
```

#### Continuous Threshold

Sets the threshold between duplicate scans.

```
int threshold = 1;// 100 milliseconds
_barkoder.setThresholdBetweenDuplicatesScans(threshold);
print('Threshold between duplicate scans set to:$threshold milliseconds');
```

#### Allow pinch to zoom

Sets whether pinch to zoom is enabled.

Example usage:

```
bool pinchToZoomEnabled = true;
_barkoder.setPinchToZoomEnabled(pinchToZoomEnabled);
print('Pinch to zoom enabled:$pinchToZoomEnabled');
```

#### Beep on success

Enables or disables the audible beep sound upon successfully decoding a barcode.

Example usage:

```
bool beepOnSuccessEnabled = true;
await _barkoder.setBeepOnSuccessEnabled(beepOnSuccessEnabled);
print('Beep on success enabled:$beepOnSuccessEnabled');
```

#### Vibrate on success

Enables or disables the device vibration upon successfully decoding a barcode.

Example usage:

```
bool vibrateOnSuccessEnabled = true;
await _barkoder.setVibrateOnSuccessEnabled(vibrateOnSuccessEnabled);
print('Vibrate on success enabled:$vibrateOnSuccessEnabled');
```

#### Scan Deformed Codes - Segment Decoding

Sets whether the detection of misshaped 1D barcodes is enabled

```
Future<void> setEnableMisshaped1DEnabled(bool enabled)
```

#### Scan blurred UPC/EAN

Sets whether the deblurring feature for UPC/EAN barcodes is enabled

Example usage:

```
bool isEnabled =true;
await _barkoder.setUpcEanDeblurEnabled(isEnabled);
print('UPC/EAN deblur enabled set to:$isEnabled');
```

#### Formatting Type

Sets the formatting type for barcode scanning.

Example usage:

```
FormattingType type = FormattingType.gs1;
_barkoder.setFormattingType(type);
print('Formatting type set to:$type');
```

#### Charset

Sets the encoding character set for barcode scanning

Example usage:

```
String characterSet = 'utf-8';
_barkoder.setEncodingCharacterSet(characterSet);
print('Encoding character set set to:$characterSet');
```

#### Region of Interest

Sets the visibility of the Region of Interest (ROI) on the camera preview.

Example usage:

```
bool roiVisible =true;
await _barkoder.setRegionOfInterestVisible(roiVisible);
print('Region of interest set to visible:$roiVisible');
```

## Licensing

The mobile barcode reader SDK by barKoder is designed to allow barcode scanning even without a valid license. However, to maintain security and privacy, all scanning results are obfuscated with (*) asterisk characters. In order to alleviate that you can either get a trial license (to test the software out) or procure a production license that can be used within a production app.
