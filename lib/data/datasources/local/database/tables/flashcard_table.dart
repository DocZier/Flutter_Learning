
import 'package:drift/drift.dart';

class Flashcards extends Table {
  TextColumn get deckId => text()();
  TextColumn get id => text()();
  TextColumn get question => text()();
  TextColumn get answer => text()();
  IntColumn get interval => integer()();
  DateTimeColumn get nextReview => dateTime()();
  RealColumn get easeFactor => real()();
  IntColumn get reviewCount => integer()();
  DateTimeColumn get lastReviewedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}