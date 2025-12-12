import 'package:drift/drift.dart';

class Decks extends Table {
  IntColumn get userId => integer()();
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}