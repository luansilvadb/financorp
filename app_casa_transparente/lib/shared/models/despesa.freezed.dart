// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'despesa.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Despesa _$DespesaFromJson(Map<String, dynamic> json) {
  return _Despesa.fromJson(json);
}

/// @nodoc
mixin _$Despesa {
  String? get id => throw _privateConstructorUsedError;
  String get nome => throw _privateConstructorUsedError;
  @JsonKey(name: 'dia_vencimento')
  int get diaVencimento => throw _privateConstructorUsedError;
  double get valor => throw _privateConstructorUsedError;

  /// Serializes this Despesa to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Despesa
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DespesaCopyWith<Despesa> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DespesaCopyWith<$Res> {
  factory $DespesaCopyWith(Despesa value, $Res Function(Despesa) then) =
      _$DespesaCopyWithImpl<$Res, Despesa>;
  @useResult
  $Res call(
      {String? id,
      String nome,
      @JsonKey(name: 'dia_vencimento') int diaVencimento,
      double valor});
}

/// @nodoc
class _$DespesaCopyWithImpl<$Res, $Val extends Despesa>
    implements $DespesaCopyWith<$Res> {
  _$DespesaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Despesa
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nome = null,
    Object? diaVencimento = null,
    Object? valor = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      diaVencimento: null == diaVencimento
          ? _value.diaVencimento
          : diaVencimento // ignore: cast_nullable_to_non_nullable
              as int,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DespesaImplCopyWith<$Res> implements $DespesaCopyWith<$Res> {
  factory _$$DespesaImplCopyWith(
          _$DespesaImpl value, $Res Function(_$DespesaImpl) then) =
      __$$DespesaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String nome,
      @JsonKey(name: 'dia_vencimento') int diaVencimento,
      double valor});
}

/// @nodoc
class __$$DespesaImplCopyWithImpl<$Res>
    extends _$DespesaCopyWithImpl<$Res, _$DespesaImpl>
    implements _$$DespesaImplCopyWith<$Res> {
  __$$DespesaImplCopyWithImpl(
      _$DespesaImpl _value, $Res Function(_$DespesaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Despesa
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? nome = null,
    Object? diaVencimento = null,
    Object? valor = null,
  }) {
    return _then(_$DespesaImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nome: null == nome
          ? _value.nome
          : nome // ignore: cast_nullable_to_non_nullable
              as String,
      diaVencimento: null == diaVencimento
          ? _value.diaVencimento
          : diaVencimento // ignore: cast_nullable_to_non_nullable
              as int,
      valor: null == valor
          ? _value.valor
          : valor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$DespesaImpl implements _Despesa {
  const _$DespesaImpl(
      {this.id,
      required this.nome,
      @JsonKey(name: 'dia_vencimento') required this.diaVencimento,
      required this.valor});

  factory _$DespesaImpl.fromJson(Map<String, dynamic> json) =>
      _$$DespesaImplFromJson(json);

  @override
  final String? id;
  @override
  final String nome;
  @override
  @JsonKey(name: 'dia_vencimento')
  final int diaVencimento;
  @override
  final double valor;

  @override
  String toString() {
    return 'Despesa(id: $id, nome: $nome, diaVencimento: $diaVencimento, valor: $valor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DespesaImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nome, nome) || other.nome == nome) &&
            (identical(other.diaVencimento, diaVencimento) ||
                other.diaVencimento == diaVencimento) &&
            (identical(other.valor, valor) || other.valor == valor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nome, diaVencimento, valor);

  /// Create a copy of Despesa
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DespesaImplCopyWith<_$DespesaImpl> get copyWith =>
      __$$DespesaImplCopyWithImpl<_$DespesaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DespesaImplToJson(
      this,
    );
  }
}

abstract class _Despesa implements Despesa {
  const factory _Despesa(
      {final String? id,
      required final String nome,
      @JsonKey(name: 'dia_vencimento') required final int diaVencimento,
      required final double valor}) = _$DespesaImpl;

  factory _Despesa.fromJson(Map<String, dynamic> json) = _$DespesaImpl.fromJson;

  @override
  String? get id;
  @override
  String get nome;
  @override
  @JsonKey(name: 'dia_vencimento')
  int get diaVencimento;
  @override
  double get valor;

  /// Create a copy of Despesa
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DespesaImplCopyWith<_$DespesaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
