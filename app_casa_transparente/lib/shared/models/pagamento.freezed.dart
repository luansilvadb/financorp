// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagamento.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pagamento _$PagamentoFromJson(Map<String, dynamic> json) {
  return _Pagamento.fromJson(json);
}

/// @nodoc
mixin _$Pagamento {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'despesa_id')
  String get despesaId => throw _privateConstructorUsedError;
  String get pessoa => throw _privateConstructorUsedError;
  int get mes => throw _privateConstructorUsedError;
  int get ano => throw _privateConstructorUsedError;
  bool get pago => throw _privateConstructorUsedError;

  /// Serializes this Pagamento to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagamento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagamentoCopyWith<Pagamento> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagamentoCopyWith<$Res> {
  factory $PagamentoCopyWith(Pagamento value, $Res Function(Pagamento) then) =
      _$PagamentoCopyWithImpl<$Res, Pagamento>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'despesa_id') String despesaId,
      String pessoa,
      int mes,
      int ano,
      bool pago});
}

/// @nodoc
class _$PagamentoCopyWithImpl<$Res, $Val extends Pagamento>
    implements $PagamentoCopyWith<$Res> {
  _$PagamentoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagamento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? despesaId = null,
    Object? pessoa = null,
    Object? mes = null,
    Object? ano = null,
    Object? pago = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      despesaId: null == despesaId
          ? _value.despesaId
          : despesaId // ignore: cast_nullable_to_non_nullable
              as String,
      pessoa: null == pessoa
          ? _value.pessoa
          : pessoa // ignore: cast_nullable_to_non_nullable
              as String,
      mes: null == mes
          ? _value.mes
          : mes // ignore: cast_nullable_to_non_nullable
              as int,
      ano: null == ano
          ? _value.ano
          : ano // ignore: cast_nullable_to_non_nullable
              as int,
      pago: null == pago
          ? _value.pago
          : pago // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PagamentoImplCopyWith<$Res>
    implements $PagamentoCopyWith<$Res> {
  factory _$$PagamentoImplCopyWith(
          _$PagamentoImpl value, $Res Function(_$PagamentoImpl) then) =
      __$$PagamentoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'despesa_id') String despesaId,
      String pessoa,
      int mes,
      int ano,
      bool pago});
}

/// @nodoc
class __$$PagamentoImplCopyWithImpl<$Res>
    extends _$PagamentoCopyWithImpl<$Res, _$PagamentoImpl>
    implements _$$PagamentoImplCopyWith<$Res> {
  __$$PagamentoImplCopyWithImpl(
      _$PagamentoImpl _value, $Res Function(_$PagamentoImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pagamento
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? despesaId = null,
    Object? pessoa = null,
    Object? mes = null,
    Object? ano = null,
    Object? pago = null,
  }) {
    return _then(_$PagamentoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      despesaId: null == despesaId
          ? _value.despesaId
          : despesaId // ignore: cast_nullable_to_non_nullable
              as String,
      pessoa: null == pessoa
          ? _value.pessoa
          : pessoa // ignore: cast_nullable_to_non_nullable
              as String,
      mes: null == mes
          ? _value.mes
          : mes // ignore: cast_nullable_to_non_nullable
              as int,
      ano: null == ano
          ? _value.ano
          : ano // ignore: cast_nullable_to_non_nullable
              as int,
      pago: null == pago
          ? _value.pago
          : pago // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PagamentoImpl implements _Pagamento {
  const _$PagamentoImpl(
      {required this.id,
      @JsonKey(name: 'despesa_id') required this.despesaId,
      required this.pessoa,
      required this.mes,
      required this.ano,
      required this.pago});

  factory _$PagamentoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PagamentoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'despesa_id')
  final String despesaId;
  @override
  final String pessoa;
  @override
  final int mes;
  @override
  final int ano;
  @override
  final bool pago;

  @override
  String toString() {
    return 'Pagamento(id: $id, despesaId: $despesaId, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagamentoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.despesaId, despesaId) ||
                other.despesaId == despesaId) &&
            (identical(other.pessoa, pessoa) || other.pessoa == pessoa) &&
            (identical(other.mes, mes) || other.mes == mes) &&
            (identical(other.ano, ano) || other.ano == ano) &&
            (identical(other.pago, pago) || other.pago == pago));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, despesaId, pessoa, mes, ano, pago);

  /// Create a copy of Pagamento
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagamentoImplCopyWith<_$PagamentoImpl> get copyWith =>
      __$$PagamentoImplCopyWithImpl<_$PagamentoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PagamentoImplToJson(
      this,
    );
  }
}

abstract class _Pagamento implements Pagamento {
  const factory _Pagamento(
      {required final String id,
      @JsonKey(name: 'despesa_id') required final String despesaId,
      required final String pessoa,
      required final int mes,
      required final int ano,
      required final bool pago}) = _$PagamentoImpl;

  factory _Pagamento.fromJson(Map<String, dynamic> json) =
      _$PagamentoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'despesa_id')
  String get despesaId;
  @override
  String get pessoa;
  @override
  int get mes;
  @override
  int get ano;
  @override
  bool get pago;

  /// Create a copy of Pagamento
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagamentoImplCopyWith<_$PagamentoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
