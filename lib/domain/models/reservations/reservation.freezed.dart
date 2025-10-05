// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reservation {

 int? get id; dynamic get userId; int get complexId; int get courtId; DateTime get dateIni; DateTime get dateEnd; AvailabilityStatus get status; ReservationStatus get reservationStatus; TimeFilter get timeFilter; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationCopyWith<Reservation> get copyWith => _$ReservationCopyWithImpl<Reservation>(this as Reservation, _$identity);

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reservation&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.userId, userId)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.courtId, courtId) || other.courtId == courtId)&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservationStatus, reservationStatus) || other.reservationStatus == reservationStatus)&&(identical(other.timeFilter, timeFilter) || other.timeFilter == timeFilter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(userId),complexId,courtId,dateIni,dateEnd,status,reservationStatus,timeFilter,createdAt,updatedAt);

@override
String toString() {
  return 'Reservation(id: $id, userId: $userId, complexId: $complexId, courtId: $courtId, dateIni: $dateIni, dateEnd: $dateEnd, status: $status, reservationStatus: $reservationStatus, timeFilter: $timeFilter, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReservationCopyWith<$Res>  {
  factory $ReservationCopyWith(Reservation value, $Res Function(Reservation) _then) = _$ReservationCopyWithImpl;
@useResult
$Res call({
 int? id, dynamic userId, int complexId, int courtId, DateTime dateIni, DateTime dateEnd, AvailabilityStatus status, ReservationStatus reservationStatus, TimeFilter timeFilter, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ReservationCopyWithImpl<$Res>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._self, this._then);

  final Reservation _self;
  final $Res Function(Reservation) _then;

/// Create a copy of Reservation
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
as AvailabilityStatus,reservationStatus: null == reservationStatus ? _self.reservationStatus : reservationStatus // ignore: cast_nullable_to_non_nullable
as ReservationStatus,timeFilter: null == timeFilter ? _self.timeFilter : timeFilter // ignore: cast_nullable_to_non_nullable
as TimeFilter,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Reservation].
extension ReservationPatterns on Reservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reservation value)  $default,){
final _that = this;
switch (_that) {
case _Reservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reservation value)?  $default,){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  AvailabilityStatus status,  ReservationStatus reservationStatus,  TimeFilter timeFilter,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  AvailabilityStatus status,  ReservationStatus reservationStatus,  TimeFilter timeFilter,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Reservation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  dynamic userId,  int complexId,  int courtId,  DateTime dateIni,  DateTime dateEnd,  AvailabilityStatus status,  ReservationStatus reservationStatus,  TimeFilter timeFilter,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.userId,_that.complexId,_that.courtId,_that.dateIni,_that.dateEnd,_that.status,_that.reservationStatus,_that.timeFilter,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reservation implements Reservation {
  const _Reservation({this.id, required this.userId, required this.complexId, required this.courtId, required this.dateIni, required this.dateEnd, required this.status, required this.reservationStatus, required this.timeFilter, required this.createdAt, required this.updatedAt});
  factory _Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

@override final  int? id;
@override final  dynamic userId;
@override final  int complexId;
@override final  int courtId;
@override final  DateTime dateIni;
@override final  DateTime dateEnd;
@override final  AvailabilityStatus status;
@override final  ReservationStatus reservationStatus;
@override final  TimeFilter timeFilter;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationCopyWith<_Reservation> get copyWith => __$ReservationCopyWithImpl<_Reservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reservation&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.userId, userId)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&(identical(other.courtId, courtId) || other.courtId == courtId)&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.status, status) || other.status == status)&&(identical(other.reservationStatus, reservationStatus) || other.reservationStatus == reservationStatus)&&(identical(other.timeFilter, timeFilter) || other.timeFilter == timeFilter)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(userId),complexId,courtId,dateIni,dateEnd,status,reservationStatus,timeFilter,createdAt,updatedAt);

@override
String toString() {
  return 'Reservation(id: $id, userId: $userId, complexId: $complexId, courtId: $courtId, dateIni: $dateIni, dateEnd: $dateEnd, status: $status, reservationStatus: $reservationStatus, timeFilter: $timeFilter, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReservationCopyWith<$Res> implements $ReservationCopyWith<$Res> {
  factory _$ReservationCopyWith(_Reservation value, $Res Function(_Reservation) _then) = __$ReservationCopyWithImpl;
@override @useResult
$Res call({
 int? id, dynamic userId, int complexId, int courtId, DateTime dateIni, DateTime dateEnd, AvailabilityStatus status, ReservationStatus reservationStatus, TimeFilter timeFilter, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ReservationCopyWithImpl<$Res>
    implements _$ReservationCopyWith<$Res> {
  __$ReservationCopyWithImpl(this._self, this._then);

  final _Reservation _self;
  final $Res Function(_Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? complexId = null,Object? courtId = null,Object? dateIni = null,Object? dateEnd = null,Object? status = null,Object? reservationStatus = null,Object? timeFilter = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Reservation(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as dynamic,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,courtId: null == courtId ? _self.courtId : courtId // ignore: cast_nullable_to_non_nullable
as int,dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AvailabilityStatus,reservationStatus: null == reservationStatus ? _self.reservationStatus : reservationStatus // ignore: cast_nullable_to_non_nullable
as ReservationStatus,timeFilter: null == timeFilter ? _self.timeFilter : timeFilter // ignore: cast_nullable_to_non_nullable
as TimeFilter,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
