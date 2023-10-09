import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

class MyCSVFilePicker extends StatefulWidget {
  const MyCSVFilePicker({super.key});

  @override
  State<MyCSVFilePicker> createState() => _MyCSVFilePickerState();
}

class _MyCSVFilePickerState extends State<MyCSVFilePicker> {
  List<List<dynamic>> csvData = [];
  String selectedFilePath = "";

  Future<void> loadCsvData(String filePath) async {
    final File file = File(filePath);
    final input = file.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();
    setState(() {
      csvData = fields;
    });
  }

  Future<void> chooseCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null || result.count == 0) return;

    final filePath = result.files.single.path!;
    setState(() {
      selectedFilePath = filePath;
    });

    await loadCsvData(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CSV Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (selectedFilePath.isNotEmpty)
              Text(
                'Selected CSV File: ${path.basename(selectedFilePath)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            if (csvData.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: csvData[0]
                        .map<DataColumn>((column) => DataColumn(
                              label: Text(column.toString()),
                            ))
                        .toList(),
                    rows: csvData
                        .skip(1)
                        .map<DataRow>((rowData) => DataRow(
                              cells: rowData
                                  .map<DataCell>((cellData) => DataCell(
                                        Text(cellData.toString()),
                                      ))
                                  .toList(),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: chooseCsvFile,
              child: Text('Choose CSV File'),
            ),
          ],
        ),
      ),
    );
  }
}
