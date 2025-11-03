import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CatsRealtimePage extends StatefulWidget {
  const CatsRealtimePage({super.key});

  @override
  State<CatsRealtimePage> createState() => _CatsRealtimePageState();
}

class _CatsRealtimePageState extends State<CatsRealtimePage> {
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
      print('Загрузка котиков...');
      final response = await supabase
          .from('cats')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        cats = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
      
      print('Котики загружены: ${cats.length}');
    } catch (e) {
      print('Ошибка загрузки: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addCat() async {
    try {
      final newCat = {
        'name': 'Авто-котик ${DateTime.now().second}',
        'age': DateTime.now().second % 10,
        'color': ['рыжий', 'серый', 'белый', 'черный'][DateTime.now().second % 4],
      };

      print('INSERT: Добавляем котика: $newCat');
      
      await supabase.from('cats').insert(newCat);
      await _loadCats();
      
      print('INSERT: Котик добавлен успешно');
    } catch (e) {
      print('Ошибка INSERT: $e');
    }
  }

  Future<void> _updateCat(int id) async {
    try {
      print('UPDATE: Обновляем котика ID: $id');
      
      await supabase
          .from('cats')
          .update({'age': DateTime.now().second % 15})
          .eq('id', id);

      await _loadCats();
      print('UPDATE: Котик обновлен');
    } catch (e) {
      print('Ошибка UPDATE: $e');
    }
  }

  Future<void> _deleteCat(int id) async {
    try {
      print('DELETE: Удаляем котика ID: $id');
      
      await supabase
          .from('cats')
          .delete()
          .eq('id', id);

      await _loadCats();
      print('DELETE: Котик удален');
    } catch (e) {
      print('Ошибка DELETE: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Котики с CRUD'),
        backgroundColor: Colors.green,
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
                          backgroundColor: Colors.green[100],
                          child: const Icon(Icons.pets),
                        ),
                        title: Text(cat['name'] ?? 'Без имени'),
                        subtitle: Text(
                            'Возраст: ${cat['age']}, Цвет: ${cat['color']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () => _updateCat(cat['id']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20),
                              onPressed: () => _deleteCat(cat['id']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCat,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}