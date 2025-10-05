// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complex_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComplexApiModel {

 int? get id; String get complexName; String get timeIni; String get timeEnd; double? get locLongitude; double? get locLatitude; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ComplexApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplexApiModelCopyWith<ComplexApiModel> get copyWith => _$ComplexApiModelCopyWithImpl<ComplexApiModel>(this as ComplexApiModel, _$identity);

  /// Serializes this ComplexApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplexApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexName, complexName) || other.complexName == complexName)&&(identical(other.timeIni, timeIni) || other.timeIni == timeIni)&&(identical(other.timeEnd, timeEnd) || other.timeEnd == timeEnd)&&(identical(other.locLongitude, locLongitude) || other.locLongitude == locLongitude)&&(identical(other.locLatitude, locLatitude) || other.locLatitude == locLatitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexName,timeIni,timeEnd,locLongitude,locLatitude,createdAt,updatedAt);

@override
String toString() {
  return 'ComplexApiModel(id: $id, complexName: $complexName, timeIni: $timeIni, timeEnd: $timeEnd, locLongitude: $locLongitude, locLatitude: $locLatitude, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ComplexApiModelCopyWith<$Res>  {
  factory $ComplexApiModelCopyWith(ComplexApiModel value, $Res Function(ComplexApiModel) _then) = _$ComplexApiModelCopyWithImpl;
@useResult
$Res call({
 int? id, String complexName, String timeIni, String timeEnd, double? locLongitude, double? locLatitude, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ComplexApiModelCopyWithImpl<$Res>
    implements $ComplexApiModelCopyWith<$Res> {
  _$ComplexApiModelCopyWithImpl(this._self, this._then);

  final ComplexApiModel _self;
  final $Res Function(ComplexApiModel) _then;

/// Create a copy of ComplexApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? complexName = null,Object? timeIni = null,Object? timeEnd = null,Object? locLongitude = freezed,Object? locLatitude = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complexName: null == complexName ? _self.complexName : complexName // ignore: cast_nullable_to_non_nullable
as String,timeIni: null == timeIni ? _self.timeIni : timeIni // ignore: cast_nullable_to_non_nullable
as String,timeEnd: null == timeEnd ? _self.timeEnd : timeEnd // ignore: cast_nullable_to_non_nullable
as String,locLongitude: freezed == locLongitude ? _self.locLongitude : locLongitude // ignore: cast_nullable_to_non_nullable
as double?,locLatitude: freezed == locLatitude ? _self.locLatitude : locLatitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplexApiModel].
extension ComplexApiModelPatterns on ComplexApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplexApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplexApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplexApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ComplexApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplexApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ComplexApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String complexName,  String timeIni,  String timeEnd,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplexApiModel() when $default != null:
return $default(_that.id,_that.complexName,_that.timeIni,_that.timeEnd,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String complexName,  String timeIni,  String timeEnd,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ComplexApiModel():
return $default(_that.id,_that.complexName,_that.timeIni,_that.timeEnd,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String complexName,  String timeIni,  String timeEnd,  double? locLongitude,  double? locLatitude,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ComplexApiModel() when $default != null:
return $default(_that.id,_that.complexName,_that.timeIni,_that.timeEnd,_that.locLongitude,_that.locLatitude,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComplexApiModel implements ComplexApiModel {
  const _ComplexApiModel({this.id, required this.complexName, required this.timeIni, required this.timeEnd, required this.locLongitude, required this.locLatitude, required this.createdAt, required this.updatedAt});
  factory _ComplexApiModel.fromJson(Map<String, dynamic> json) => _$ComplexApiModelFromJson(json);

@override final  int? id;
@override final  String complexName;
@override final  String timeIni;
@override final  String timeEnd;
@override final  double? locLongitude;
@override final  double? locLatitude;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ComplexApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplexApiModelCopyWith<_ComplexApiModel> get copyWith => __$ComplexApiModelCopyWithImpl<_ComplexApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComplexApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplexApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexName, complexName) || other.complexName == complexName)&&(identical(other.timeIni, timeIni) || other.timeIni == timeIni)&&(identical(other.timeEnd, timeEnd) || other.timeEnd == timeEnd)&&(identical(other.locLongitude, locLongitude) || other.locLongitude == locLongitude)&&(identical(other.locLatitude, locLatitude) || other.locLatitude == locLatitude)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexName,timeIni,timeEnd,locLongitude,locLatitude,createdAt,updatedAt);

@override
String toString() {
  return 'ComplexApiModel(id: $id, complexName: $complexName, timeIni: $timeIni, timeEnd: $timeEnd, locLongitude: $locLongitude, locLatitude: $locLatitude, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ComplexApiModelCopyWith<$Res> implements $ComplexApiModelCopyWith<$Res> {
  factory _$ComplexApiModelCopyWith(_ComplexApiModel value, $Res Function(_ComplexApiModel) _then) = __$ComplexApiModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String complexName, String timeIni, String timeEnd, double? locLongitude, double? locLatitude, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ComplexApiModelCopyWithImpl<$Res>
    implements _$ComplexApiModelCopyWith<$Res> {
  __$ComplexApiModelCopyWithImpl(this._self, this._then);

  final _ComplexApiModel _self;
  final $Res Function(_ComplexApiModel) _then;

/// Create a copy of ComplexApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? complexName = null,Object? timeIni = null,Object? timeEnd = null,Object? locLongitude = freezed,Object? locLatitude = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ComplexApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complexName: null == complexName ? _self.complexName : complexName // ignore: cast_nullable_to_non_nullable
as String,timeIni: null == timeIni ? _self.timeIni : timeIni // ignore: cast_nullable_to_non_nullable
as String,timeEnd: null == timeEnd ? _self.timeEnd : timeEnd // ignore: cast_nullable_to_non_nullable
as String,locLongitude: freezed == locLongitude ? _self.locLongitude : locLongitude // ignore: cast_nullable_to_non_nullable
as double?,locLatitude: freezed == locLatitude ? _self.locLatitude : locLatitude // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
