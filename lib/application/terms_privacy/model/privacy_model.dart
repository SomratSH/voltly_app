class PrivacyModel {
  int? id;
  String? content;

  PrivacyModel({this.id, this.content});

  PrivacyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}
