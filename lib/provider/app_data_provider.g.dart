// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppDataNotifier)
const appDataProvider = AppDataNotifierProvider._();

final class AppDataNotifierProvider
    extends $NotifierProvider<AppDataNotifier, AppData> {
  const AppDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDataNotifierHash();

  @$internal
  @override
  AppDataNotifier create() => AppDataNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppData>(value),
    );
  }
}

String _$appDataNotifierHash() => r'8a21ecda945edf51ea002112f6d20e20db5a7826';

abstract class _$AppDataNotifier extends $Notifier<AppData> {
  AppData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AppData, AppData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppData, AppData>,
              AppData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
