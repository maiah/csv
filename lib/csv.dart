library csv;

import 'dart:io';

void parseCsvFile(File csvFile, void callback(List<List<String>> csv)) {
  InputStream inputStream = csvFile.openInputStream();
  String csvContent = '';

  inputStream.onError = (e) => throw e;

  inputStream.onData = () {
    List<int> bytes = inputStream.read();
    String dataString = new String.fromCharCodes(bytes);
    csvContent = '$csvContent$dataString';
  };

  inputStream.onClosed = () {
    callback(parseCsvContent(csvContent));
  };
}

/**
 * Parses the csvFileContent.
 */
List<List<String>> parseCsvContent(String csvFileContent) {
  List<List<String>> csv = new List<List<String>>();
  List<String> csvContentSplitted = csvFileContent.trim().split('\n');
  for (String contentSplitted in csvContentSplitted) {

    String column = '';
    bool foundDoubleQuote = false;
    List<String> columns = new List<String>();
    List<String> chars = contentSplitted.trim().splitChars();
    for (String c in chars) {
      if (c != ',' && c != '"') {
        column = '$column$c';
      } else if (c == '"') {
        if (foundDoubleQuote) {
          foundDoubleQuote = false;
        } else {
          foundDoubleQuote = true;
        }

      } else if (c == ',') {
        if (foundDoubleQuote) {
          column = '$column$c';
        } else {
          columns.add('$column');
          column = '';
        }

      } else {
        columns.add('$column');
        column = '';
      }
    }

    columns.add(column);
    csv.add(columns);
  }

  return csv;
}