import 'dart:async';
import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:uuid/uuid.dart';
import 'package:offline_first_demo/src/users/brick/repository.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'simple_items'),
)
class SimpleItem extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  @SupabaseSerializable()
  String _name = '';
  String get name => _name;

  Timer? _debounceTimer;

  // Constructor does NOT sync - just sets values
  SimpleItem({String? id, required String name})
    : this.id = id ?? const Uuid().v4(),
      // Direct assignment to _name field no setter call
      _name = name;

  set name(String name) {
    print('Setter called with: "$name"');
    _name = name;

    // Cancel any pending sync
    _debounceTimer?.cancel();

    // Schedule a new sync after 300ms of no changes
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      print('Debounce timer fired, syncing: "$_name"');
      _syncToDatabase();
    });
  }

  void _syncToDatabase() async {
    try {
      await Repository().upsert<SimpleItem>(this);
      print('Sync successful for: "$_name"');
    } catch (e, stackTrace) {
      print('Sync failed for: "$_name"');
      print('Error: $e');
    }
  }

  void updateNameWithoutSync(String name) {
    _name = name;
  }
}
