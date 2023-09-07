# NIU

A Flutter home task challenge.

## Getting Started

This application is written in flutter and displays a welcome screen with sign in feature.

## How to Use

**Step 1:**

Install flutter environment in your local.
follow this link for install environment for flutter.

```
https://docs.flutter.dev/get-started/install
```

**Step 2:**

Go to the project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

Then, run the app with executing the following command

```
flutter run
```

## Project Features

1. The login screen has email and password fields, and a login button.
2. The application uses Riverpod for state management and manages the authentication state.
3. Upon tapping the Login button, the email and password fields are validated. If validation fails, appropriate error messages are displayed.
4. If validation passes, a network request is mocked to authenticate the user using `Future.delayed`.
5. If authentication is successful, the state is updated to indicate that the user is logged in, and the user is navigated to the welcome screen.
6. If authentication fails, an error message is displayed.

## Bonus Features

1. The application uses a form widget for input validation.
2. A loading indicator is displayed during the authentication process.
3. Logout functionality is implemented.

### Folder Structure

Here is the core folder structure which flutter provides.

```
user_authentication_flutter_riverpod/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- components/
|- constants/
|- model/
|- provider/
|- screens/
|- service/
|- utils/
|- main.dart
```

## Test the app

Use following command for test the app

```
flutter test \* each test file route*\
or
flutter test --machine / flutter test
```

## Mock data for Sign in

{"email": "test@email.com", "password": "test123"}

Use this data for Sign in.
After sign in successfully, they can go to the welcome screen. Also, they can logout from welcome screen.

## Installed Packages

- flutter_riverpod
- google_fonts
- flutter_svg
- flutter_test
- mockito
