# PTB Coding Challenge

This repo demonstrates my ability to produce a complex UI in Flutter based on the below mock up.
![Mock Up](image2.png)

## Getting Started

This project uses code generators for its HTTP requests, copying, and deserialization of JSON. The generated files are
not committed to VCS you'll need to run the below commands to generate them.

```shell
flutter pub get
flutter pub run build_runner run
```

The above commands when executed from the VCS root will generate the necessary files to run the app. From there use the
below command to run the app.

```shell
flutter run
```

## Tests

As part of the test I wrote a few preliminary tests to verify that the smaller widgets in the UI work as expected. Run
tests using:

```shell
flutter test test/widget_test.dart
```