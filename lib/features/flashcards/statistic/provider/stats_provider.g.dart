// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deckStatistics)
const deckStatisticsProvider = DeckStatisticsFamily._();

final class DeckStatisticsProvider
    extends $FunctionalProvider<DeckStatistics, DeckStatistics, DeckStatistics>
    with $Provider<DeckStatistics> {
  const DeckStatisticsProvider._({
    required DeckStatisticsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deckStatisticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckStatisticsHash();

  @override
  String toString() {
    return r'deckStatisticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DeckStatistics> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeckStatistics create(Ref ref) {
    final argument = this.argument as String;
    return deckStatistics(ref, deckId: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeckStatistics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeckStatistics>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeckStatisticsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckStatisticsHash() => r'1624f28d866b809ed8636b26dc3fb5ffe69e8374';

final class DeckStatisticsFamily extends $Family
    with $FunctionalFamilyOverride<DeckStatistics, String> {
  const DeckStatisticsFamily._()
    : super(
        retry: null,
        name: r'deckStatisticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckStatisticsProvider call({required String deckId}) =>
      DeckStatisticsProvider._(argument: deckId, from: this);

  @override
  String toString() => r'deckStatisticsProvider';
}
