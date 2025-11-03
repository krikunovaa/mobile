import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CatsListPage extends StatefulWidget {
  const CatsListPage({super.key});

  @override
  State<CatsListPage> createState() => _CatsListPageState();
}

class _CatsListPageState extends State<CatsListPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> cats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCats();
  }

  Future<void> _loadCats() async {
    try {
      print('SELECT: Загрузка котиков...');
      final response = await supabase
          .from('cats')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        cats = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
      
      print('SELECT: Котики загружены: ${cats.length}');
    } catch (e) {
      print('Ошибка SELECT: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addCat() async {
    try {
      final newCat = {
        'name': 'Котик ${DateTime.now().second}',
        'age': DateTime.now().second % 10,
        'color': ['рыжий', 'серый', 'белый'][DateTime.now().second % 3],
      };

      print('INSERT: Добавляем котика: $newCat');
      
      await supabase.from('cats').insert(newCat);
      await _loadCats();
      
      print('INSERT: Котик добавлен успешно');
    } catch (e) {
      print('Ошибка INSERT: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список котиков'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCats,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cats.isEmpty
              ? const Center(child: Text('Нет котиков 😿'))
              : ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (context, index) {
                    final cat = cats[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange[100],
                          child: const Icon(Icons.pets),
                        ),
                        title: Text(cat['name'] ?? 'Без имени'),
                        subtitle: Text(
                            'Возраст: ${cat['age']}, Цвет: ${cat['color']}'),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCat,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}