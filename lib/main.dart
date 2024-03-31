import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Omni Exchange",
      //Definindo uma cor de tema para o App
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      //Chamada da página inicial
      home: const HomePage(),
    );
  }
}
