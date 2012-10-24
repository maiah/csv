import '../lib/csv.dart';
import 'dart:io';

void main() {
  File csvFile = new File('D:\\tools\\flights\\csv\\example\\sample.csv');

  Future<List<List<String>>> f = parseCsvFile(csvFile);
  f.then((List<List<String>> csv) {
    for (List<String> row in csv) {
      for (String col in row) {
        print('Column: $col');
      }
    }
  });

  print('yea');
}