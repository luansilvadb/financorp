// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain.dart';

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, nome, diaVencimento, valor);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$DespesaImplCopyWith<_$DespesaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, data, descricao, valor, pessoa, mes, ano, pago);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$CompraCartaoImplCopyWith<_$CompraCartaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, despesaId, pessoa, mes, ano, pago);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$PagamentoImplCopyWith<_$PagamentoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
