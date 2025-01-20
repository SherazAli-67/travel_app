class ReviewResponse {
  final List<Review> data;

  ReviewResponse({required this.data});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      data: List<Review>.from(json['data'].map((x) => Review.fromJson(x))),
    );
  }
}

class Review {
  final int id;
  final String lang;
  final int locationId;
  final String publishedDate;
  final int rating;
  final int helpfulVotes;
  final String ratingImageUrl;
  final String url;
  final String text;
  final String title;
  final String tripType;
  final String travelDate;
  final User user;
  final Map<String, SubRating>? subratings;
  final OwnerResponse? ownerResponse;

  Review({
    required this.id,
    required this.lang,
    required this.locationId,
    required this.publishedDate,
    required this.rating,
    required this.helpfulVotes,
    required this.ratingImageUrl,
    required this.url,
    required this.text,
    required this.title,
    required this.tripType,
    required this.travelDate,
    required this.user,
    this.subratings,
    this.ownerResponse,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      lang: json['lang'],
      locationId: json['location_id'],
      publishedDate: json['published_date'],
      rating: json['rating'],
      helpfulVotes: json['helpful_votes'],
      ratingImageUrl: json['rating_image_url'],
      url: json['url'],
      text: json['text'],
      title: json['title'],
      tripType: json['trip_type'],
      travelDate: json['travel_date'],
      user: User.fromJson(json['user']),
      subratings: json['subratings'] != null
          ? (json['subratings'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, SubRating.fromJson(value)),
      )
          : null,
      ownerResponse: json['owner_response'] != null
          ? OwnerResponse.fromJson(json['owner_response'])
          : null,
    );
  }
}

class User {
  final String username;
  final UserLocation? userLocation;
  final Avatar avatar;

  User({required this.username, this.userLocation, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      userLocation: json['user_location']['id'] != "null"
          ? UserLocation.fromJson(json['user_location'])
          : null,
      avatar: Avatar.fromJson(json['avatar']),
    );
  }
}

class UserLocation {
  final String id;
  final String? name;

  UserLocation({required this.id, this.name});

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Avatar {
  final String thumbnail;
  final String small;
  final String medium;
  final String large;
  final String original;

  Avatar({
    required this.thumbnail,
    required this.small,
    required this.medium,
    required this.large,
    required this.original,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      thumbnail: json['thumbnail'],
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
      original: json['original'],
    );
  }
}

class SubRating {
  final String name;
  final String ratingImageUrl;
  final int value;
  final String localizedName;

  SubRating({
    required this.name,
    required this.ratingImageUrl,
    required this.value,
    required this.localizedName,
  });

  factory SubRating.fromJson(Map<String, dynamic> json) {
    return SubRating(
      name: json['name'],
      ratingImageUrl: json['rating_image_url'],
      value: json['value'],
      localizedName: json['localized_name'],
    );
  }
}

class OwnerResponse {
  final int id;
  final String title;
  final String text;
  final String lang;
  final String author;
  final String publishedDate;

  OwnerResponse({
    required this.id,
    required this.title,
    required this.text,
    required this.lang,
    required this.author,
    required this.publishedDate,
  });

  factory OwnerResponse.fromJson(Map<String, dynamic> json) {
    return OwnerResponse(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      lang: json['lang'],
      author: json['author'],
      publishedDate: json['published_date'],
    );
  }
}

