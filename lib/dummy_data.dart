import 'package:csv/csv.dart';
import 'package:desktop_filehandeling/global_constants_and_variables.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DummyClass {
  int id;
  String name;
  double wealth;
  DummyClass({required this.id, required this.name, required this.wealth});
}

class ProviderClass with ChangeNotifier {
  final theData = [
    [1, "Jack", 1200.00],
    [2, "Danny", 1500.00],
    [3, "Julia", 1000.00],
    [4, "Henry", 800.00],
    [5, "Mia", 1300.00],
  ];

  List get data {
    return [...theData];
  }

  void newCell() {
    theData.add([theData.length + 1, "Null", "Null"]);
  }

  void deleteCell(int index) {
    theData.removeAt(index);
  }

  Future<void> exportCSVFile() async {
    final csvData = ListToCsvConverter().convert(theData);
    final directory = Directory.current;
    final filePath = '${directory.path}/lib/Saved/$fileName.csv';
    print("object");
    print(filePath);
    try {
      final csvFile = File(filePath);
      await csvFile.writeAsString(csvData);
      print('CSV file created at: $filePath');
    } catch (e) {
      print('Error creating CSV file: $e');
    }
  }

  Future<void> importCSVFile() async {
    try {
      final File file =
          File('/path/to/your/input.csv'); // Replace with your CSV file path
      final input = file.openRead();

      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      // Now 'fields' contains the data from the CSV file as a List<List<dynamic>>

      // You can process and use the data as needed, e.g., display it in a ListView.
      // Example: print each row
      for (final row in fields) {
        print(row);
      }
    } catch (e) {
      print('Error importing CSV file: $e');
    }
  }
}
