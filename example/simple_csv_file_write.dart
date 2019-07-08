import '../lib/csv.dart';
import 'dart:io';

void main() {
  File csvFile = new File('D:\\Github\\csv\\example\\sample_write.csv');

  List<List<String>> csvFileContent = new List<List<String>>();
  List<String> row1 = new List<String>();
  row1.add('Name');
  row1.add('Age');
  row1.add('Gender');
  row1.add('Position');
  row1.add('Color');

  List<String> row2 = new List<String>();
  row2.add('Maiah');
  row2.add('26');
  row2.add('M');
  row2.add('Up');
  row2.add('Green');

  List<String> row3 = new List<String>();
  row3.add('James');
  row3.add('23');
  row3.add('M');
  row3.add('Up');
  row3.add('Red');

  csvFileContent.add(row1);
  csvFileContent.add(row2);
  csvFileContent.add(row3);

  writeCsvFile(csvFile, csvFileContent);
}