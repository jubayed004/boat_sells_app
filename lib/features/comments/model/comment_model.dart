class CommentModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final List<CommentItem>? data;

    CommentModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CommentItem>.from(json["data"]!.map((x) => CommentItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CommentItem{
    final String? id;
    final String? postId;
    final UserId? userId;
    final String? parentId;
    final String? text;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final List<CommentItem>? replies;

    CommentItem({
        this.id,
        this.postId,
        this.userId,
        this.parentId,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.replies,
    });

    factory CommentItem.fromJson(Map<String, dynamic> json) => CommentItem(
        id: json["_id"],
        postId: json["postId"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        parentId: json["parentId"],
        text: json["text"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        replies: json["replies"] == null ? [] : List<CommentItem>.from(json["replies"]!.map((x) => CommentItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "userId": userId?.toJson(),
        "parentId": parentId,
        "text": text,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
    };
}

class UserId {
    final String? id;
    final String? name;
    final String? avatarUrl;

    UserId({
        this.id,
        this.name,
        this.avatarUrl,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
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
