// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationApiModel {

 int? get id; dynamic get userId; int get complexId; int get courtId; DateTime get dateIni; DateTime get dateEnd; String get status; String get reservationStatus; String get timeFilter; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ReservationApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationApiModelCopyWith<ReservationApiModel> get copyWith => _$ReservationApiModelCopyWithImpl<ReservationApiModel>(this as ReservationApiModel, _$identity);

  /// Serializes this ReservationApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationApiModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.userId, userId)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.courtId, courtId) || other.courtId == courtId)&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservationStatus, reservationStatus) || other.reservationStatus == reservationStatus)&&(identical(other.timeFilter, timeFilter) || other.timeFilter == timeFilter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(userId),complexId,courtId,dateIni,dateEnd,status,reservationStatus,timeFilter,createdAt,updatedAt);

@override
String toString() {
  return 'ReservationApiModel(id: $id, userId: $userId, complexId: $complexId, courtId: $courtId, dateIni: $dateIni, dateEnd: $dateEnd, status: $status, reservationStatus: $reservationStatus, timeFilter: $timeFilter, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReservationApiModelCopyWith<$Res>  {
  factory $ReservationApiModelCopyWith(ReservationApiModel value, $Res Function(ReservationApiModel) _then) = _$ReservationApiModelCopyWithImpl;
@useResult
$Res call({
 int? id, dynamic userId, int complexId, int courtId, DateTime dateIni, DateTime dateEnd, String status, String reservationStatus, String timeFilter, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ReservationApiModelCopyWithImpl<$Res>
    implements $ReservationApiModelCopyWith<$Res> {
  _$ReservationApiModelCopyWithImpl(this._self, this._then);

  final ReservationApiModel _self;
  final $Res Function(ReservationApiModel) _then;

/// Create a copy of ReservationApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? complexId = null,Object? courtId = null,Object? dateIni = null,Object? dateEnd = null,Object? status = null,Object? reservationStatus = null,Object? timeFilter = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as dynamic,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,courtId: null == courtId ? _self.courtId : courtId // ignore: cast_nullable_to_non_nullable
as int,dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reservationStatus: null == reservationStatus ? _self.reservationStatus : reservationStatus // ignore: cast_nullable_to_non_nullable
as String,timeFilter: null == timeFilter ? _self.timeFilter : timeFilter // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReservationApiModel].
extension ReservationApiModelPatterns on ReservationApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ReservationApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  String status,  String reservationStatus,  String timeFilter,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationApiModel() when $default != null:
return $default(_that.id,_that.userId,_that.complexId,_that.courtId,_that.dateIni,_that.dateEnd,_that.status,_that.reservationStatus,_that.timeFilter,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  String status,  String reservationStatus,  String timeFilter,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReservationApiModel():
return $default(_that.id,_that.userId,_that.complexId,_that.courtId,_that.dateIni,_that.dateEnd,_that.status,_that.reservationStatus,_that.timeFilter,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  String status,  String reservationStatus,  String timeFilter,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReservationApiModel() when $default != null:
return $default(_that.id,_that.userId,_that.complexId,_that.courtId,_that.dateIni,_that.dateEnd,_that.status,_that.reservationStatus,_that.timeFilter,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationApiModel implements ReservationApiModel {
  const _ReservationApiModel({this.id, required this.userId, required this.complexId, required this.courtId, required this.dateIni, required this.dateEnd, required this.status, required this.reservationStatus, required this.timeFilter, required this.createdAt, required this.updatedAt});
  factory _ReservationApiModel.fromJson(Map<String, dynamic> json) => _$ReservationApiModelFromJson(json);

@override final  int? id;
@override final  dynamic userId;
@override final  int complexId;
@override final  int courtId;
@override final  DateTime dateIni;
@override final  DateTime dateEnd;
@override final  String status;
@override final  String reservationStatus;
@override final  String timeFilter;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ReservationApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationApiModelCopyWith<_ReservationApiModel> get copyWith => __$ReservationApiModelCopyWithImpl<_ReservationApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationApiModel&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.userId, userId)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.courtId, courtId) || other.courtId == courtId)&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservationStatus, reservationStatus) || other.reservationStatus == reservationStatus)&&(identical(other.timeFilter, timeFilter) || other.timeFilter == timeFilter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(userId),complexId,courtId,dateIni,dateEnd,status,reservationStatus,timeFilter,createdAt,updatedAt);

@override
String toString() {
  return 'ReservationApiModel(id: $id, userId: $userId, complexId: $complexId, courtId: $courtId, dateIni: $dateIni, dateEnd: $dateEnd, status: $status, reservationStatus: $reservationStatus, timeFilter: $timeFilter, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReservationApiModelCopyWith<$Res> implements $ReservationApiModelCopyWith<$Res> {
  factory _$ReservationApiModelCopyWith(_ReservationApiModel value, $Res Function(_ReservationApiModel) _then) = __$ReservationApiModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, dynamic userId, int complexId, int courtId, DateTime dateIni, DateTime dateEnd, String status, String reservationStatus, String timeFilter, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ReservationApiModelCopyWithImpl<$Res>
    implements _$ReservationApiModelCopyWith<$Res> {
  __$ReservationApiModelCopyWithImpl(this._self, this._then);

  final _ReservationApiModel _self;
  final $Res Function(_ReservationApiModel) _then;

/// Create a copy of ReservationApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? complexId = null,Object? courtId = null,Object? dateIni = null,Object? dateEnd = null,Object? status = null,Object? reservationStatus = null,Object? timeFilter = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ReservationApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as dynamic,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,courtId: null == courtId ? _self.courtId : courtId // ignore: cast_nullable_to_non_nullable
as int,dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,reservationStatus: null == reservationStatus ? _self.reservationStatus : reservationStatus // ignore: cast_nullable_to_non_nullable
as String,timeFilter: null == timeFilter ? _self.timeFilter : timeFilter // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
