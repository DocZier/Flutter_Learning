// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Statistic)
const statisticProvider = StatisticFamily._();

final class StatisticProvider
    extends $AsyncNotifierProvider<Statistic, StatisticsState> {
  const StatisticProvider._({
    required StatisticFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'statisticProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$statisticHash();

  @override
  String toString() {
    return r'statisticProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Statistic create() => Statistic();

  @override
  bool operator ==(Object other) {
    return other is StatisticProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statisticHash() => r'0998ac3bae9432c16edbe040b9ade495cc1d93ed';

final class StatisticFamily extends $Family
    with
        $ClassFamilyOverride<
          Statistic,
          AsyncValue<StatisticsState>,
          StatisticsState,
          FutureOr<StatisticsState>,
          String
        > {
  const StatisticFamily._()
    : super(
        retry: null,
        name: r'statisticProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StatisticProvider call({required String deckId}) =>
      StatisticProvider._(argument: deckId, from: this);

  @override
  String toString() => r'statisticProvider';
}

abstract class _$Statistic extends $AsyncNotifier<StatisticsState> {
  late final _$args = ref.$arg as String;
  String get deckId => _$args;

  FutureOr<StatisticsState> build({required String deckId});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(deckId: _$args);
    final ref = this.ref as $Ref<AsyncValue<StatisticsState>, StatisticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StatisticsState>, StatisticsState>,
              AsyncValue<StatisticsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
