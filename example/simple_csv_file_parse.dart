import '../lib/csv.dart';
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