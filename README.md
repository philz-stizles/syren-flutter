# syren

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

https://cloud.google.com > Console > 
    API Library > 
        Maps SDK for Android > Enable
        Map SDK for IOS > Enable
        Places API > Enable
    Credentials
        API Restrictions > Restrict key
            -   Maps SDK for Android
            -   Map SDK for IOS
            -   Places API

### Create Project

    mkdir syren
    cd syren
    flutter create .

### Run Project

    flutter run

### Adding a Launcher Icon

    flutter pub add flutter_launcher_icons

    flutter pub run flutter_launcher_icons

### Firebase

    rules_version = '2';
    // Allow users can only read and write their own data
    service cloud.firestore {
        match /databases/{database}/documents {
            // Make sure the uid of the requesting user matches name of the user
            // document. The wildcard expression {userId} makes the userId variable
            // available in rules.
            match /%collection%/{userId} {
                allow read, update, delete: if request.auth != null && request.auth.uid == userId;
                allow create: if request.auth != null;
            }
        }
    }

### Build

    flutter clean
    flutter pub get
    flutter build appbundle --release
