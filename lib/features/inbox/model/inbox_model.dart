class InboxMessageModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final List<InboxMessageDatum>? data;
    final Meta? meta;

    InboxMessageModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
        this.meta,
    });

    factory InboxMessageModel.fromJson(Map<String, dynamic> json) => InboxMessageModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<InboxMessageDatum>.from(json["data"]!.map((x) => InboxMessageDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class InboxMessageDatum {
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

    InboxMessageDatum({
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

    factory InboxMessageDatum.fromJson(Map<String, dynamic> json) => InboxMessageDatum(
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

class Meta {
    final int? total;
    final int? page;
    final int? limit;
    final int? totalPages;

    Meta({
        this.total,
        this.page,
        this.limit,
        this.totalPages,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
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
