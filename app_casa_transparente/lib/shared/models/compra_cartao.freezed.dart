// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compra_cartao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompraCartao _$CompraCartaoFromJson(Map<String, dynamic> json) {
  return _CompraCartao.fromJson(json);
}

/// @nodoc
mixin _$CompraCartao {
  String? get id => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  String get descricao => throw _privateConstructorUsedError;
  double get valor => throw _privateConstructorUsedError;
  String get pessoa => throw _privateConstructorUsedError;
  int get mes => throw _privateConstructorUsedError;
  int get ano => throw _privateConstructorUsedError;
  bool get pago => throw _privateConstructorUsedError;

  /// Serializes this CompraCartao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompraCartao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompraCartaoCopyWith<CompraCartao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompraCartaoCopyWith<$Res> {
  factory $CompraCartaoCopyWith(
          CompraCartao value, $Res Function(CompraCartao) then) =
      _$CompraCartaoCopyWithImpl<$Res, CompraCartao>;
  @useResult
  $Res call(
      {String? id,
      String data,
      String descricao,
      double valor,
      String pessoa,
      int mes,
      int ano,
      bool pago});
}

/// @nodoc
class _$CompraCartaoCopyWithImpl<$Res, $Val extends CompraCartao>
    implements $CompraCartaoCopyWith<$Res> {
  _$CompraCartaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompraCartao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? data = null,
    Object? descricao = null,
    Object? valor = null,
    Object? pessoa = null,
    Object? mes = null,
    Object? ano = null,
    Object? pago = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      descricao: null == descricao
          ? _value.descricao
          : descricao // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$CompraCartaoImplCopyWith<$Res>
    implements $CompraCartaoCopyWith<$Res> {
  factory _$$CompraCartaoImplCopyWith(
          _$CompraCartaoImpl value, $Res Function(_$CompraCartaoImpl) then) =
      __$$CompraCartaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String data,
      String descricao,
      double valor,
      String pessoa,
      int mes,
      int ano,
      bool pago});
}

/// @nodoc
class __$$CompraCartaoImplCopyWithImpl<$Res>
    extends _$CompraCartaoCopyWithImpl<$Res, _$CompraCartaoImpl>
    implements _$$CompraCartaoImplCopyWith<$Res> {
  __$$CompraCartaoImplCopyWithImpl(
      _$CompraCartaoImpl _value, $Res Function(_$CompraCartaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompraCartao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? data = null,
    Object? descricao = null,
    Object? valor = null,
    Object? pessoa = null,
    Object? mes = null,
    Object? ano = null,
    Object? pago = null,
  }) {
    return _then(_$CompraCartaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      descricao: null == descricao
          ? _value.descricao
          : descricao // ignore: cast_nullable_to_non_nullable
              as String,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
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

@JsonSerializable(includeIfNull: false)
class _$CompraCartaoImpl implements _CompraCartao {
  const _$CompraCartaoImpl(
      {this.id,
      required this.data,
      required this.descricao,
      required this.valor,
      required this.pessoa,
      required this.mes,
      required this.ano,
      this.pago = false});

  factory _$CompraCartaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompraCartaoImplFromJson(json);

  @override
  final String? id;
  @override
  final String data;
  @override
  final String descricao;
  @override
  final double valor;
  @override
  final String pessoa;
  @override
  final int mes;
  @override
  final int ano;
  @override
  @JsonKey()
  final bool pago;

  @override
  String toString() {
    return 'CompraCartao(id: $id, data: $data, descricao: $descricao, valor: $valor, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompraCartaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.descricao, descricao) ||
                other.descricao == descricao) &&
            (identical(other.valor, valor) || other.valor == valor) &&
            (identical(other.pessoa, pessoa) || other.pessoa == pessoa) &&
            (identical(other.mes, mes) || other.mes == mes) &&
            (identical(other.ano, ano) || other.ano == ano) &&
            (identical(other.pago, pago) || other.pago == pago));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, data, descricao, valor, pessoa, mes, ano, pago);

  /// Create a copy of CompraCartao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompraCartaoImplCopyWith<_$CompraCartaoImpl> get copyWith =>
      __$$CompraCartaoImplCopyWithImpl<_$CompraCartaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompraCartaoImplToJson(
      this,
    );
  }
}

abstract class _CompraCartao implements CompraCartao {
  const factory _CompraCartao(
      {final String? id,
      required final String data,
      required final String descricao,
      required final double valor,
      required final String pessoa,
      required final int mes,
      required final int ano,
      final bool pago}) = _$CompraCartaoImpl;

  factory _CompraCartao.fromJson(Map<String, dynamic> json) =
      _$CompraCartaoImpl.fromJson;

  @override
  String? get id;
  @override
  String get data;
  @override
  String get descricao;
  @override
  double get valor;
  @override
  String get pessoa;
  @override
  int get mes;
  @override
  int get ano;
  @override
  bool get pago;

  /// Create a copy of CompraCartao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompraCartaoImplCopyWith<_$CompraCartaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
