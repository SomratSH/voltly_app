class CreateChatModel {
  int? id;
  Driver? driver;
  Host? host;
  String? createdAt;
  Null? lastMessage;

  CreateChatModel({
    this.id,
    this.driver,
    this.host,
    this.createdAt,
    this.lastMessage,
  });

  CreateChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driver = json['driver'] != null
        ? new Driver.fromJson(json['driver'])
        : null;
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
    createdAt = json['created_at'];
    lastMessage = json['last_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['last_message'] = this.lastMessage;
    return data;
  }
}

class Driver {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  String? picture;
  bool? isOnline;
  Null? lastSeen;
  bool? isActive;

  Driver({
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

  Driver.fromJson(Map<String, dynamic> json) {
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

class Host {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  String? picture;
  bool? isOnline;
  String? lastSeen;
  bool? isActive;

  Host({
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

  Host.fromJson(Map<String, dynamic> json) {
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
