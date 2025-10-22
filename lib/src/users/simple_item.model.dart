import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:uuid/uuid.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'simple_items'),
)

class SimpleItem extends OfflineFirstWithSupabaseModel {
  @Supabase(unique: true)
  @Sqlite(index: true, unique: true)
  final String id;

  @SupabaseSerializable()
  final String name;

  SimpleItem({String? id, required this.name})
    : this.id = id ?? const Uuid().v4();
}

extension SimpleItemSync on SimpleItem {
  Future<void> sync(OfflineFirstWithSupabaseRepository repository) async {
    await repository.upsert<SimpleItem>(this);
  }
}