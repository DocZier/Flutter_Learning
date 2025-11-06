import 'package:flutter/material.dart';
import 'package:test_practic/state/data_repository.dart';
import 'data_container.dart';

class AppDataLogic extends InheritedWidget {
  final AppData appData;

  AppDataLogic({
    super.key,
    required this.appData,
    required super.child,
  });

  late final AppDataRepository appDataRepository = AppDataRepositoryImpl(appData: appData);

  static AppDataLogic of(BuildContext context) {
    final AppDataLogic? result = context.
    dependOnInheritedWidgetOfExactType<AppDataLogic>();
    assert(result != null, 'No AppDataLogic found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppDataLogic oldWidget) => appData != oldWidget.appData;
}