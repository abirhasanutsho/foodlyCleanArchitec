// To parse this JSON data, do
//
//     final profileEntity = profileEntityFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  String? status;
  String? message;
  Data? data;

  ProfileEntity({
    this.status,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}

class Data {
  String? id;
  String? uuid;
  String? mobile;
  String? accountId;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? mobileVerifiedAt;
  String? fullName;
  bool? isPin;
  List<Wallet>? wallets;
  AgentDetail? agentDetail;

  Data({
    this.id,
    this.uuid,
    this.mobile,
    this.accountId,
    this.email,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.fullName,
    this.isPin,
    this.wallets,
    this.agentDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        mobile: json["mobile"],
        accountId: json["account_id"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        mobileVerifiedAt: json["mobile_verified_at"] == null
            ? null
            : DateTime.parse(json["mobile_verified_at"]),
        fullName: json["full_name"],
        isPin: json["is_pin"],
        wallets: json["wallets"] == null
            ? []
            : List<Wallet>.from(
                json["wallets"]!.map((x) => Wallet.fromJson(x))),
        agentDetail: json["agentDetail"] == null
            ? null
            : AgentDetail.fromJson(json["agentDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "mobile": mobile,
        "account_id": accountId,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "mobile_verified_at": mobileVerifiedAt?.toIso8601String(),
        "full_name": fullName,
        "is_pin": isPin,
        "wallets": wallets == null
            ? []
            : List<dynamic>.from(wallets!.map((x) => x.toJson())),
        "agentDetail": agentDetail?.toJson(),
      };
}

class AgentDetail {
  String? uuid;
  String? firstName;
  String? lastName;
  dynamic dob;
  dynamic idType;
  dynamic idNumber;
  dynamic identityVerifiedAt;
  dynamic identityStatus;
  dynamic address;
  int? countryId;
  String? country;
  String? countryFlag;
  String? state;
  String? city;
  String? gender;
  dynamic zipCode;
  dynamic district;
  String? userAvatar;
  String? twoFactorAuthStatus;
  String? twoFactorAuthType;
  bool? google2Fa;

  AgentDetail({
    this.uuid,
    this.firstName,
    this.lastName,
    this.dob,
    this.idType,
    this.idNumber,
    this.identityVerifiedAt,
    this.identityStatus,
    this.address,
    this.countryId,
    this.country,
    this.countryFlag,
    this.state,
    this.city,
    this.gender,
    this.zipCode,
    this.district,
    this.userAvatar,
    this.twoFactorAuthStatus,
    this.twoFactorAuthType,
    this.google2Fa,
  });

  factory AgentDetail.fromJson(Map<String, dynamic> json) => AgentDetail(
        uuid: json["uuid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dob: json["dob"],
        idType: json["id_type"],
        idNumber: json["id_number"],
        identityVerifiedAt: json["identity_verified_at"],
        identityStatus: json["identity_status"],
        address: json["address"],
        countryId: json["country_id"],
        country: json["country"],
        countryFlag: json["country_flag"],
        state: json["state"],
        city: json["city"],
        gender: json["gender"],
        zipCode: json["zip_code"],
        district: json["district"],
        userAvatar: json["user_avatar"],
        twoFactorAuthStatus: json["two_factor_auth_status"],
        twoFactorAuthType: json["two_factor_auth_type"],
        google2Fa: json["google2fa"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "first_name": firstName,
        "last_name": lastName,
        "dob": dob,
        "id_type": idType,
        "id_number": idNumber,
        "identity_verified_at": identityVerifiedAt,
        "identity_status": identityStatus,
        "address": address,
        "country_id": countryId,
        "country": country,
        "country_flag": countryFlag,
        "state": state,
        "city": city,
        "gender": gender,
        "zip_code": zipCode,
        "district": district,
        "user_avatar": userAvatar,
        "two_factor_auth_status": twoFactorAuthStatus,
        "two_factor_auth_type": twoFactorAuthType,
        "google2fa": google2Fa,
      };
}

class Wallet {
  String? uuid;
  double? balance;
  int? commission;
  int? currencyId;
  String? walletNumber;
  int? status;
  int? walletDefault;
  int? isBase;
  Currency? currency;

  Wallet({
    this.uuid,
    this.balance,
    this.commission,
    this.currencyId,
    this.walletNumber,
    this.status,
    this.walletDefault,
    this.isBase,
    this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        uuid: json["uuid"],
        balance: json["balance"]?.toDouble(),
        commission: json["commission"],
        currencyId: json["currency_id"],
        walletNumber: json["wallet_number"],
        status: json["status"],
        walletDefault: json["default"],
        isBase: json["is_base"],
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "balance": balance,
        "commission": commission,
        "currency_id": currencyId,
        "wallet_number": walletNumber,
        "status": status,
        "default": walletDefault,
        "is_base": isBase,
        "currency": currency?.toJson(),
      };
}

class Currency {
  int? id;
  String? name;
  String? code;
  String? symbol;

  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "symbol": symbol,
      };
}
