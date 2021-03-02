class Post {
  String id;
  String createdAt;
  String title;
  String url;
  String description;

  Post(this.id, this.createdAt, this.title, this.url, this.description);

  /* Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
  } */

  factory Post.fromJson(dynamic json) {
    return Post(
        json['id'] as String,
        json['createdAt'] as String,
        json['title'] as String,
        json['url'] as String,
        json['description'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    return data;
  }
}
