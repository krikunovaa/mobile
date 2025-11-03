import 'package:flutter/material.dart';
import 'cats_list_page.dart';
import 'cats_realtime_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Котик 🐱',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CatsListPage()),
                );
              },
              child: const Text('navigator.push() - Список котиков'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cats');
              },
              child: const Text('pushNamed - Список котиков'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cats_realtime');
              },
              child: const Text('CRUD операции (SELECT, INSERT, UPDATE, DELETE)'),
            ),
          ],
        ),
      ),
    );
  }
}