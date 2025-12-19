## DeclaredAgeRange Delphi Example

This is a Delphi 13 demo app showing how to use the DeclaredAgeRange API from iOS 26.0+

You'll also need **XCode 26.0** (or ideally 26.2) to build and run this demo.

**Note**
This app will only run on iOS, and is intended for use on iOS 26.0 or later.
It WILL run on iOS < 26 but as the DeclaredAgeRange API is iOS 26+ then it won't do anything useful.
To build this you'll need to be able to import iPhoneOS 26.x which is only available in XCode 26.x and I believe only available from MacOS Tahoe 26.x. Thanks Apple.

### How does this work?

Delphi can't natively use Swift-only frameworks. As Objective C is slowly being retired by Apple, most of the latest frameworks no longer support Objective C, so that causes a problem.
For example, WidgetKit and DeclaredAgeRange frameworks are Swift only.

**So how do we get these to work in a Delphi app?**

The trick is some native coding. I've created an Objective C native custom framework in XCode. This use the very helpful bridging support to allow the custom framework to access the swift library and call the necessary APIs.
The results of these are then exposed by the custom library as Objective C classes, which Delphi can then pick up.

Included in this sample is one such framework - DeclaredAgeRangeObjC.framework

The sources for this are here:

https://github.com/MyBuzzTechnologies/DeclaredAgeRangeObjC-API


### Running the App

To try the app, you'll need an Apple Developer account of your own, and you'll need to do the following:

1. Make sure you've imported iPhoneOS 26.0 or later. Ideally 26.2 as it contains extra properties that you'll need.

- In Delphi > Tools > Options > Deployment > SDK Manager, select the iOS Device 64-bit type on the left, then "Add...". Select iPhoneOS 26.x and import it

  > If you need more info on adding frameworks like this, see this excellent article from DelphiWorlds:
  > https://github.com/DelphiWorlds/HowTo/blob/main/Solutions/AddSDKFrameworks/ReadMe.md
  
2. Next, add 2 new frameworks that you'll need:

- Click the button in the top-right that looks like a page with a star on it to add a new framework.
- Add the following 2 frameworks:

Path on remote machine: **$(SDKRoot)/System/Library/Frameworks**

Framework Name: **Symbols**

Path Type: **Framework**

Path on remote machine: **$(SDKRoot)/System/Library/SubFrameworks**

Framework Name: **UIUtilities**

Path Type: **Framework**

> *You may also need to add _LocationEssentials (note the starting underscore). This is a Delphi 13 issue nothing to do with this demo specifically*

3. Add the Swift libraries as described in this article by Dave Nottage of DelphiWorlds:

https://github.com/DelphiWorlds/HowTo/blob/main/Solutions/AddSwiftSupport/Readme.md

> **It's really important you do the above correctly or the app won't build!**

Once you've set up your Delphi IDE, you need to set up your provisioning profile for the demo app.

4. Change the Bundle Identifier in the Delphi project options > Version options to something unique to you. Remember what this is as you'll need it again shortly.
5. Log into developer.apple.com
6. In https://developer.apple.com/account/resources/identifiers/list add a new app identifier with the same bundle ID. Assign the **"Declared Age Range"** capability and save.
7. In https://developer.apple.com/account/resources/profiles/list create a new developer profile for the new app and download it.
8. "Run" the downloaded provisioning file to import it into XCode
9. In your Delphi project, under the Project Options > Provisioning section of Delphi, explicitly select the new provision profile. DO NOT allow it to use a generic or generated one, only the one you created in step 4.

You should now be able to run the app.


**TIPS**

If the app crashes on open, it's likely a missing a framework. The best way to find out is the go onto the test device and download the crash log:

- Settings app > Privacy & Security > Analytics & Improvements > Analytics Data
- Scroll down the list and find the last entry with the name of your app and a date/time stamp.
- Option this and it should tell you what made it crash.

If the app runs but then crashes when you tap the CHECK button, then it may be due to the app not being able to find the custom framework.
In this case, it's really hard to debug as Delphi doesn't support debugging on iOS > 16.

If you have an iOS 15 or earlier device handy, I tend to use that for debugging in these cases as the crash should trigger in the IDE and it'll tell you what the problem is.
If not, you will need to run through the above instructions and make sure all the steps are correctly covered.


### Doing all this in your own app

If you want to try to import the custom framework from this demo app into your own Delphi app, you will need to follow all the instructions above *FIRST* to get your IDE, project and provisioning profiles set up.

After that, you will need to configure your Delphi project as follows:

- copy the **DeclaredAgeRangeObjC.framework** folder in it's entirety from this repo into a folder called "Frameworks" in your project folder
- To the "Frameworks Search Path" in the Delphi project settings, add
  ```
  .\Frameworks\DeclaredAgeRangeObjC.framework"
  ```

- To the Delphi Compiler > Linking > Options Passed to the LD Linker, add:
  ```
  -ObjC -rpath /usr/lib/swift -rpath @loader_path/Frameworks -weak_library /usr/lib/swift/libswift_StringProcessing.dylib -weak_library /usr/lib/swift/libswiftXPC.dylib
  ```

- Add the DeclaredAgeRangeObjC.framework folder and it's contents to your project Deployment files, making sure that the remote target directory is .\Frameworks\DeclaredAgeRangeObjC.framework

  **NOTE:** you need to keep everything in the same deployed folder structure as the source - i.e. everything goes into subfolders with the same name as the source.
  
  This is a pain to do manually, so I use DeployMan.exe from Grijjy which will save you a lot of time and errors
  https://github.com/grijjy/GrijjyDeployMan

And that should be all you need.

Try building and make sure it builds and links ok. If it can't find the required frameworks etc it will complain during Linking so you will be able to correct issues.


### Final Notes and Disclaimer

This project has been provided as an example of how to use Swift libraries in Delphi, specifically using the DeclaredAgeRange API to help you comply with the new Texas age verification laws.

Hopefully the instructions above are clear enough. However, I do NOT provide any warranty, guarantees or support on this code or how to implement it within your own apps.
The code MAY work with earlier versions of Delphi but this has not been tested nor will be. I always recommend using the latest version of Delphi is possible to ensure compatibility with the latest iOS and Android versions and features.

Also, I'm not a native Objective C developer, so there may be other/better ways to create or structure the framework.
I welcome suggestions for improved ways of doing this, but I'm no expert on the new Texas laws, the app requirements that come from it or the APIs themselves so please ask Gemini or Google if you have questions.

The enclosed framework and sample app are provided as-is, and unsupported so please use it purely for your own education or use without any warranty.

That's all from me. Good luck!🤞🏻
