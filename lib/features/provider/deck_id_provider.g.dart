// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deckById)
const deckByIdProvider = DeckByIdFamily._();

final class DeckByIdProvider extends $FunctionalProvider<Deck, Deck, Deck>
    with $Provider<Deck> {
  const DeckByIdProvider._({
    required DeckByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deckByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deckByIdHash();

  @override
  String toString() {
    return r'deckByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Deck> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Deck create(Ref ref) {
    final argument = this.argument as String;
    return deckById(ref, id: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Deck value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Deck>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DeckByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deckByIdHash() => r'c25fb2ef9ef7fdc986a56c32be5d479864ca8766';

final class DeckByIdFamily extends $Family
    with $FunctionalFamilyOverride<Deck, String> {
  const DeckByIdFamily._()
    : super(
        retry: null,
        name: r'deckByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DeckByIdProvider call({required String id}) =>
      DeckByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'deckByIdProvider';
}
