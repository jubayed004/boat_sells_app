class ProfileModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final Data? data;

    ProfileModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    final String? avatarUrl;
    final String? bio;
    final String? phone;
    final int? postsCount;
    final SocialLinks? socialLinks;

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
        this.avatarUrl,
        this.bio,
        this.phone,
        this.postsCount,
        this.socialLinks,
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
        avatarUrl: json["avatarUrl"],
        bio: json["bio"],
        phone: json["phone"],
        postsCount: json["postsCount"],
        socialLinks: json["socialLinks"] == null ? null : SocialLinks.fromJson(json["socialLinks"]),
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
        "avatarUrl": avatarUrl,
        "bio": bio,
        "phone": phone,
        "postsCount": postsCount,
        "socialLinks": socialLinks?.toJson(),
    };
}

class SocialLinks {
    final dynamic facebook;
    final dynamic instagram;
    final dynamic twitter;
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
