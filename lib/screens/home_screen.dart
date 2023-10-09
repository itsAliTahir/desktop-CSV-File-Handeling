import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../global_constants_and_variables.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double pageWidth = MediaQuery.of(context).size.width;
    final double pageHeight = MediaQuery.of(context).size.height;
    final theData = Provider.of<ProviderClass>(context).data;
    final createFile = Provider.of<ProviderClass>(context).exportCSVFile;
    final newCell = Provider.of<ProviderClass>(context).newCell;
    return Scaffold(
      body: SizedBox(
        width: pageWidth,
        height: pageHeight,
        // color: Colors.amber,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            width: pageWidth,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "File Name"),
                onChanged: (value) {
                  if (value.isEmpty) {
                    fileName = "test";
                    return;
                  }
                  fileName = value;
                },
              ),
            ),
          ),
          Container(
            width: pageWidth,
            height: (pageHeight - 50) * 0.8,
            color: const Color.fromARGB(97, 156, 152, 152),
            child: ListView.builder(
              itemCount: theData.length,
              itemBuilder: (context, index) {
                return Container(
                  width: pageWidth,
                  height: 50,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 3; i++)
                          SizedBox(
                            width: pageWidth * 0.2,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              initialValue: theData[index][i].toString(),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  theData[index][i] = "Null";
                                  setState(() {});
                                  return;
                                }
                                theData[index][i] = value;
                                setState(() {});
                              },
                            ),
                          ),
                      ]),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Add"),
              onPressed: () {
                newCell();
                setState(() {});
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Export"),
              onPressed: () {
                createFile();
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Import"),
              onPressed: () {},
            ),
          ),
        ]),
      ),
    );
  }
}
