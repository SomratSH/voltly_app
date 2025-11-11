class ChatListModel {
  List<Chats>? chats;

  ChatListModel({this.chats});

  ChatListModel.fromJson(Map<String, dynamic> json) {
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
  Host? host;
  String? lastMessage;
  String? lastMessageTime;

  Chats({this.chatRoomId, this.host, this.lastMessage, this.lastMessageTime});

  Chats.fromJson(Map<String, dynamic> json) {
    chatRoomId = json['chat_room_id'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_room_id'] = this.chatRoomId;
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    data['last_message'] = this.lastMessage;
    data['last_message_time'] = this.lastMessageTime;
    return data;
  }
}

class Host {
  int? id;
  String? name;
  String? email;
  String? profileImage;

  Host({this.id, this.name, this.email, this.profileImage});

  Host.fromJson(Map<String, dynamic> json) {
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
