class MessageResModel {
  MessageResModel({
    this.content,
    this.first,
    this.last,
  });

  List<Content?>? content;
  bool? first;
  bool? last;

  factory MessageResModel.fromJson(Map<String, dynamic> json) =>
      MessageResModel(
        content: json["content"] == null
            ? []
            : List<Content?>.from(
                json["content"]!.map(
                  (x) => Content.fromJson(x),
                ),
              ),
        first: json["first"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x!.toJson())),
        "first": first,
        "last": last,
      };
}

class Content {
  Content({
    this.id,
    this.body,
    this.conversationId,
    this.author,
    this.authorId,
    this.createDate,
    this.updateDate,
    this.repliedMessage,
    this.sections,
    this.medias,
    this.isFirstUnread,
    this.reactions,
    this.isDeleted,
    this.isSentByCurrentUser,
  });

  String? id;
  String? body;
  String? conversationId;
  Author? author;
  String? authorId;
  int? createDate;
  dynamic updateDate;
  dynamic repliedMessage;
  List<Section?>? sections;
  List<dynamic>? medias;
  bool? isFirstUnread;
  List<dynamic>? reactions;
  bool? isDeleted;
  bool? isSentByCurrentUser;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        body: json["body"],
        conversationId: json["conversationId"],
        author: Author.fromJson(json["author"]),
        authorId: json["authorId"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        repliedMessage: json["repliedMessage"],
        sections: json["sections"] == null
            ? []
            : List<Section?>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
        medias: json["medias"] == null
            ? []
            : List<dynamic>.from(json["medias"]!.map((x) => x)),
        isFirstUnread: json["isFirstUnread"],
        reactions: json["reactions"] == null
            ? []
            : List<dynamic>.from(json["reactions"]!.map((x) => x)),
        isDeleted: json["isDeleted"],
        isSentByCurrentUser: json["isSentByCurrentUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "conversationId": conversationId,
        "author": author!.toJson(),
        "authorId": authorId,
        "createDate": createDate,
        "updateDate": updateDate,
        "repliedMessage": repliedMessage,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x!.toJson())),
        "medias":
            medias == null ? [] : List<dynamic>.from(medias!.map((x) => x)),
        "isFirstUnread": isFirstUnread,
        "reactions": reactions == null
            ? []
            : List<dynamic>.from(reactions!.map((x) => x)),
        "isDeleted": isDeleted,
        "isSentByCurrentUser": isSentByCurrentUser,
      };
}

class Author {
  Author({
    this.id,
    this.metadata,
    this.isOnline,
    this.isCustomer,
    this.createDate,
    this.updateDate,
  });

  String? id;
  Metadata? metadata;
  bool? isOnline;
  bool? isCustomer;
  int? createDate;
  int? updateDate;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        metadata: Metadata.fromJson(json["metadata"]),
        isOnline: json["isOnline"],
        isCustomer: json["isCustomer"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "metadata": metadata!.toJson(),
        "isOnline": isOnline,
        "isCustomer": isCustomer,
        "createDate": createDate,
        "updateDate": updateDate,
      };
}

class Metadata {
  Metadata({
    this.phoneNumber,
    this.color,
    this.displayName,
    this.fullName,
    this.position,
    this.userId,
    this.email,
  });

  dynamic phoneNumber;
  String? color;
  String? displayName;
  String? fullName;
  String? position;
  String? userId;
  String? email;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        phoneNumber: json["phoneNumber"],
        color: json["color"],
        displayName: json["displayName"],
        fullName: json["fullName"],
        position: json["position"],
        userId: json["userId"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "color": color,
        "displayName": displayName,
        "fullName": fullName,
        "position": position,
        "userId": userId,
        "email": email,
      };
}

class Section {
  Section({
    this.type,
    this.components,
  });

  String? type;
  List<Component?>? components;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        type: json["type"],
        components: json["components"] == null
            ? []
            : List<Component?>.from(
                json["components"]!.map((x) => Component.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "components": components == null
            ? []
            : List<dynamic>.from(components!.map((x) => x!.toJson())),
      };
}

class Component {
  Component({
    this.type,
    this.text,
    this.style,
    this.userId,
    this.url,
    this.components,
  });

  String? type;
  String? text;
  dynamic style;
  dynamic userId;
  dynamic url;
  List<dynamic>? components;

  factory Component.fromJson(Map<String, dynamic> json) => Component(
        type: json["type"],
        text: json["text"],
        style: json["style"],
        userId: json["userId"],
        url: json["url"],
        components: json["components"] == null
            ? []
            : List<dynamic>.from(json["components"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "style": style,
        "userId": userId,
        "url": url,
        "components": components == null
            ? []
            : List<dynamic>.from(components!.map((x) => x)),
      };
}
