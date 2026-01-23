// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'court_availability_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourtAvailabilitySlotApiModel {

 DateTime get dateIni; DateTime get dateEnd; bool get available;
/// Create a copy of CourtAvailabilitySlotApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtAvailabilitySlotApiModelCopyWith<CourtAvailabilitySlotApiModel> get copyWith => _$CourtAvailabilitySlotApiModelCopyWithImpl<CourtAvailabilitySlotApiModel>(this as CourtAvailabilitySlotApiModel, _$identity);

  /// Serializes this CourtAvailabilitySlotApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourtAvailabilitySlotApiModel&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateIni,dateEnd,available);

@override
String toString() {
  return 'CourtAvailabilitySlotApiModel(dateIni: $dateIni, dateEnd: $dateEnd, available: $available)';
}


}

/// @nodoc
abstract mixin class $CourtAvailabilitySlotApiModelCopyWith<$Res>  {
  factory $CourtAvailabilitySlotApiModelCopyWith(CourtAvailabilitySlotApiModel value, $Res Function(CourtAvailabilitySlotApiModel) _then) = _$CourtAvailabilitySlotApiModelCopyWithImpl;
@useResult
$Res call({
 DateTime dateIni, DateTime dateEnd, bool available
});




}
/// @nodoc
class _$CourtAvailabilitySlotApiModelCopyWithImpl<$Res>
    implements $CourtAvailabilitySlotApiModelCopyWith<$Res> {
  _$CourtAvailabilitySlotApiModelCopyWithImpl(this._self, this._then);

  final CourtAvailabilitySlotApiModel _self;
  final $Res Function(CourtAvailabilitySlotApiModel) _then;

/// Create a copy of CourtAvailabilitySlotApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateIni = null,Object? dateEnd = null,Object? available = null,}) {
  return _then(_self.copyWith(
dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CourtAvailabilitySlotApiModel].
extension CourtAvailabilitySlotApiModelPatterns on CourtAvailabilitySlotApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourtAvailabilitySlotApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourtAvailabilitySlotApiModel value)  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourtAvailabilitySlotApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dateIni,  DateTime dateEnd,  bool available)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel() when $default != null:
return $default(_that.dateIni,_that.dateEnd,_that.available);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dateIni,  DateTime dateEnd,  bool available)  $default,) {final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel():
return $default(_that.dateIni,_that.dateEnd,_that.available);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dateIni,  DateTime dateEnd,  bool available)?  $default,) {final _that = this;
switch (_that) {
case _CourtAvailabilitySlotApiModel() when $default != null:
return $default(_that.dateIni,_that.dateEnd,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourtAvailabilitySlotApiModel implements CourtAvailabilitySlotApiModel {
  const _CourtAvailabilitySlotApiModel({required this.dateIni, required this.dateEnd, required this.available});
  factory _CourtAvailabilitySlotApiModel.fromJson(Map<String, dynamic> json) => _$CourtAvailabilitySlotApiModelFromJson(json);

@override final  DateTime dateIni;
@override final  DateTime dateEnd;
@override final  bool available;

/// Create a copy of CourtAvailabilitySlotApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtAvailabilitySlotApiModelCopyWith<_CourtAvailabilitySlotApiModel> get copyWith => __$CourtAvailabilitySlotApiModelCopyWithImpl<_CourtAvailabilitySlotApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtAvailabilitySlotApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourtAvailabilitySlotApiModel&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateIni,dateEnd,available);

@override
String toString() {
  return 'CourtAvailabilitySlotApiModel(dateIni: $dateIni, dateEnd: $dateEnd, available: $available)';
}


}

/// @nodoc
abstract mixin class _$CourtAvailabilitySlotApiModelCopyWith<$Res> implements $CourtAvailabilitySlotApiModelCopyWith<$Res> {
  factory _$CourtAvailabilitySlotApiModelCopyWith(_CourtAvailabilitySlotApiModel value, $Res Function(_CourtAvailabilitySlotApiModel) _then) = __$CourtAvailabilitySlotApiModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateIni, DateTime dateEnd, bool available
});




}
/// @nodoc
class __$CourtAvailabilitySlotApiModelCopyWithImpl<$Res>
    implements _$CourtAvailabilitySlotApiModelCopyWith<$Res> {
  __$CourtAvailabilitySlotApiModelCopyWithImpl(this._self, this._then);

  final _CourtAvailabilitySlotApiModel _self;
  final $Res Function(_CourtAvailabilitySlotApiModel) _then;

/// Create a copy of CourtAvailabilitySlotApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateIni = null,Object? dateEnd = null,Object? available = null,}) {
  return _then(_CourtAvailabilitySlotApiModel(
dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CourtAvailabilityApiModel {

 int get id; int get complexId; List<CourtAvailabilitySlotApiModel> get availability;
/// Create a copy of CourtAvailabilityApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtAvailabilityApiModelCopyWith<CourtAvailabilityApiModel> get copyWith => _$CourtAvailabilityApiModelCopyWithImpl<CourtAvailabilityApiModel>(this as CourtAvailabilityApiModel, _$identity);

  /// Serializes this CourtAvailabilityApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourtAvailabilityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&const DeepCollectionEquality().equals(other.availability, availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexId,const DeepCollectionEquality().hash(availability));

@override
String toString() {
  return 'CourtAvailabilityApiModel(id: $id, complexId: $complexId, availability: $availability)';
}


}

/// @nodoc
abstract mixin class $CourtAvailabilityApiModelCopyWith<$Res>  {
  factory $CourtAvailabilityApiModelCopyWith(CourtAvailabilityApiModel value, $Res Function(CourtAvailabilityApiModel) _then) = _$CourtAvailabilityApiModelCopyWithImpl;
@useResult
$Res call({
 int id, int complexId, List<CourtAvailabilitySlotApiModel> availability
});




}
/// @nodoc
class _$CourtAvailabilityApiModelCopyWithImpl<$Res>
    implements $CourtAvailabilityApiModelCopyWith<$Res> {
  _$CourtAvailabilityApiModelCopyWithImpl(this._self, this._then);

  final CourtAvailabilityApiModel _self;
  final $Res Function(CourtAvailabilityApiModel) _then;

/// Create a copy of CourtAvailabilityApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? complexId = null,Object? availability = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as List<CourtAvailabilitySlotApiModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CourtAvailabilityApiModel].
extension CourtAvailabilityApiModelPatterns on CourtAvailabilityApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourtAvailabilityApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourtAvailabilityApiModel value)  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourtAvailabilityApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int complexId,  List<CourtAvailabilitySlotApiModel> availability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel() when $default != null:
return $default(_that.id,_that.complexId,_that.availability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int complexId,  List<CourtAvailabilitySlotApiModel> availability)  $default,) {final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel():
return $default(_that.id,_that.complexId,_that.availability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int complexId,  List<CourtAvailabilitySlotApiModel> availability)?  $default,) {final _that = this;
switch (_that) {
case _CourtAvailabilityApiModel() when $default != null:
return $default(_that.id,_that.complexId,_that.availability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourtAvailabilityApiModel implements CourtAvailabilityApiModel {
  const _CourtAvailabilityApiModel({required this.id, required this.complexId, required final  List<CourtAvailabilitySlotApiModel> availability}): _availability = availability;
  factory _CourtAvailabilityApiModel.fromJson(Map<String, dynamic> json) => _$CourtAvailabilityApiModelFromJson(json);

@override final  int id;
@override final  int complexId;
 final  List<CourtAvailabilitySlotApiModel> _availability;
@override List<CourtAvailabilitySlotApiModel> get availability {
  if (_availability is EqualUnmodifiableListView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availability);
}


/// Create a copy of CourtAvailabilityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtAvailabilityApiModelCopyWith<_CourtAvailabilityApiModel> get copyWith => __$CourtAvailabilityApiModelCopyWithImpl<_CourtAvailabilityApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtAvailabilityApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourtAvailabilityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.complexId, complexId) || other.complexId == complexId)&&const DeepCollectionEquality().equals(other._availability, _availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complexId,const DeepCollectionEquality().hash(_availability));

@override
String toString() {
  return 'CourtAvailabilityApiModel(id: $id, complexId: $complexId, availability: $availability)';
}


}

/// @nodoc
abstract mixin class _$CourtAvailabilityApiModelCopyWith<$Res> implements $CourtAvailabilityApiModelCopyWith<$Res> {
  factory _$CourtAvailabilityApiModelCopyWith(_CourtAvailabilityApiModel value, $Res Function(_CourtAvailabilityApiModel) _then) = __$CourtAvailabilityApiModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int complexId, List<CourtAvailabilitySlotApiModel> availability
});




}
/// @nodoc
class __$CourtAvailabilityApiModelCopyWithImpl<$Res>
    implements _$CourtAvailabilityApiModelCopyWith<$Res> {
  __$CourtAvailabilityApiModelCopyWithImpl(this._self, this._then);

  final _CourtAvailabilityApiModel _self;
  final $Res Function(_CourtAvailabilityApiModel) _then;

/// Create a copy of CourtAvailabilityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? complexId = null,Object? availability = null,}) {
  return _then(_CourtAvailabilityApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,complexId: null == complexId ? _self.complexId : complexId // ignore: cast_nullable_to_non_nullable
as int,availability: null == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as List<CourtAvailabilitySlotApiModel>,
  ));
}


}

// dart format on
