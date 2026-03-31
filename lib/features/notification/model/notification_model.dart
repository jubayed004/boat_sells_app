
class NotificationsModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final List<NotificationItem>? data;
    final Meta? meta;

    NotificationsModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
        this.meta,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<NotificationItem>.from(json["data"]!.map((x) => NotificationItem.fromJson(x))),
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

class NotificationItem {
    final String? id;
    final User? user;
    final String? location;
    final int? price;
    final String? displayTitle;
    final List<Media>? media;
    final int? likesCount;
    final int? commentsCount;
    final int? shareCount;
    final bool? isLiked;
    final bool? isSaved;
    final DateTime? createdAt;

    NotificationItem({
        this.id,
        this.user,
        this.location,
        this.price,
        this.displayTitle,
        this.media,
        this.likesCount,
        this.commentsCount,
        this.shareCount,
        this.isLiked,
        this.isSaved,
        this.createdAt,
    });

    factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        location: json["location"],
        price: json["price"],
        displayTitle: json["displayTitle"],
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        likesCount: json["likesCount"],
        commentsCount: json["commentsCount"],
        shareCount: json["shareCount"],
        isLiked: json["isLiked"],
        isSaved: json["isSaved"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "location": location,
        "price": price,
        "displayTitle": displayTitle,
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
        "likesCount": likesCount,
        "commentsCount": commentsCount,
        "shareCount": shareCount,
        "isLiked": isLiked,
        "isSaved": isSaved,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Media {
    final String? url;
    final String? type;
    final int? order;

    Media({
        this.url,
        this.type,
        this.order,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        url: json["url"],
        type: json["type"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
        "order": order,
    };
}

class User {
    final String? id;
    final String? name;
    final String? avatarUrl;

    User({
        this.id,
        this.name,
        this.avatarUrl,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        avatarUrl: json["avatarUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatarUrl": avatarUrl,
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
