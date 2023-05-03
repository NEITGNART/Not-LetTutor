// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthUserAdapter extends TypeAdapter<AuthUser> {
  @override
  final int typeId = 1;

  @override
  AuthUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthUser(
      id: fields[0] as String?,
      email: fields[1] as String?,
      name: fields[2] as String?,
      avatar: fields[3] as String?,
      country: fields[4] as String?,
      phone: fields[5] as String?,
      roles: (fields[6] as List?)?.cast<String>(),
      language: fields[7] as String?,
      birthday: fields[8] as String?,
      isActivated: fields[9] as bool?,
      walletInfoId: fields[10] as String?,
      walletInfoAmount: fields[11] as String?,
      walletInfoIsBlocked: fields[12] as bool?,
      walletInfoCreatedAt: fields[13] as String?,
      walletInfoUpdatedAt: fields[14] as String?,
      walletInfoBonus: fields[15] as int?,
      requireNote: fields[16] as String?,
      level: fields[17] as String?,
      isPhoneActivated: fields[18] as bool?,
      timezone: fields[19] as int?,
      studySchedule: fields[20] as String?,
      canSendMessage: fields[21] as bool?,
      accessToken: fields[22] as String?,
      accessTokenExpires: fields[23] as String?,
      refreshToken: fields[24] as String?,
      refreshTokenExpires: fields[25] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AuthUser obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.language)
      ..writeByte(8)
      ..write(obj.birthday)
      ..writeByte(9)
      ..write(obj.isActivated)
      ..writeByte(10)
      ..write(obj.walletInfoId)
      ..writeByte(11)
      ..write(obj.walletInfoAmount)
      ..writeByte(12)
      ..write(obj.walletInfoIsBlocked)
      ..writeByte(13)
      ..write(obj.walletInfoCreatedAt)
      ..writeByte(14)
      ..write(obj.walletInfoUpdatedAt)
      ..writeByte(15)
      ..write(obj.walletInfoBonus)
      ..writeByte(16)
      ..write(obj.requireNote)
      ..writeByte(17)
      ..write(obj.level)
      ..writeByte(18)
      ..write(obj.isPhoneActivated)
      ..writeByte(19)
      ..write(obj.timezone)
      ..writeByte(20)
      ..write(obj.studySchedule)
      ..writeByte(21)
      ..write(obj.canSendMessage)
      ..writeByte(22)
      ..write(obj.accessToken)
      ..writeByte(23)
      ..write(obj.accessTokenExpires)
      ..writeByte(24)
      ..write(obj.refreshToken)
      ..writeByte(25)
      ..write(obj.refreshTokenExpires);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
