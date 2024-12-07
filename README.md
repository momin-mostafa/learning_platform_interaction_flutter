
# Learning Platform Interaction

A Flutter project designed to explore Android platform-specific functionalities using **MethodChannel**. This project demonstrates how to establish communication between Flutter and Android native code, making use of platform channels for invoking native functionalities.

## Features

- Bidirectional communication between Flutter and Android.
- Example functionalities like retrieving data from Android.
- Minimalistic and beginner-friendly codebase to understand the fundamentals of **MethodChannel**.

---

## Prerequisites

- **Flutter SDK**: Version 3.0.0 or later
- **Android Studio**: Latest stable version with Android SDK
- **Dart**: Version 2.17 or later

---

## Project Structure

- **lib/**: Contains Flutter code.
    - `main.dart`: The entry point of the application, which initializes the `MethodChannel` and handles interactions.
- **android/**: Contains native Android code.
    - `MainActivity.kt`: Implements platform-specific methods and communicates with Flutter through the `MethodChannel`.

---

## Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/learning_platform_interaction.git
   cd learning_platform_interaction
   ```

2. **Install Dependencies**  
   Run the following command to install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. **Run the Project**  
   To run the project on an Android device or emulator, execute:
   ```bash
   flutter run
   ```

4. **Explore Native Interaction**  
   Check out the `invokeMethod` calls in `main.dart` and corresponding native implementations in `MainActivity.kt`.

---

## Example Code

### Flutter Side: Using MethodChannel
```dart
static const _platform = MethodChannel('demo.tamim.com/learn');

Future<String> _getMessageFromPlatform() async {
  Map<String, dynamic> sendMap = {
    'from': 'tamim',
  };
  try {
    String value = await _platform.invokeMethod("getMessage", sendMap);
    return value;
  } catch (e) {
    log(e.toString(), error: "ERROR._getMessageFromPlatform");
    throw "ERROR while method invoke";
  }
}

Future<void> getStringAndShow() async {
  await _getMessageFromPlatform().then((value) {
    setState(() {
      _message = value;
    });
  });
}
```

### Android Side: Implementing Platform Methods
```kotlin
package com.example.learning_platform_iteraction

import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Objects

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "demo.tamim.com/learn"
        ).setMethodCallHandler { call, result ->
            if (call.method == "getMessage") {
                val arguments = call.arguments<Map<String, String>>()
                if (arguments?.getValue("from") is String){
                    val value: String = arguments?.getValue("from") as String
                    result.success("$value says hi from android")
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
```

---

## Learning Objectives

- Understand the use of **MethodChannel** in Flutter for platform interaction.
- Learn how to integrate Android-specific functionalities in a Flutter app.
- Gain hands-on experience with bidirectional data exchange between Dart and Kotlin.

---

## Contribution

Contributions are welcome! If you have suggestions, improvements, or additional use cases to share, feel free to open an issue or submit a pull request.

---

## Acknowledgments

- [Flutter Documentation - Platform Channels](https://docs.flutter.dev/development/platform-integration/platform-channels)
- [Android Documentation - Build.VERSION](https://developer.android.com/reference/android/os/Build.VERSION)

--- 

Feel free to modify and expand this README as needed for your project!
