class OtherProfileModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final Data? data;

    OtherProfileModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
    });

    factory OtherProfileModel.fromJson(Map<String, dynamic> json) => OtherProfileModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final String? id;
    final String? email;
    final int? v;
    final DateTime? createdAt;
    final List<dynamic>? fcmTokens;
    final bool? isEmailVerified;
    final String? name;
    final String? role;
    final String? status;
    final DateTime? updatedAt;
    final String? bio;
    final String? phone;
    final int? postsCount;
    final SocialLinks? socialLinks;
    final String? avatarUrl;

    Data({
        this.id,
        this.email,
        this.v,
        this.createdAt,
        this.fcmTokens,
        this.isEmailVerified,
        this.name,
        this.role,
        this.status,
        this.updatedAt,
        this.bio,
        this.phone,
        this.postsCount,
        this.socialLinks,
        this.avatarUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        email: json["email"],
        v: json["__v"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        fcmTokens: json["fcmTokens"] == null ? [] : List<dynamic>.from(json["fcmTokens"]!.map((x) => x)),
        isEmailVerified: json["isEmailVerified"],
        name: json["name"],
        role: json["role"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        bio: json["bio"],
        phone: json["phone"],
        postsCount: json["postsCount"],
        socialLinks: json["socialLinks"] == null ? null : SocialLinks.fromJson(json["socialLinks"]),
        avatarUrl: json["avatarUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "fcmTokens": fcmTokens == null ? [] : List<dynamic>.from(fcmTokens!.map((x) => x)),
        "isEmailVerified": isEmailVerified,
        "name": name,
        "role": role,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "bio": bio,
        "phone": phone,
        "postsCount": postsCount,
        "socialLinks": socialLinks?.toJson(),
        "avatarUrl": avatarUrl,
    };
}

class SocialLinks {
    final String? facebook;
    final String? instagram;
    final String? twitter;
    final String? id;

    SocialLinks({
        this.facebook,
        this.instagram,
        this.twitter,
        this.id,
    });

    factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "_id": id,
    };
}
