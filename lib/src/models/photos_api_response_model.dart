class PhotosApiResponseModel {
  final List<Data> data;

  PhotosApiResponseModel({required this.data});

  factory PhotosApiResponseModel.fromJson(Map<String, dynamic> json) {
    return PhotosApiResponseModel(
      data: (json['data'] as List).map((item) => Data.fromJson(item)).toList(),
    );
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
}

class Images {
  final ImageInfo thumbnail;
  final ImageInfo small;
  final ImageInfo medium;
  final ImageInfo large;
  final ImageInfo original;

  Images({
    required this.thumbnail,
    required this.small,
    required this.medium,
    required this.large,
    required this.original,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      thumbnail: ImageInfo.fromJson(json['thumbnail']),
      small: ImageInfo.fromJson(json['small']),
      medium: ImageInfo.fromJson(json['medium']),
      large: ImageInfo.fromJson(json['large']),
      original: ImageInfo.fromJson(json['original']),
    );
  }
}

class ImageInfo {
  final int height;
  final int width;
  final String url;

  ImageInfo({
    required this.height,
    required this.width,
    required this.url,
  });

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      height: json['height'],
      width: json['width'],
      url: json['url'],
    );
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
}

class User {
  final String username;

  User({required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
    );
  }
}