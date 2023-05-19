class TutorReview {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  FirstInfo? firstInfo;

  TutorReview(
      {this.id,
      this.bookingId,
      this.firstId,
      this.secondId,
      this.rating,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.firstInfo});

  TutorReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    rating = json['rating'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo = json['firstInfo'] != null
        ? FirstInfo.fromJson(json['firstInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['firstId'] = firstId;
    data['secondId'] = secondId;
    data['rating'] = rating;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (firstInfo != null) {
      data['firstInfo'] = firstInfo!.toJson();
    }
    return data;
  }
}

class FirstInfo {
  String? name;
  String? avatar;

  FirstInfo({this.name, this.avatar});

  FirstInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
