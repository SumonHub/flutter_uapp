class Video {
  String link;
  String title;

  Video({this.link, this.title});

  Video.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.link;
    data['title'] = this.title;
    return data;
  }
}
