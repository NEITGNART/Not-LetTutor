import 'feedback.dart';

class Tutor {
  String userId;
  String? avatar;
  String? name;
  String? bio;
  String? specialties;
  String? video;
  String? experience;
  String? languages;
  String? interests;
  String? country;
  double? rating;
  bool? isFavorite;
  List<FeedBack>? feedbacks;

  Tutor(
      {required this.userId,
      this.avatar,
      this.name,
      this.bio,
      this.specialties,
      this.rating,
      this.video,
      this.experience,
      this.languages,
      this.interests,
      this.country,
      this.isFavorite,
      this.feedbacks});

  factory Tutor.fromJson(Map<String, dynamic> json) {
    List<FeedBack> feedbacks = [];
    if (json['feedbacks'] != null) {
      for (var v in json['feedbacks']) {
        feedbacks.add(FeedBack.fromJson(v));
      }
    }

    return Tutor(
      userId: json['userId'] ?? json['id'],
      avatar: json['avatar'],
      name: json['name'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      isFavorite: json['isFavorite'],
      country: json['country'],
      feedbacks: feedbacks,
    );
  }

  factory Tutor.fromJson2(Map<String, dynamic> json) {
    return Tutor(
      userId: json['User']['id'],
      avatar: json['User']['avatar'],
      name: json['User']['name'],
      country: json['User']['country'],
      bio: json['bio'],
      specialties: json['specialties'],
      rating: json['rating'],
      video: json['video'],
      experience: json['experience'],
      languages: json['languages'],
      interests: json['interests'],
      isFavorite: json['isFavorite'],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Tutor: {userId: $userId, avatar: $avatar, name: $name, bio: $bio, specialties: $specialties, rating: $rating, isFavorite: $isFavorite, feedbacks: $feedbacks}';
  }
}
