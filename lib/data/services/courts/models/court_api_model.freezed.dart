// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'court_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourtApiModel {

 int? get id; int get complexId; String get sport; String get name; String get description; int get maxPeople; String get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of CourtApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtApiModelCopyWith<CourtApiModel> get copyWith => _$CourtApiModelCopyWithImpl<CourtApiModel>(this as CourtApiModel, _$identity);

  /// Serializes this CourtApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourtApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexId,sport,name,description,maxPeople,status,createdAt,updatedAt);

@override
String toString() {
  return 'CourtApiModel(id: $id, complexId: $complexId, sport: $sport, name: $name, description: $description, maxPeople: $maxPeople, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CourtApiModelCopyWith<$Res>  {
  factory $CourtApiModelCopyWith(CourtApiModel value, $Res Function(CourtApiModel) _then) = _$CourtApiModelCopyWithImpl;
@useResult
$Res call({
 int? id, int complexId, String sport, String name, String description, int maxPeople, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CourtApiModelCopyWithImpl<$Res>
    implements $CourtApiModelCopyWith<$Res> {
  _$CourtApiModelCopyWithImpl(this._self, this._then);

  final CourtApiModel _self;
  final $Res Function(CourtApiModel) _then;

/// Create a copy of CourtApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? complexId = null,Object? sport = null,Object? name = null,Object? description = null,Object? maxPeople = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CourtApiModel].
extension CourtApiModelPatterns on CourtApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourtApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourtApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourtApiModel value)  $default,){
final _that = this;
switch (_that) {
case _CourtApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourtApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _CourtApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int complexId,  String sport,  String name,  String description,  int maxPeople,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourtApiModel() when $default != null:
return $default(_that.id,_that.complexId,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int complexId,  String sport,  String name,  String description,  int maxPeople,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CourtApiModel():
return $default(_that.id,_that.complexId,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int complexId,  String sport,  String name,  String description,  int maxPeople,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CourtApiModel() when $default != null:
return $default(_that.id,_that.complexId,_that.sport,_that.name,_that.description,_that.maxPeople,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourtApiModel implements CourtApiModel {
  const _CourtApiModel({this.id, required this.complexId, required this.sport, required this.name, required this.description, required this.maxPeople, required this.status, required this.createdAt, required this.updatedAt});
  factory _CourtApiModel.fromJson(Map<String, dynamic> json) => _$CourtApiModelFromJson(json);

@override final  int? id;
@override final  int complexId;
@override final  String sport;
@override final  String name;
@override final  String description;
@override final  int maxPeople;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of CourtApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtApiModelCopyWith<_CourtApiModel> get copyWith => __$CourtApiModelCopyWithImpl<_CourtApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourtApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexId,sport,name,description,maxPeople,status,createdAt,updatedAt);

@override
String toString() {
  return 'CourtApiModel(id: $id, complexId: $complexId, sport: $sport, name: $name, description: $description, maxPeople: $maxPeople, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CourtApiModelCopyWith<$Res> implements $CourtApiModelCopyWith<$Res> {
  factory _$CourtApiModelCopyWith(_CourtApiModel value, $Res Function(_CourtApiModel) _then) = __$CourtApiModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, int complexId, String sport, String name, String description, int maxPeople, String status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CourtApiModelCopyWithImpl<$Res>
    implements _$CourtApiModelCopyWith<$Res> {
  __$CourtApiModelCopyWithImpl(this._self, this._then);

  final _CourtApiModel _self;
  final $Res Function(_CourtApiModel) _then;

/// Create a copy of CourtApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? complexId = null,Object? sport = null,Object? name = null,Object? description = null,Object? maxPeople = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CourtApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
