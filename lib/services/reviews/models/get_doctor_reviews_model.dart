class DoctorReviewsModel {
  List<Reviews>? reviews;
  bool? success;
  int? totalReviews;

  DoctorReviewsModel({this.reviews, this.success, this.totalReviews});

  DoctorReviewsModel.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    success = json['success'];
    totalReviews = json['total_reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['total_reviews'] = this.totalReviews;
    return data;
  }
}

class Reviews {
  String? avatar;
  String? comment;
  String? name;
  int? stars;

  Reviews({this.avatar, this.comment, this.name, this.stars});

  Reviews.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    comment = json['comment'];
    name = json['name'];
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['comment'] = this.comment;
    data['name'] = this.name;
    data['stars'] = this.stars;
    return data;
  }
}
