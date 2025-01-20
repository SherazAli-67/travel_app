
class TripAdvisorResponse {
  final List<Data> data;

  TripAdvisorResponse({required this.data});

  factory TripAdvisorResponse.fromJson(Map<String, dynamic> json) {
    return TripAdvisorResponse(
      data: List<Data>.from(json['data'].map((x) => Data.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class Data {
  final int id;
  final bool isBlessed;
  final String caption;
  final String publishedDate;
  final Images images;
  final String album;
  final Source source;
  final User user;

  Data({
    required this.id,
    required this.isBlessed,
    required this.caption,
    required this.publishedDate,
    required this.images,
    required this.album,
    required this.source,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      isBlessed: json['is_blessed'],
      caption: json['caption'],
      publishedDate: json['published_date'],
      images: Images.fromJson(json['images']),
      album: json['album'],
      source: Source.fromJson(json['source']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_blessed': isBlessed,
      'caption': caption,
      'published_date': publishedDate,
      'images': images.toJson(),
      'album': album,
      'source': source.toJson(),
      'user': user.toJson(),
    };
  }
}

class Images {
  final ImageDetails thumbnail;
  final ImageDetails small;
  final ImageDetails medium;
  final ImageDetails large;
  final ImageDetails original;

  Images({
    required this.thumbnail,
    required this.small,
    required this.medium,
    required this.large,
    required this.original,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      thumbnail: ImageDetails.fromJson(json['thumbnail']),
      small: ImageDetails.fromJson(json['small']),
      medium: ImageDetails.fromJson(json['medium']),
      large: ImageDetails.fromJson(json['large']),
      original: ImageDetails.fromJson(json['original']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail.toJson(),
      'small': small.toJson(),
      'medium': medium.toJson(),
      'large': large.toJson(),
      'original': original.toJson(),
    };
  }
}

class ImageDetails {
  final int height;
  final int width;
  final String url;

  ImageDetails({
    required this.height,
    required this.width,
    required this.url,
  });

  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(
      height: json['height'],
      width: json['width'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
      'url': url,
    };
  }
}

class Source {
  final String name;
  final String localizedName;

  Source({
    required this.name,
    required this.localizedName,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'],
      localizedName: json['localized_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'localized_name': localizedName,
    };
  }
}

class User {
  final String username;

  User({required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}