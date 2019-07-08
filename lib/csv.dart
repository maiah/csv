library csv;

import 'dart:io';
import 'dart:async';

/**
 * Parses the given `csvFile` and return a `Future<List<List<String>>>` that
 * can be use conveniently to read the contents of the file.
 */
Future<List<List<String>>> parseCsvFile(File csvFile) {
  Completer<List<List<String>>> completer = new Completer<List<List<String>>>();
  Future<RandomAccessFile> inputStream = csvFile.open();
  String csvContent = '';

  inputStream.catchError((e) => throw e);

  inputStream.then((RandomAccessFile file) {
    List<int> bytes = file.readSync(file.lengthSync());
    String dataString = new String.fromCharCodes(bytes);
    csvContent = '$csvContent$dataString';
    completer.complete(parseCsvContent(csvContent));
  });

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
    List<String> chars = contentSplitted.trim().split('');
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
void writeCsvFile(File csvFile, List<List<String>> csvFileContent, [bool overwrite = true]) {
  FileMode fileMode = FileMode.write;
  if (!overwrite) {
    fileMode = FileMode.append;
  }

  RandomAccessFile os = csvFile.openSync(mode: fileMode);

  for (List<String> row in csvFileContent) {
    for (int i = 0; i < row.length; i++) {
      String column = row[i];

      if (i > 0) {
        os.writeStringSync(',');
      }

      os.writeStringSync(column);
    }
    os.writeStringSync('\n');
  }

  os.close();
}