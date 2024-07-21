// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DailyTimeRecordsDao? _dailyTimeRecordsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DailyTimeRecords` (`dateStart` TEXT NOT NULL, `dateEnd` TEXT NOT NULL, `startTime` TEXT NOT NULL, `endTime` TEXT NOT NULL, `breakTimeStart` TEXT NOT NULL, `breakTimeEnd` TEXT NOT NULL, `notes` TEXT NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `createTime` TEXT NOT NULL, `updateTime` TEXT NOT NULL)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_DailyTimeRecords_dateStart` ON `DailyTimeRecords` (`dateStart`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DailyTimeRecordsDao get dailyTimeRecordsDao {
    return _dailyTimeRecordsDaoInstance ??=
        _$DailyTimeRecordsDao(database, changeListener);
  }
}

class _$DailyTimeRecordsDao extends DailyTimeRecordsDao {
  _$DailyTimeRecordsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dailyTimeRecordInsertionAdapter = InsertionAdapter(
            database,
            'DailyTimeRecords',
            (DailyTimeRecord item) => <String, Object?>{
                  'dateStart': item.dateStart,
                  'dateEnd': item.dateEnd,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'breakTimeStart': item.breakTimeStart,
                  'breakTimeEnd': item.breakTimeEnd,
                  'notes': item.notes,
                  'id': item.id,
                  'createTime': item.createTime,
                  'updateTime': item.updateTime
                }),
        _dailyTimeRecordUpdateAdapter = UpdateAdapter(
            database,
            'DailyTimeRecords',
            ['id'],
            (DailyTimeRecord item) => <String, Object?>{
                  'dateStart': item.dateStart,
                  'dateEnd': item.dateEnd,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'breakTimeStart': item.breakTimeStart,
                  'breakTimeEnd': item.breakTimeEnd,
                  'notes': item.notes,
                  'id': item.id,
                  'createTime': item.createTime,
                  'updateTime': item.updateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DailyTimeRecord> _dailyTimeRecordInsertionAdapter;

  final UpdateAdapter<DailyTimeRecord> _dailyTimeRecordUpdateAdapter;

  @override
  Future<List<DailyTimeRecord>> getAllRecords() async {
    return _queryAdapter.queryList('SELECT * FROM DailyTimeRecords',
        mapper: (Map<String, Object?> row) => DailyTimeRecord(
            id: row['id'] as int?,
            dateStart: row['dateStart'] as String,
            dateEnd: row['dateEnd'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            breakTimeStart: row['breakTimeStart'] as String,
            breakTimeEnd: row['breakTimeEnd'] as String,
            notes: row['notes'] as String,
            updateTime: row['updateTime'] as String?,
            createTime: row['createTime'] as String?));
  }

  @override
  Future<List<String>> getAllDates() async {
    return _queryAdapter.queryList('SELECT dateStart FROM DailyTimeRecords',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<DailyTimeRecord?> findRecordById(int id) async {
    return _queryAdapter.query('SELECT * FROM DailyTimeRecords WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DailyTimeRecord(
            id: row['id'] as int?,
            dateStart: row['dateStart'] as String,
            dateEnd: row['dateEnd'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            breakTimeStart: row['breakTimeStart'] as String,
            breakTimeEnd: row['breakTimeEnd'] as String,
            notes: row['notes'] as String,
            updateTime: row['updateTime'] as String?,
            createTime: row['createTime'] as String?),
        arguments: [id]);
  }

  @override
  Future<DailyTimeRecord?> findRecordByDate(String date) async {
    return _queryAdapter.query(
        'SELECT * FROM DailyTimeRecords WHERE dateStart = ?1',
        mapper: (Map<String, Object?> row) => DailyTimeRecord(
            id: row['id'] as int?,
            dateStart: row['dateStart'] as String,
            dateEnd: row['dateEnd'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            breakTimeStart: row['breakTimeStart'] as String,
            breakTimeEnd: row['breakTimeEnd'] as String,
            notes: row['notes'] as String,
            updateTime: row['updateTime'] as String?,
            createTime: row['createTime'] as String?),
        arguments: [date]);
  }

  @override
  Future<List<DailyTimeRecord>> getRecordsByDateRange(
    String fromDate,
    String toDate,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DailyTimeRecords WHERE dateStart BETWEEN ?1 AND ?2',
        mapper: (Map<String, Object?> row) => DailyTimeRecord(
            id: row['id'] as int?,
            dateStart: row['dateStart'] as String,
            dateEnd: row['dateEnd'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            breakTimeStart: row['breakTimeStart'] as String,
            breakTimeEnd: row['breakTimeEnd'] as String,
            notes: row['notes'] as String,
            updateTime: row['updateTime'] as String?,
            createTime: row['createTime'] as String?),
        arguments: [fromDate, toDate]);
  }

  @override
  Future<void> deleteRecord(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM DailyTimeRecords WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAllRecords() async {
    await _queryAdapter.queryNoReturn('DELETE FROM DailyTimeRecords');
  }

  @override
  Future<int?> getRecordsCount() async {
    return _queryAdapter.query('SELECT COUNT(id) FROM DailyTimeRecords',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertRecord(DailyTimeRecord record) async {
    await _dailyTimeRecordInsertionAdapter.insert(
        record, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateRecord(DailyTimeRecord record) async {
    await _dailyTimeRecordUpdateAdapter.update(
        record, OnConflictStrategy.replace);
  }
}
