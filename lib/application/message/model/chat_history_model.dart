class ChatHistoryModel {
  int? chatId;
  String? driver;
  String? host;
  List<Messages>? messages;

  ChatHistoryModel({this.chatId, this.driver, this.host, this.messages});

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    driver = json['driver'];
    host = json['host'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['driver'] = this.driver;
    data['host'] = this.host;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  int? chat;
  Sender? sender;
  Sender? receiver;
  String? text;
  String? image;
  String? location;
  bool? isFromAi;
  String? timestamp;

  Messages({
    this.id,
    this.chat,
    this.sender,
    this.receiver,
    this.text,
    this.image,
    this.location,
    this.isFromAi,
    this.timestamp,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chat = json['chat'];
    sender = json['sender'] != null
        ? new Sender.fromJson(json['sender'])
        : null;
    receiver = json['receiver'] != null
        ? new Sender.fromJson(json['receiver'])
        : null;
    text = json['text'];
    image = json['image'];
    location = json['location'];
    isFromAi = json['is_from_ai'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat'] = this.chat;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    data['text'] = this.text;
    data['image'] = this.image;
    data['location'] = this.location;
    data['is_from_ai'] = this.isFromAi;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Sender {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  String? picture;
  bool? isOnline;
  String? lastSeen;
  bool? isActive;

  Sender({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.role,
    this.picture,
    this.isOnline,
    this.lastSeen,
    this.isActive,
  });

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    picture = json['picture'];
    isOnline = json['is_online'];
    lastSeen = json['last_seen'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['picture'] = this.picture;
    data['is_online'] = this.isOnline;
    data['last_seen'] = this.lastSeen;
    data['is_active'] = this.isActive;
    return data;
  }
}
