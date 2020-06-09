class VideoModel {
  int id;
  List<Video> videos = [];
  VideoModel({this.id, this.videos});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    for (var i = 0; i < json['results'].length; i++) {
      Video result = Video(json['results'][i]);
      videos.add(result);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['results'] = this.videos;
    return data;
  }
}

class Video {
  String id;
  String key;
  String name;
  String site;
  String type;

  Video(result) {
    id = result['id'];
    key = result['key'];
    type = result['type'];
    name = result['name'];
    site = result['site'];
  }

  String get getId => id;
  String get getName => name;
  String get getKey => key;
  String get getType => type;
  String get getSite => site;
}
