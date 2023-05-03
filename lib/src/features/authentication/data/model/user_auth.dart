import 'package:hive_flutter/hive_flutter.dart';

part 'user_auth.g.dart';

@HiveType(typeId: 1)
class AuthUser extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? avatar;
  @HiveField(4)
  String? country;
  @HiveField(5)
  String? phone;
  @HiveField(6)
  List<String>? roles;
  @HiveField(7)
  String? language;
  @HiveField(8)
  String? birthday;
  @HiveField(9)
  bool? isActivated;
  @HiveField(10)
  String? walletInfoId;
  @HiveField(11)
  String? walletInfoAmount;
  @HiveField(12)
  bool? walletInfoIsBlocked;
  @HiveField(13)
  String? walletInfoCreatedAt;
  @HiveField(14)
  String? walletInfoUpdatedAt;
  @HiveField(15)
  int? walletInfoBonus;
  @HiveField(16)
  String? requireNote;
  @HiveField(17)
  String? level;
  @HiveField(18)
  bool? isPhoneActivated;
  @HiveField(19)
  int? timezone;
  @HiveField(20)
  String? studySchedule;
  @HiveField(21)
  bool? canSendMessage;
  @HiveField(22)
  String? accessToken;
  @HiveField(23)
  String? accessTokenExpires;
  @HiveField(24)
  String? refreshToken;
  @HiveField(25)
  String? refreshTokenExpires;
  @HiveField(26)
  AuthUser({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    this.isActivated,
    this.walletInfoId,
    this.walletInfoAmount,
    this.walletInfoIsBlocked,
    this.walletInfoCreatedAt,
    this.walletInfoUpdatedAt,
    this.walletInfoBonus,
    this.requireNote,
    this.level,
    this.isPhoneActivated,
    this.timezone,
    this.studySchedule,
    this.canSendMessage,
    this.accessToken,
    this.accessTokenExpires,
    this.refreshToken,
    this.refreshTokenExpires,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    try {
      return AuthUser(
        id: json['user']['id'],
        email: json['user']['email'],
        name: json['user']['name'],
        avatar: json['user']['avatar'],
        country: json['user']['country'],
        phone: json['user']['phone'],
        roles: List<String>.from(json['user']['roles']),
        language: json['user']['language'],
        birthday: json['user']['birthday'],
        isActivated: json['user']['isActivated'],
        walletInfoId: json['user']['walletInfo']['id'],
        walletInfoAmount: json['user']['walletInfo']['amount'],
        walletInfoIsBlocked: json['user']['walletInfo']['isBlocked'],
        walletInfoCreatedAt: json['user']['walletInfo']['createdAt'],
        walletInfoUpdatedAt: json['user']['walletInfo']['updatedAt'],
        walletInfoBonus: json['user']['walletInfo']['bonus'],
        requireNote: json['user']['requireNote'],
        level: json['user']['level'],
        isPhoneActivated: json['user']['isPhoneActivated'],
        timezone: json['user']['timezone'],
        studySchedule: json['user']['studySchedule'],
        canSendMessage: json['user']['canSendMessage'],
        accessToken: json['tokens']['access']['token'],
        accessTokenExpires: json['tokens']['access']['expires'],
        refreshToken: json['tokens']['refresh']['token'],
        refreshTokenExpires: json['tokens']['refresh']['expires'],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
