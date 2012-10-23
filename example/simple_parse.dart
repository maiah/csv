import '../lib/csv.dart';

void main() {
  String csvContent = '''
      Name,Age,Address,Color,Department
      Maiah,26,Manila,Green,IT
      James,23,"MNL, PH",Red,PS
      ''';

  List<List<String>> csv = parseCsvContent(csvContent);

  for (List<String> row in csv) {
    for (String col in row) {
      print('Column: $col');
    }
  }
}