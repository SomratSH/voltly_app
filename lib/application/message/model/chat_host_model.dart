class HostChatModel {
  List<Chats>? chats;

  HostChatModel({this.chats});

  HostChatModel.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  int? chatRoomId;
  Driver? driver;
  String? lastMessage;
  String? lastMessageTime;

  Chats({this.chatRoomId, this.driver, this.lastMessage, this.lastMessageTime});

  Chats.fromJson(Map<String, dynamic> json) {
    chatRoomId = json['chat_room_id'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_room_id'] = this.chatRoomId;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['last_message'] = this.lastMessage;
    data['last_message_time'] = this.lastMessageTime;
    return data;
  }
}

class Driver {
  int? id;
  String? name;
  String? email;
  String? profileImage;

  Driver({this.id, this.name, this.email, this.profileImage});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
