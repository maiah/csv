library csv;

import 'dart:io';

/**
 * Parses the given `csvFile` and return a `Future<List<List<String>>>` that
 * can be use conveniently to read the contents of the file.
 */
Future<List<List<String>>> parseCsvFile(File csvFile) {
  Completer completer = new Completer();
  InputStream inputStream = csvFile.openInputStream();
  String csvContent = '';

  inputStream.onError = (e) => throw e;

  inputStream.onData = () {
    List<int> bytes = inputStream.read();
    String dataString = new String.fromCharCodes(bytes);
    csvContent = '$csvContent$dataString';
  };

  inputStream.onClosed = () {
    completer.complete(parseCsvContent(csvContent));
  };

  return completer.future;
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

/**
 * Writes the `csvFileContent` to `csvFile`.
 */
void writeCsvContentToFile(File csvFile, List<List<String>> csvFileContent, [bool overwrite = true]) {
  FileMode fileMode = FileMode.WRITE;
  if (!overwrite) {
    fileMode = FileMode.APPEND;
  }

  OutputStream os = csvFile.openOutputStream(fileMode);

  for (List<String> row in csvFileContent) {
    for (int i = 0; i < row.length; i++) {
      String column = row[i];

      if (i > 0) {
        os.writeString(',');
      }

      os.writeString(column);
    }
    os.writeString('\n');
  }

  os.close();
}