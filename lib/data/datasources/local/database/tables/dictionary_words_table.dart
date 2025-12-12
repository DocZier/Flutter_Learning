import 'package:drift/drift.dart';

class DictionarySavedWords extends Table {
  TextColumn get id => text()();
  TextColumn get word => text()();
  TextColumn get furigana => text()();
  TextColumn get romanji => text()();
  TextColumn get meaning => text()();
  TextColumn get examples => text()();
  DateTimeColumn get savedAt => dateTime().named('saved_at')();

  @override
  Set<Column> get primaryKey => {id};
}