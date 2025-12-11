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
    extends $NotifierProvider<Statistic, StatisticsState> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatisticsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatisticsState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StatisticProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$statisticHash() => r'c4aba6e1fbb5098577ca31ccc6514b7314cdb578';

final class StatisticFamily extends $Family
    with
        $ClassFamilyOverride<
          Statistic,
          StatisticsState,
          StatisticsState,
          StatisticsState,
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

abstract class _$Statistic extends $Notifier<StatisticsState> {
  late final _$args = ref.$arg as String;
  String get deckId => _$args;

  StatisticsState build({required String deckId});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(deckId: _$args);
    final ref = this.ref as $Ref<StatisticsState, StatisticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StatisticsState, StatisticsState>,
              StatisticsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
