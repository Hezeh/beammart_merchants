// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    userId: json['userId'] as String,
    storeId: json['storeId'] as String,
    businessName: json['businessName'] as String,
    phoneNumber: json['phoneNumber'] as String,
    businessDescription: json['businessDescription'] as String,
    mondayOpeningHours: json['mondayOpeningHours'] as String,
    mondayClosingHours: json['mondayClosingHours'] as String,
    tuesdayOpeningHours: json['tuesdayOpeningHours'] as String,
    tuesdayClosingHours: json['tuesdayClosingHours'] as String,
    wednesdayOpeningHours: json['wednesdayOpeningHours'] as String,
    wednesdayClosingHours: json['wednesdayClosingHours'] as String,
    thursdayOpeningHours: json['thursdayOpeningHours'] as String,
    thursdayClosingHours: json['thursdayClosingHours'] as String,
    fridayOpeningHours: json['fridayOpeningHours'] as String,
    fridayClosingHours: json['fridayClosingHours'] as String,
    saturdayOpeningHours: json['saturdayOpeningHours'] as String,
    saturdayClosingHours: json['saturdayClosingHours'] as String,
    sundayOpeningHours: json['sundayOpeningHours'] as String,
    sundayClosingHours: json['sundayClosingHours'] as String,
    city: json['city'] as String,
    locationDescription: json['locationDescription'] as String,
    gpsLocation: Profile._fromJsonGeoPoint(json['gpsLocation'] as GeoPoint),
    isMondayOpen: json['isMondayOpen'] as bool,
    isTuesdayOpen: json['isTuesdayOpen'] as bool,
    isWednesdayOpen: json['isWednesdayOpen'] as bool,
    isThursdayOpen: json['isThursdayOpen'] as bool,
    isFridayOpen: json['isFridayOpen'] as bool,
    isSaturdayOpen: json['isSaturdayOpen'] as bool,
    isSundayOpen: json['isSundayOpen'] as bool,
    businessProfilePhoto: json['businessProfilePhoto'] as String,
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'city': instance.city,
      'locationDescription': instance.locationDescription,
      'gpsLocation': Profile._toJsonGeoPoint(instance.gpsLocation),
      'storeId': instance.storeId,
      'businessName': instance.businessName,
      'phoneNumber': instance.phoneNumber,
      'businessDescription': instance.businessDescription,
      'mondayOpeningHours': instance.mondayOpeningHours,
      'mondayClosingHours': instance.mondayClosingHours,
      'tuesdayOpeningHours': instance.tuesdayOpeningHours,
      'tuesdayClosingHours': instance.tuesdayClosingHours,
      'wednesdayOpeningHours': instance.wednesdayOpeningHours,
      'wednesdayClosingHours': instance.wednesdayClosingHours,
      'thursdayOpeningHours': instance.thursdayOpeningHours,
      'thursdayClosingHours': instance.thursdayClosingHours,
      'fridayOpeningHours': instance.fridayOpeningHours,
      'fridayClosingHours': instance.fridayClosingHours,
      'saturdayOpeningHours': instance.saturdayOpeningHours,
      'saturdayClosingHours': instance.saturdayClosingHours,
      'sundayOpeningHours': instance.sundayOpeningHours,
      'sundayClosingHours': instance.sundayClosingHours,
      'userId': instance.userId,
      'isMondayOpen': instance.isMondayOpen,
      'isTuesdayOpen': instance.isTuesdayOpen,
      'isWednesdayOpen': instance.isWednesdayOpen,
      'isThursdayOpen': instance.isThursdayOpen,
      'isFridayOpen': instance.isFridayOpen,
      'isSaturdayOpen': instance.isSaturdayOpen,
      'isSundayOpen': instance.isSundayOpen,
      'businessProfilePhoto': instance.businessProfilePhoto,
    };
