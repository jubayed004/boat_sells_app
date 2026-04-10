class ChatModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final List<ChatItem>? data;
    final ChatModelMeta? meta;

    ChatModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
        this.meta,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ChatItem>.from(json["data"]!.map((x) => ChatItem.fromJson(x))),
        meta: json["meta"] == null ? null : ChatModelMeta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class ChatItem {
    final String? id;
    final List<Participant>? participants;
    final DatumMeta? meta;
    final List<dynamic>? blockedBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final LastMessage? lastMessage;

    ChatItem({
        this.id,
        this.participants,
        this.meta,
        this.blockedBy,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.lastMessage,
    });

    factory ChatItem.fromJson(Map<String, dynamic> json) => ChatItem(
        id: json["_id"],
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
        meta: json["meta"] == null ? null : DatumMeta.fromJson(json["meta"]),
        blockedBy: json["blockedBy"] == null ? [] : List<dynamic>.from(json["blockedBy"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
        "blockedBy": blockedBy == null ? [] : List<dynamic>.from(blockedBy!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "lastMessage": lastMessage?.toJson(),
    };
}

class LastMessage {
    final String? id;
    final String? conversationId;
    final Receiver? sender;
    final Receiver? receiver;
    final String? text;
    final List<String>? images;
    final dynamic video;
    final dynamic videoCover;
    final bool? seen;
    final dynamic deliveredAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    LastMessage({
        this.id,
        this.conversationId,
        this.sender,
        this.receiver,
        this.text,
        this.images,
        this.video,
        this.videoCover,
        this.seen,
        this.deliveredAt,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["_id"],
        conversationId: json["conversationId"],
        sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        text: json["text"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        video: json["video"],
        videoCover: json["videoCover"],
        seen: json["seen"],
        deliveredAt: json["deliveredAt"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "conversationId": conversationId,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "text": text,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "video": video,
        "videoCover": videoCover,
        "seen": seen,
        "deliveredAt": deliveredAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Receiver {
    final String? id;
    final String? role;

    Receiver({
        this.id,
        this.role,
    });

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
    };
}

class DatumMeta {
    final String? id;
    final DateTime? lastActivityAt;

    DatumMeta({
        this.id,
        this.lastActivityAt,
    });

    factory DatumMeta.fromJson(Map<String, dynamic> json) => DatumMeta(
        id: json["_id"],
        lastActivityAt: json["lastActivityAt"] == null ? null : DateTime.parse(json["lastActivityAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "lastActivityAt": lastActivityAt?.toIso8601String(),
    };
}

class Participant {
    final String? id;
    final String? role;
    final String? name;
    final dynamic image;

    Participant({
        this.id,
        this.role,
        this.name,
        this.image,
    });

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        role: json["role"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "name": name,
        "image": image,
    };
}

class ChatModelMeta {
    final int? total;
    final int? page;
    final int? limit;
    final int? totalPages;

    ChatModelMeta({
        this.total,
        this.page,
        this.limit,
        this.totalPages,
    });

    factory ChatModelMeta.fromJson(Map<String, dynamic> json) => ChatModelMeta(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
    };
}
