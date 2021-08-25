# App for Object Detection, Voice Recognition, TTS using Flutter, TF Lite

## Install Flutter

```console
git clone https://github.com/flutter/flutter.git -b stable
cd flutter
flutter --version
flutter precache
```

## Install Cocoapods

```console
sudo gem install cocoapods
gem which cocoapods
```

## Check Flutter Environment

````console
flutter docter
```

## Set Up the App
```console
flutter packages get
````

## Install and Debug

open visual studio code  
install flutter plugin  
open visual_aid directory  
open lib/main.dart, click the run to install on iphone

## Command Line

```console
flutter build ios
flutter install
```

## iPhone Setup

Open ios/Runner.xcworkspace in XCode
Runner->Targets->Signing&Capabilities
Select your personal team
Change Bundle Indentifier to yours

## Accept the iPhone Developer Profile

General->Device Management->Accept developer
