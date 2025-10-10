// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'court.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Court {

 int? get id; Complex get complex; Sport get sport; String get name; String get description; int get maxPeople; CourtStatus get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtCopyWith<Court> get copyWith => _$CourtCopyWithImpl<Court>(this as Court, _$identity);

  /// Serializes this Court to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Court&&(identical(other.id, id) || other.id == id)&&(identical(other.complex, complex) || other.complex == complex)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complex,sport,name,description,maxPeople,status,createdAt,updatedAt);

@override
String toString() {
  return 'Court(id: $id, complex: $complex, sport: $sport, name: $name, description: $description, maxPeople: $maxPeople, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourtCopyWith<$Res>  {
  factory $CourtCopyWith(Court value, $Res Function(Court) _then) = _$CourtCopyWithImpl;
@useResult
$Res call({
 int? id, Complex complex, Sport sport, String name, String description, int maxPeople, CourtStatus status, DateTime createdAt, DateTime updatedAt
});


$ComplexCopyWith<$Res> get complex;

}
/// @nodoc
class _$CourtCopyWithImpl<$Res>
    implements $CourtCopyWith<$Res> {
  _$CourtCopyWithImpl(this._self, this._then);

  final Court _self;
  final $Res Function(Court) _then;

/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? complex = null,Object? sport = null,Object? name = null,Object? description = null,Object? maxPeople = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complex: null == complex ? _self.complex : complex // ignore: cast_nullable_to_non_nullable
as Complex,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as Sport,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplexCopyWith<$Res> get complex {
  
  return $ComplexCopyWith<$Res>(_self.complex, (value) {
    return _then(_self.copyWith(complex: value));
  });
}
}


/// Adds pattern-matching-related methods to [Court].
extension CourtPatterns on Court {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Court value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Court() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Court value)  $default,){
final _that = this;
switch (_that) {
case _Court():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Court value)?  $default,){
final _that = this;
switch (_that) {
case _Court() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  Complex complex,  Sport sport,  String name,  String description,  int maxPeople,  CourtStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Court() when $default != null:
return $default(_that.id,_that.complex,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  Complex complex,  Sport sport,  String name,  String description,  int maxPeople,  CourtStatus status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Court():
return $default(_that.id,_that.complex,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  Complex complex,  Sport sport,  String name,  String description,  int maxPeople,  CourtStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Court() when $default != null:
return $default(_that.id,_that.complex,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Court implements Court {
  const _Court({this.id, required this.complex, required this.sport, required this.name, required this.description, required this.maxPeople, required this.status, required this.createdAt, required this.updatedAt});
  factory _Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);

@override final  int? id;
@override final  Complex complex;
@override final  Sport sport;
@override final  String name;
@override final  String description;
@override final  int maxPeople;
@override final  CourtStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtCopyWith<_Court> get copyWith => __$CourtCopyWithImpl<_Court>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Court&&(identical(other.id, id) || other.id == id)&&(identical(other.complex, complex) || other.complex == complex)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complex,sport,name,description,maxPeople,status,createdAt,updatedAt);

@override
String toString() {
  return 'Court(id: $id, complex: $complex, sport: $sport, name: $name, description: $description, maxPeople: $maxPeople, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourtCopyWith<$Res> implements $CourtCopyWith<$Res> {
  factory _$CourtCopyWith(_Court value, $Res Function(_Court) _then) = __$CourtCopyWithImpl;
@override @useResult
$Res call({
 int? id, Complex complex, Sport sport, String name, String description, int maxPeople, CourtStatus status, DateTime createdAt, DateTime updatedAt
});


@override $ComplexCopyWith<$Res> get complex;

}
/// @nodoc
class __$CourtCopyWithImpl<$Res>
    implements _$CourtCopyWith<$Res> {
  __$CourtCopyWithImpl(this._self, this._then);

  final _Court _self;
  final $Res Function(_Court) _then;

/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? complex = null,Object? sport = null,Object? name = null,Object? description = null,Object? maxPeople = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Court(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complex: null == complex ? _self.complex : complex // ignore: cast_nullable_to_non_nullable
as Complex,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as Sport,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CourtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Court
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplexCopyWith<$Res> get complex {
  
  return $ComplexCopyWith<$Res>(_self.complex, (value) {
    return _then(_self.copyWith(complex: value));
  });
}
}

// dart format on
