import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SQLite Joins in Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: JoinExampleApp(),
    );
  }
}


class JoinExampleApp extends StatefulWidget {
  @override
  State<JoinExampleApp> createState() => _JoinExampleAppState();
}

class _JoinExampleAppState extends State<JoinExampleApp> {
  List<Map<String, dynamic>> _data = [];
  String _selectedJoin = 'INNER';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final result = await DBHelper().fetchJoinData(_selectedJoin);
    print("Fetched Data: $result"); // DEBUG PRINT
    setState(() {
      _data = result;
    });
  }


  void _onJoinTypeChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedJoin = value;
      });
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite Joins in Flutter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: _selectedJoin,
              items: ['INNER', 'LEFT','CROSS']
                  .map((join) => DropdownMenuItem(
                value: join,
                child: Text(join),
              ))
                  .toList(),
              onChanged: _onJoinTypeChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return ListTile(
                  title: Text('Name: ${item['name'] ?? 'NULL'}'),
                  subtitle: Text('Dept: ${item['dept'] ?? 'NULL'}\nSalary: ${item['salary'] ?? 'NULL'}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
