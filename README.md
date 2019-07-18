# Flutter Boilerplate

My personal Flutter `lib` boilerplate, with following features:

- BLoC pattern with universal Provider widget
- Firebase Authentication for Google signin.
- User creation/fetching from Cloud Firestore

# How To

- Add these plugins to pubspec: `firebase_auth`, `google_sign_in`, `cloud_firestore`, `shared_preferences` and `rxdart`
- Rename package name in every import
- Configure `google_sign_in` plugin as in readme
- Create Firebase project and enable Google Authentication method + create Firestore database in test mode
