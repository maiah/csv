import '../lib/csv.dart';

void main() {
  String csvContent = '''
      Name,Age,Address,Color,Department
      Maiah,26,Manila,Green,IT
      James,23,"MNL, PH",Red,PS
      ''';

  List<List<String>> csv = parseCsv(csvContent);

  for (List<String> row in csv) {
    for (String col in row) {
      print('Column: $col');
    }
  }
}