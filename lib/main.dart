import 'package:flutter/material.dart';
import 'package:harang_client/screens/creation/creation_screen.dart';
import 'package:harang_client/viewModels/creation_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<CreationViewModel>(
        create: (context) => CreationViewModel(),
        child: const CreationScreen(),
      ),
    );
  }
}
