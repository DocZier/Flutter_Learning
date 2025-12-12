import 'package:drift/drift.dart';

class DictionarySavedWords extends Table {
  TextColumn get id => text().unique()();
  TextColumn get word => text()();
  TextColumn get furigana => text()();
  TextColumn get romanji => text()();
  TextColumn get meaning => text()();
  TextColumn get examples => text()(); // JSON array
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}