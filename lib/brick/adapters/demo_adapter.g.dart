// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<Demo> _$DemoFromSupabase(
  Map<String, dynamic> data, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return Demo(
    textInField: data['text_in_field'] as String,
    id: data['id'] as String?,
  );
}

Future<Map<String, dynamic>> _$DemoToSupabase(
  Demo instance, {
  required SupabaseProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {'text_in_field': instance.textInField, 'id': instance.id};
}

Future<Demo> _$DemoFromSqlite(
  Map<String, dynamic> data, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return Demo(
    textInField: data['text_in_field'] as String,
    id: data['id'] as String,
  )..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$DemoToSqlite(
  Demo instance, {
  required SqliteProvider provider,
  OfflineFirstWithSupabaseRepository? repository,
}) async {
  return {'text_in_field': instance.textInField, 'id': instance.id};
}

/// Construct a [Demo]
class DemoAdapter extends OfflineFirstWithSupabaseAdapter<Demo> {
  DemoAdapter();

  @override
  final supabaseTableName = 'demo';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'textInField': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'text_in_field',
    ),
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'textInField': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'text_in_field',
      iterable: false,
      type: String,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: String,
    ),
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
    Demo instance,
    DatabaseExecutor executor,
  ) async {
    final results = await executor.rawQuery(
      '''
        SELECT * FROM `Demo` WHERE id = ? LIMIT 1''',
      [instance.id],
    );

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'Demo';

  @override
  Future<Demo> fromSupabase(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async => await _$DemoFromSupabase(
    input,
    provider: provider,
    repository: repository,
  );
  @override
  Future<Map<String, dynamic>> toSupabase(
    Demo input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$DemoToSupabase(input, provider: provider, repository: repository);
  @override
  Future<Demo> fromSqlite(
    Map<String, dynamic> input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$DemoFromSqlite(input, provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSqlite(
    Demo input, {
    required provider,
    covariant OfflineFirstWithSupabaseRepository? repository,
  }) async =>
      await _$DemoToSqlite(input, provider: provider, repository: repository);
}
