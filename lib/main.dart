import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dummy_data.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderClass()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomeScreen(),
      ),
    );
  }
}
