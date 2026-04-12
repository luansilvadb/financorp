// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Despesa {

 String? get id; String get nome;@JsonKey(name: 'dia_vencimento') int get diaVencimento; double get valor;
/// Create a copy of Despesa
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DespesaCopyWith<Despesa> get copyWith => _$DespesaCopyWithImpl<Despesa>(this as Despesa, _$identity);

  /// Serializes this Despesa to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Despesa&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.diaVencimento, diaVencimento) || other.diaVencimento == diaVencimento)&&(identical(other.valor, valor) || other.valor == valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,diaVencimento,valor);

@override
String toString() {
  return 'Despesa(id: $id, nome: $nome, diaVencimento: $diaVencimento, valor: $valor)';
}


}

/// @nodoc
abstract mixin class $DespesaCopyWith<$Res>  {
  factory $DespesaCopyWith(Despesa value, $Res Function(Despesa) _then) = _$DespesaCopyWithImpl;
@useResult
$Res call({
 String? id, String nome,@JsonKey(name: 'dia_vencimento') int diaVencimento, double valor
});




}
/// @nodoc
class _$DespesaCopyWithImpl<$Res>
    implements $DespesaCopyWith<$Res> {
  _$DespesaCopyWithImpl(this._self, this._then);

  final Despesa _self;
  final $Res Function(Despesa) _then;

/// Create a copy of Despesa
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? nome = null,Object? diaVencimento = null,Object? valor = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,diaVencimento: null == diaVencimento ? _self.diaVencimento : diaVencimento // ignore: cast_nullable_to_non_nullable
as int,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Despesa].
extension DespesaPatterns on Despesa {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Despesa value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Despesa() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Despesa value)  $default,){
final _that = this;
switch (_that) {
case _Despesa():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Despesa value)?  $default,){
final _that = this;
switch (_that) {
case _Despesa() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String nome, @JsonKey(name: 'dia_vencimento')  int diaVencimento,  double valor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Despesa() when $default != null:
return $default(_that.id,_that.nome,_that.diaVencimento,_that.valor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String nome, @JsonKey(name: 'dia_vencimento')  int diaVencimento,  double valor)  $default,) {final _that = this;
switch (_that) {
case _Despesa():
return $default(_that.id,_that.nome,_that.diaVencimento,_that.valor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String nome, @JsonKey(name: 'dia_vencimento')  int diaVencimento,  double valor)?  $default,) {final _that = this;
switch (_that) {
case _Despesa() when $default != null:
return $default(_that.id,_that.nome,_that.diaVencimento,_that.valor);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _Despesa implements Despesa {
  const _Despesa({this.id, required this.nome, @JsonKey(name: 'dia_vencimento') required this.diaVencimento, required this.valor});
  factory _Despesa.fromJson(Map<String, dynamic> json) => _$DespesaFromJson(json);

@override final  String? id;
@override final  String nome;
@override@JsonKey(name: 'dia_vencimento') final  int diaVencimento;
@override final  double valor;

/// Create a copy of Despesa
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DespesaCopyWith<_Despesa> get copyWith => __$DespesaCopyWithImpl<_Despesa>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DespesaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Despesa&&(identical(other.id, id) || other.id == id)&&(identical(other.nome, nome) || other.nome == nome)&&(identical(other.diaVencimento, diaVencimento) || other.diaVencimento == diaVencimento)&&(identical(other.valor, valor) || other.valor == valor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nome,diaVencimento,valor);

@override
String toString() {
  return 'Despesa(id: $id, nome: $nome, diaVencimento: $diaVencimento, valor: $valor)';
}


}

/// @nodoc
abstract mixin class _$DespesaCopyWith<$Res> implements $DespesaCopyWith<$Res> {
  factory _$DespesaCopyWith(_Despesa value, $Res Function(_Despesa) _then) = __$DespesaCopyWithImpl;
@override @useResult
$Res call({
 String? id, String nome,@JsonKey(name: 'dia_vencimento') int diaVencimento, double valor
});




}
/// @nodoc
class __$DespesaCopyWithImpl<$Res>
    implements _$DespesaCopyWith<$Res> {
  __$DespesaCopyWithImpl(this._self, this._then);

  final _Despesa _self;
  final $Res Function(_Despesa) _then;

/// Create a copy of Despesa
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? nome = null,Object? diaVencimento = null,Object? valor = null,}) {
  return _then(_Despesa(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,nome: null == nome ? _self.nome : nome // ignore: cast_nullable_to_non_nullable
as String,diaVencimento: null == diaVencimento ? _self.diaVencimento : diaVencimento // ignore: cast_nullable_to_non_nullable
as int,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CompraCartao {

 String? get id; String get data; String get descricao; double get valor; String get pessoa; int get mes; int get ano; bool get pago;
/// Create a copy of CompraCartao
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompraCartaoCopyWith<CompraCartao> get copyWith => _$CompraCartaoCopyWithImpl<CompraCartao>(this as CompraCartao, _$identity);

  /// Serializes this CompraCartao to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompraCartao&&(identical(other.id, id) || other.id == id)&&(identical(other.data, data) || other.data == data)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.valor, valor) || other.valor == valor)&&(identical(other.pessoa, pessoa) || other.pessoa == pessoa)&&(identical(other.mes, mes) || other.mes == mes)&&(identical(other.ano, ano) || other.ano == ano)&&(identical(other.pago, pago) || other.pago == pago));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,data,descricao,valor,pessoa,mes,ano,pago);

@override
String toString() {
  return 'CompraCartao(id: $id, data: $data, descricao: $descricao, valor: $valor, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
}


}

/// @nodoc
abstract mixin class $CompraCartaoCopyWith<$Res>  {
  factory $CompraCartaoCopyWith(CompraCartao value, $Res Function(CompraCartao) _then) = _$CompraCartaoCopyWithImpl;
@useResult
$Res call({
 String? id, String data, String descricao, double valor, String pessoa, int mes, int ano, bool pago
});




}
/// @nodoc
class _$CompraCartaoCopyWithImpl<$Res>
    implements $CompraCartaoCopyWith<$Res> {
  _$CompraCartaoCopyWithImpl(this._self, this._then);

  final CompraCartao _self;
  final $Res Function(CompraCartao) _then;

/// Create a copy of CompraCartao
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? data = null,Object? descricao = null,Object? valor = null,Object? pessoa = null,Object? mes = null,Object? ano = null,Object? pago = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,descricao: null == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,pessoa: null == pessoa ? _self.pessoa : pessoa // ignore: cast_nullable_to_non_nullable
as String,mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as int,ano: null == ano ? _self.ano : ano // ignore: cast_nullable_to_non_nullable
as int,pago: null == pago ? _self.pago : pago // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompraCartao].
extension CompraCartaoPatterns on CompraCartao {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompraCartao value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompraCartao() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompraCartao value)  $default,){
final _that = this;
switch (_that) {
case _CompraCartao():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompraCartao value)?  $default,){
final _that = this;
switch (_that) {
case _CompraCartao() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String data,  String descricao,  double valor,  String pessoa,  int mes,  int ano,  bool pago)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompraCartao() when $default != null:
return $default(_that.id,_that.data,_that.descricao,_that.valor,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String data,  String descricao,  double valor,  String pessoa,  int mes,  int ano,  bool pago)  $default,) {final _that = this;
switch (_that) {
case _CompraCartao():
return $default(_that.id,_that.data,_that.descricao,_that.valor,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String data,  String descricao,  double valor,  String pessoa,  int mes,  int ano,  bool pago)?  $default,) {final _that = this;
switch (_that) {
case _CompraCartao() when $default != null:
return $default(_that.id,_that.data,_that.descricao,_that.valor,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CompraCartao implements CompraCartao {
  const _CompraCartao({this.id, required this.data, required this.descricao, required this.valor, required this.pessoa, required this.mes, required this.ano, this.pago = false});
  factory _CompraCartao.fromJson(Map<String, dynamic> json) => _$CompraCartaoFromJson(json);

@override final  String? id;
@override final  String data;
@override final  String descricao;
@override final  double valor;
@override final  String pessoa;
@override final  int mes;
@override final  int ano;
@override@JsonKey() final  bool pago;

/// Create a copy of CompraCartao
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompraCartaoCopyWith<_CompraCartao> get copyWith => __$CompraCartaoCopyWithImpl<_CompraCartao>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompraCartaoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompraCartao&&(identical(other.id, id) || other.id == id)&&(identical(other.data, data) || other.data == data)&&(identical(other.descricao, descricao) || other.descricao == descricao)&&(identical(other.valor, valor) || other.valor == valor)&&(identical(other.pessoa, pessoa) || other.pessoa == pessoa)&&(identical(other.mes, mes) || other.mes == mes)&&(identical(other.ano, ano) || other.ano == ano)&&(identical(other.pago, pago) || other.pago == pago));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,data,descricao,valor,pessoa,mes,ano,pago);

@override
String toString() {
  return 'CompraCartao(id: $id, data: $data, descricao: $descricao, valor: $valor, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
}


}

/// @nodoc
abstract mixin class _$CompraCartaoCopyWith<$Res> implements $CompraCartaoCopyWith<$Res> {
  factory _$CompraCartaoCopyWith(_CompraCartao value, $Res Function(_CompraCartao) _then) = __$CompraCartaoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String data, String descricao, double valor, String pessoa, int mes, int ano, bool pago
});




}
/// @nodoc
class __$CompraCartaoCopyWithImpl<$Res>
    implements _$CompraCartaoCopyWith<$Res> {
  __$CompraCartaoCopyWithImpl(this._self, this._then);

  final _CompraCartao _self;
  final $Res Function(_CompraCartao) _then;

/// Create a copy of CompraCartao
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? data = null,Object? descricao = null,Object? valor = null,Object? pessoa = null,Object? mes = null,Object? ano = null,Object? pago = null,}) {
  return _then(_CompraCartao(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,descricao: null == descricao ? _self.descricao : descricao // ignore: cast_nullable_to_non_nullable
as String,valor: null == valor ? _self.valor : valor // ignore: cast_nullable_to_non_nullable
as double,pessoa: null == pessoa ? _self.pessoa : pessoa // ignore: cast_nullable_to_non_nullable
as String,mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as int,ano: null == ano ? _self.ano : ano // ignore: cast_nullable_to_non_nullable
as int,pago: null == pago ? _self.pago : pago // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Pagamento {

 String get id;@JsonKey(name: 'despesa_id') String get despesaId; String get pessoa; int get mes; int get ano; bool get pago;
/// Create a copy of Pagamento
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagamentoCopyWith<Pagamento> get copyWith => _$PagamentoCopyWithImpl<Pagamento>(this as Pagamento, _$identity);

  /// Serializes this Pagamento to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pagamento&&(identical(other.id, id) || other.id == id)&&(identical(other.despesaId, despesaId) || other.despesaId == despesaId)&&(identical(other.pessoa, pessoa) || other.pessoa == pessoa)&&(identical(other.mes, mes) || other.mes == mes)&&(identical(other.ano, ano) || other.ano == ano)&&(identical(other.pago, pago) || other.pago == pago));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,despesaId,pessoa,mes,ano,pago);

@override
String toString() {
  return 'Pagamento(id: $id, despesaId: $despesaId, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
}


}

/// @nodoc
abstract mixin class $PagamentoCopyWith<$Res>  {
  factory $PagamentoCopyWith(Pagamento value, $Res Function(Pagamento) _then) = _$PagamentoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'despesa_id') String despesaId, String pessoa, int mes, int ano, bool pago
});




}
/// @nodoc
class _$PagamentoCopyWithImpl<$Res>
    implements $PagamentoCopyWith<$Res> {
  _$PagamentoCopyWithImpl(this._self, this._then);

  final Pagamento _self;
  final $Res Function(Pagamento) _then;

/// Create a copy of Pagamento
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? despesaId = null,Object? pessoa = null,Object? mes = null,Object? ano = null,Object? pago = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,despesaId: null == despesaId ? _self.despesaId : despesaId // ignore: cast_nullable_to_non_nullable
as String,pessoa: null == pessoa ? _self.pessoa : pessoa // ignore: cast_nullable_to_non_nullable
as String,mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as int,ano: null == ano ? _self.ano : ano // ignore: cast_nullable_to_non_nullable
as int,pago: null == pago ? _self.pago : pago // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Pagamento].
extension PagamentoPatterns on Pagamento {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pagamento value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pagamento() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pagamento value)  $default,){
final _that = this;
switch (_that) {
case _Pagamento():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pagamento value)?  $default,){
final _that = this;
switch (_that) {
case _Pagamento() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'despesa_id')  String despesaId,  String pessoa,  int mes,  int ano,  bool pago)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pagamento() when $default != null:
return $default(_that.id,_that.despesaId,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'despesa_id')  String despesaId,  String pessoa,  int mes,  int ano,  bool pago)  $default,) {final _that = this;
switch (_that) {
case _Pagamento():
return $default(_that.id,_that.despesaId,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'despesa_id')  String despesaId,  String pessoa,  int mes,  int ano,  bool pago)?  $default,) {final _that = this;
switch (_that) {
case _Pagamento() when $default != null:
return $default(_that.id,_that.despesaId,_that.pessoa,_that.mes,_that.ano,_that.pago);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _Pagamento implements Pagamento {
  const _Pagamento({required this.id, @JsonKey(name: 'despesa_id') required this.despesaId, required this.pessoa, required this.mes, required this.ano, required this.pago});
  factory _Pagamento.fromJson(Map<String, dynamic> json) => _$PagamentoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'despesa_id') final  String despesaId;
@override final  String pessoa;
@override final  int mes;
@override final  int ano;
@override final  bool pago;

/// Create a copy of Pagamento
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagamentoCopyWith<_Pagamento> get copyWith => __$PagamentoCopyWithImpl<_Pagamento>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PagamentoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pagamento&&(identical(other.id, id) || other.id == id)&&(identical(other.despesaId, despesaId) || other.despesaId == despesaId)&&(identical(other.pessoa, pessoa) || other.pessoa == pessoa)&&(identical(other.mes, mes) || other.mes == mes)&&(identical(other.ano, ano) || other.ano == ano)&&(identical(other.pago, pago) || other.pago == pago));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,despesaId,pessoa,mes,ano,pago);

@override
String toString() {
  return 'Pagamento(id: $id, despesaId: $despesaId, pessoa: $pessoa, mes: $mes, ano: $ano, pago: $pago)';
}


}

/// @nodoc
abstract mixin class _$PagamentoCopyWith<$Res> implements $PagamentoCopyWith<$Res> {
  factory _$PagamentoCopyWith(_Pagamento value, $Res Function(_Pagamento) _then) = __$PagamentoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'despesa_id') String despesaId, String pessoa, int mes, int ano, bool pago
});




}
/// @nodoc
class __$PagamentoCopyWithImpl<$Res>
    implements _$PagamentoCopyWith<$Res> {
  __$PagamentoCopyWithImpl(this._self, this._then);

  final _Pagamento _self;
  final $Res Function(_Pagamento) _then;

/// Create a copy of Pagamento
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? despesaId = null,Object? pessoa = null,Object? mes = null,Object? ano = null,Object? pago = null,}) {
  return _then(_Pagamento(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,despesaId: null == despesaId ? _self.despesaId : despesaId // ignore: cast_nullable_to_non_nullable
as String,pessoa: null == pessoa ? _self.pessoa : pessoa // ignore: cast_nullable_to_non_nullable
as String,mes: null == mes ? _self.mes : mes // ignore: cast_nullable_to_non_nullable
as int,ano: null == ano ? _self.ano : ano // ignore: cast_nullable_to_non_nullable
as int,pago: null == pago ? _self.pago : pago // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
