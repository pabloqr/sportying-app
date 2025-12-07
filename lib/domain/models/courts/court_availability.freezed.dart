// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'court_availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourtAvailabilitySlot {

 DateTime get dateIni; DateTime get dateEnd; bool get available;
/// Create a copy of CourtAvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtAvailabilitySlotCopyWith<CourtAvailabilitySlot> get copyWith => _$CourtAvailabilitySlotCopyWithImpl<CourtAvailabilitySlot>(this as CourtAvailabilitySlot, _$identity);

  /// Serializes this CourtAvailabilitySlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourtAvailabilitySlot&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateIni,dateEnd,available);

@override
String toString() {
  return 'CourtAvailabilitySlot(dateIni: $dateIni, dateEnd: $dateEnd, available: $available)';
}


}

/// @nodoc
abstract mixin class $CourtAvailabilitySlotCopyWith<$Res>  {
  factory $CourtAvailabilitySlotCopyWith(CourtAvailabilitySlot value, $Res Function(CourtAvailabilitySlot) _then) = _$CourtAvailabilitySlotCopyWithImpl;
@useResult
$Res call({
 DateTime dateIni, DateTime dateEnd, bool available
});




}
/// @nodoc
class _$CourtAvailabilitySlotCopyWithImpl<$Res>
    implements $CourtAvailabilitySlotCopyWith<$Res> {
  _$CourtAvailabilitySlotCopyWithImpl(this._self, this._then);

  final CourtAvailabilitySlot _self;
  final $Res Function(CourtAvailabilitySlot) _then;

/// Create a copy of CourtAvailabilitySlot
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


/// Adds pattern-matching-related methods to [CourtAvailabilitySlot].
extension CourtAvailabilitySlotPatterns on CourtAvailabilitySlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourtAvailabilitySlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourtAvailabilitySlot value)  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourtAvailabilitySlot value)?  $default,){
final _that = this;
switch (_that) {
case _CourtAvailabilitySlot() when $default != null:
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
case _CourtAvailabilitySlot() when $default != null:
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
case _CourtAvailabilitySlot():
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
case _CourtAvailabilitySlot() when $default != null:
return $default(_that.dateIni,_that.dateEnd,_that.available);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourtAvailabilitySlot implements CourtAvailabilitySlot {
  const _CourtAvailabilitySlot({required this.dateIni, required this.dateEnd, required this.available});
  factory _CourtAvailabilitySlot.fromJson(Map<String, dynamic> json) => _$CourtAvailabilitySlotFromJson(json);

@override final  DateTime dateIni;
@override final  DateTime dateEnd;
@override final  bool available;

/// Create a copy of CourtAvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtAvailabilitySlotCopyWith<_CourtAvailabilitySlot> get copyWith => __$CourtAvailabilitySlotCopyWithImpl<_CourtAvailabilitySlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtAvailabilitySlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourtAvailabilitySlot&&(identical(other.dateIni, dateIni) || other.dateIni == dateIni)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.available, available) || other.available == available));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateIni,dateEnd,available);

@override
String toString() {
  return 'CourtAvailabilitySlot(dateIni: $dateIni, dateEnd: $dateEnd, available: $available)';
}


}

/// @nodoc
abstract mixin class _$CourtAvailabilitySlotCopyWith<$Res> implements $CourtAvailabilitySlotCopyWith<$Res> {
  factory _$CourtAvailabilitySlotCopyWith(_CourtAvailabilitySlot value, $Res Function(_CourtAvailabilitySlot) _then) = __$CourtAvailabilitySlotCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateIni, DateTime dateEnd, bool available
});




}
/// @nodoc
class __$CourtAvailabilitySlotCopyWithImpl<$Res>
    implements _$CourtAvailabilitySlotCopyWith<$Res> {
  __$CourtAvailabilitySlotCopyWithImpl(this._self, this._then);

  final _CourtAvailabilitySlot _self;
  final $Res Function(_CourtAvailabilitySlot) _then;

/// Create a copy of CourtAvailabilitySlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateIni = null,Object? dateEnd = null,Object? available = null,}) {
  return _then(_CourtAvailabilitySlot(
dateIni: null == dateIni ? _self.dateIni : dateIni // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: null == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CourtAvailability {

 int get id; Complex get complex; List<CourtAvailabilitySlot> get availability;
/// Create a copy of CourtAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourtAvailabilityCopyWith<CourtAvailability> get copyWith => _$CourtAvailabilityCopyWithImpl<CourtAvailability>(this as CourtAvailability, _$identity);

  /// Serializes this CourtAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourtAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.complex, complex) || other.complex == complex)&&const DeepCollectionEquality().equals(other.availability, availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complex,const DeepCollectionEquality().hash(availability));

@override
String toString() {
  return 'CourtAvailability(id: $id, complex: $complex, availability: $availability)';
}


}

/// @nodoc
abstract mixin class $CourtAvailabilityCopyWith<$Res>  {
  factory $CourtAvailabilityCopyWith(CourtAvailability value, $Res Function(CourtAvailability) _then) = _$CourtAvailabilityCopyWithImpl;
@useResult
$Res call({
 int id, Complex complex, List<CourtAvailabilitySlot> availability
});


$ComplexCopyWith<$Res> get complex;

}
/// @nodoc
class _$CourtAvailabilityCopyWithImpl<$Res>
    implements $CourtAvailabilityCopyWith<$Res> {
  _$CourtAvailabilityCopyWithImpl(this._self, this._then);

  final CourtAvailability _self;
  final $Res Function(CourtAvailability) _then;

/// Create a copy of CourtAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? complex = null,Object? availability = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,complex: null == complex ? _self.complex : complex // ignore: cast_nullable_to_non_nullable
as Complex,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as List<CourtAvailabilitySlot>,
  ));
}
/// Create a copy of CourtAvailability
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComplexCopyWith<$Res> get complex {
  
  return $ComplexCopyWith<$Res>(_self.complex, (value) {
    return _then(_self.copyWith(complex: value));
  });
}
}


/// Adds pattern-matching-related methods to [CourtAvailability].
extension CourtAvailabilityPatterns on CourtAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourtAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourtAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourtAvailability value)  $default,){
final _that = this;
switch (_that) {
case _CourtAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourtAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _CourtAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  Complex complex,  List<CourtAvailabilitySlot> availability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourtAvailability() when $default != null:
return $default(_that.id,_that.complex,_that.availability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  Complex complex,  List<CourtAvailabilitySlot> availability)  $default,) {final _that = this;
switch (_that) {
case _CourtAvailability():
return $default(_that.id,_that.complex,_that.availability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  Complex complex,  List<CourtAvailabilitySlot> availability)?  $default,) {final _that = this;
switch (_that) {
case _CourtAvailability() when $default != null:
return $default(_that.id,_that.complex,_that.availability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CourtAvailability implements CourtAvailability {
  const _CourtAvailability({required this.id, required this.complex, required final  List<CourtAvailabilitySlot> availability}): _availability = availability;
  factory _CourtAvailability.fromJson(Map<String, dynamic> json) => _$CourtAvailabilityFromJson(json);

@override final  int id;
@override final  Complex complex;
 final  List<CourtAvailabilitySlot> _availability;
@override List<CourtAvailabilitySlot> get availability {
  if (_availability is EqualUnmodifiableListView) return _availability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availability);
}


/// Create a copy of CourtAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourtAvailabilityCopyWith<_CourtAvailability> get copyWith => __$CourtAvailabilityCopyWithImpl<_CourtAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CourtAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourtAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.complex, complex) || other.complex == complex)&&const DeepCollectionEquality().equals(other._availability, _availability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,complex,const DeepCollectionEquality().hash(_availability));

@override
String toString() {
  return 'CourtAvailability(id: $id, complex: $complex, availability: $availability)';
}


}

/// @nodoc
abstract mixin class _$CourtAvailabilityCopyWith<$Res> implements $CourtAvailabilityCopyWith<$Res> {
  factory _$CourtAvailabilityCopyWith(_CourtAvailability value, $Res Function(_CourtAvailability) _then) = __$CourtAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 int id, Complex complex, List<CourtAvailabilitySlot> availability
});


@override $ComplexCopyWith<$Res> get complex;

}
/// @nodoc
class __$CourtAvailabilityCopyWithImpl<$Res>
    implements _$CourtAvailabilityCopyWith<$Res> {
  __$CourtAvailabilityCopyWithImpl(this._self, this._then);

  final _CourtAvailability _self;
  final $Res Function(_CourtAvailability) _then;

/// Create a copy of CourtAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? complex = null,Object? availability = null,}) {
  return _then(_CourtAvailability(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,complex: null == complex ? _self.complex : complex // ignore: cast_nullable_to_non_nullable
as Complex,availability: null == availability ? _self._availability : availability // ignore: cast_nullable_to_non_nullable
as List<CourtAvailabilitySlot>,
  ));
}

/// Create a copy of CourtAvailability
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
