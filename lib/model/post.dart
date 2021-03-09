class Post {
  int id;
  String webformatURL;
  String largeImageURL;
  int views;

  Post(this.id, this.webformatURL, this.largeImageURL, this.views);

  factory Post.fromJson(dynamic json) {
    return Post(json['id'] as int, json['webformatURL'] as String,
        json['largeImageURL'] as String, json['views'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['webformatURL'] = this.webformatURL;
    data['largeImageURL'] = this.largeImageURL;
    data['views'] = this.views;
    return data;
  }
}
