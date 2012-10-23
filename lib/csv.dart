library csv;

/**
 * Parses the csvFileContent.
 */
List<List<String>> parseCsv(String csvFileContent) {
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