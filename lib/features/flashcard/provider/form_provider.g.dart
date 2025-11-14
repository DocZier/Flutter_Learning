// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddCardForm)
const addCardFormProvider = AddCardFormProvider._();

final class AddCardFormProvider extends $NotifierProvider<AddCardForm, void> {
  const AddCardFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addCardFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addCardFormHash();

  @$internal
  @override
  AddCardForm create() => AddCardForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$addCardFormHash() => r'649133728a3b4882e7eac8a81acd51bc7d896491';

abstract class _$AddCardForm extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
