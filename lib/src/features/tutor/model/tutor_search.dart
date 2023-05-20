// ignore_for_file: public_member_api_docs, sort_constructors_first
class TutorInfoSearch {
  String? level;
  String? email;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;

  int? timezone;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? createdAt;
  String? updatedAt;

  String? id;
  String? userId;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  String? schedulestimes;
  String? isfavoritetutor;
  int? price;

  TutorInfoSearch(
      {this.level,
      this.email,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.timezone,
      this.isPhoneAuthActivated,
      this.studySchedule,
      this.canSendMessage,
      this.isPublicRecord,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.userId,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.schedulestimes,
      this.isfavoritetutor,
      this.price});

  TutorInfoSearch.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    email = json['email'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    timezone = json['timezone'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    schedulestimes = json['schedulestimes'];
    isfavoritetutor = json['isfavoritetutor'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['email'] = email;
    data['avatar'] = avatar;
    data['name'] = name;
    data['country'] = country;
    data['phone'] = phone;
    data['language'] = language;
    data['birthday'] = birthday;
    data['requestPassword'] = requestPassword;
    data['isActivated'] = isActivated;
    data['timezone'] = timezone;
    data['isPhoneAuthActivated'] = isPhoneAuthActivated;
    data['studySchedule'] = studySchedule;
    data['canSendMessage'] = canSendMessage;
    data['isPublicRecord'] = isPublicRecord;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    data['userId'] = userId;
    data['video'] = video;
    data['bio'] = bio;
    data['education'] = education;
    data['experience'] = experience;
    data['profession'] = profession;
    data['targetStudent'] = targetStudent;
    data['interests'] = interests;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['rating'] = rating;
    data['schedulestimes'] = schedulestimes;
    data['isfavoritetutor'] = isfavoritetutor;
    data['price'] = price;
    return data;
  }

  @override
  String toString() {
    return 'TutorInfoSearch(level: $level, email: $email, avatar: $avatar, name: $name, country: $country, phone: $phone, language: $language, birthday: $birthday, requestPassword: $requestPassword, isActivated: $isActivated, timezone: $timezone, isPhoneAuthActivated: $isPhoneAuthActivated, studySchedule: $studySchedule, canSendMessage: $canSendMessage, isPublicRecord: $isPublicRecord, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, userId: $userId, video: $video, bio: $bio, education: $education, experience: $experience, profession: $profession, targetStudent: $targetStudent, interests: $interests, languages: $languages, specialties: $specialties, rating: $rating, schedulestimes: $schedulestimes, isfavoritetutor: $isfavoritetutor, price: $price)';
  }
}
