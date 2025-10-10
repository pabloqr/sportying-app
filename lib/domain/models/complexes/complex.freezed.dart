// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complex.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Complex {

 int? get id; String get name; String get timeIni; String get timeEnd; String get address; double? get locLongitude; double? get locLatitude; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Complex
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplexCopyWith<Complex> get copyWith => _$ComplexCopyWithImpl<Complex>(this as Complex, _$identity);

  /// Serializes this Complex to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Complex&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.timeIni, timeIni) || other.timeIni == timeIni)&&(identical(other.timeEnd, timeEnd) || other.timeEnd == timeEnd)&&(identical(other.address, address) || other.address == address)&&(identical(other.locLongitude, locLongitude) || other.locLongitude == locLongitude)&&(identical(other.locLatitude, locLatitude) || other.locLatitude == locLatitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,timeIni,timeEnd,address,locLongitude,locLatitude,createdAt,updatedAt);

@override
String toString() {
  return 'Complex(id: $id, name: $name, timeIni: $timeIni, timeEnd: $timeEnd, address: $address, locLongitude: $locLongitude, locLatitude: $locLatitude, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ComplexCopyWith<$Res>  {
  factory $ComplexCopyWith(Complex value, $Res Function(Complex) _then) = _$ComplexCopyWithImpl;
@useResult
$Res call({
 int? id, String name, String timeIni, String timeEnd, String address, double? locLongitude, double? locLatitude, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ComplexCopyWithImpl<$Res>
    implements $ComplexCopyWith<$Res> {
  _$ComplexCopyWithImpl(this._self, this._then);

  final Complex _self;
  final $Res Function(Complex) _then;

/// Create a copy of Complex
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? timeIni = null,Object? timeEnd = null,Object? address = null,Object? locLongitude = freezed,Object? locLatitude = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timeIni: null == timeIni ? _self.timeIni : timeIni // ignore: cast_nullable_to_non_nullable
as String,timeEnd: null == timeEnd ? _self.timeEnd : timeEnd // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,locLongitude: freezed == locLongitude ? _self.locLongitude : locLongitude // ignore: cast_nullable_to_non_nullable
as double?,locLatitude: freezed == locLatitude ? _self.locLatitude : locLatitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Complex].
extension ComplexPatterns on Complex {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Complex value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Complex() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Complex value)  $default,){
final _that = this;
switch (_that) {
case _Complex():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Complex value)?  $default,){
final _that = this;
switch (_that) {
case _Complex() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  String timeIni,  String timeEnd,  String address,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Complex() when $default != null:
return $default(_that.id,_that.name,_that.timeIni,_that.timeEnd,_that.address,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  String timeIni,  String timeEnd,  String address,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Complex():
return $default(_that.id,_that.name,_that.timeIni,_that.timeEnd,_that.address,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  String timeIni,  String timeEnd,  String address,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Complex() when $default != null:
return $default(_that.id,_that.name,_that.timeIni,_that.timeEnd,_that.address,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Complex implements Complex {
  const _Complex({this.id, required this.name, required this.timeIni, required this.timeEnd, required this.address, required this.locLongitude, required this.locLatitude, required this.createdAt, required this.updatedAt});
  factory _Complex.fromJson(Map<String, dynamic> json) => _$ComplexFromJson(json);

@override final  int? id;
@override final  String name;
@override final  String timeIni;
@override final  String timeEnd;
@override final  String address;
@override final  double? locLongitude;
@override final  double? locLatitude;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Complex
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplexCopyWith<_Complex> get copyWith => __$ComplexCopyWithImpl<_Complex>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplexToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Complex&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.timeIni, timeIni) || other.timeIni == timeIni)&&(identical(other.timeEnd, timeEnd) || other.timeEnd == timeEnd)&&(identical(other.address, address) || other.address == address)&&(identical(other.locLongitude, locLongitude) || other.locLongitude == locLongitude)&&(identical(other.locLatitude, locLatitude) || other.locLatitude == locLatitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,timeIni,timeEnd,address,locLongitude,locLatitude,createdAt,updatedAt);

@override
String toString() {
  return 'Complex(id: $id, name: $name, timeIni: $timeIni, timeEnd: $timeEnd, address: $address, locLongitude: $locLongitude, locLatitude: $locLatitude, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ComplexCopyWith<$Res> implements $ComplexCopyWith<$Res> {
  factory _$ComplexCopyWith(_Complex value, $Res Function(_Complex) _then) = __$ComplexCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, String timeIni, String timeEnd, String address, double? locLongitude, double? locLatitude, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ComplexCopyWithImpl<$Res>
    implements _$ComplexCopyWith<$Res> {
  __$ComplexCopyWithImpl(this._self, this._then);

  final _Complex _self;
  final $Res Function(_Complex) _then;

/// Create a copy of Complex
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? timeIni = null,Object? timeEnd = null,Object? address = null,Object? locLongitude = freezed,Object? locLatitude = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Complex(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timeIni: null == timeIni ? _self.timeIni : timeIni // ignore: cast_nullable_to_non_nullable
as String,timeEnd: null == timeEnd ? _self.timeEnd : timeEnd // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,locLongitude: freezed == locLongitude ? _self.locLongitude : locLongitude // ignore: cast_nullable_to_non_nullable
as double?,locLatitude: freezed == locLatitude ? _self.locLatitude : locLatitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
