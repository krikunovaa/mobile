import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';
import 'cats_list_page.dart';
import 'cats_realtime_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://qkzadrkjqozhvexlepfo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFremFkcmtqcW96aHZleGxlcGZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIwMTIwMDIsImV4cCI6MjA3NzU4ODAwMn0.ue-raq9zq1zxkwtVc-cMDDjjPk8y93mnulj-PBBovec',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Котики App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      routes: {
        '/cats': (context) => const CatsListPage(),
        '/cats_realtime': (context) => const CatsRealtimePage(),
      },
    );
  }
}