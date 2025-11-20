// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudyNotifier)
const studyProvider = StudyNotifierProvider._();

final class StudyNotifierProvider
    extends $NotifierProvider<StudyNotifier, bool> {
  const StudyNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyNotifierHash();

  @$internal
  @override
  StudyNotifier create() => StudyNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$studyNotifierHash() => r'1a09f0e23f74804d18dca383ad55701a996b22d5';

abstract class _$StudyNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
