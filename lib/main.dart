import 'package:flutter/material.dart';
import 'package:offline_first_demo/src/users/brick/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:offline_first_demo/src/users/simple_item.model.dart';

Future<void> main() async {
  await Repository.configure(databaseFactory);
  // .initialize() does not need to be invoked within main()
  // It can be invoked from within a state manager or within
  // an initState()
  await Repository().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Supabase.instance.client
        // Channel name based on table name
        .channel('public:simple_items')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          // Subscribe to simple_items instead of demo
          table: 'simple_items',
          callback: (payload) {
            final record = payload.newRecord;
            if (record['name'] is String) {
              final String newName = record['name'] as String;
              // Update TextField with new name from db
              setState(() {
                myController.text = newName;
              });
            }
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SimpleItem Sync Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: myController,
              onChanged: (text) {
                // Create and sync SimpleItem on each text change
                SimpleItem(name: text).sync(Repository());
              },
              decoration: const InputDecoration(labelText: 'SimpleItem Name'),
            ),
            const SizedBox(height: 16),
            Text('Typing will create a new SimpleItem in Supabase.'),
          ],
        ),
      ),
    );
  }
}
