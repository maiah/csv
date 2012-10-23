csv
===

CSV file/content parser for Dart.

Sample usage
============

Add `csv` to your pubspec.yaml as a dependency. Import `csv.dart` and you can use `parseCsvFile` method to get the contents of a CSV file.

```dart
import 'package:csv/csv.dart';
import 'dart:io';

void main() {
  File csvFile = new File('./sample.csv');

  parseCsvFile(csvFile, (csv) {
    for (List<String> row in csv) {
      for (String col in row) {
        print('Column: $col');
      }
    }
  });
}
```