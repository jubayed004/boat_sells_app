class DetailsPostModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final Data? data;

    DetailsPostModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
    });

    factory DetailsPostModel.fromJson(Map<String, dynamic> json) => DetailsPostModel(
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
    final UserId? userId;
    final String? title;
    final String? caption;
    final String? location;
    final int? price;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final int? commentsCount;
    final int? likesCount;
    final String? displayTitle;
    final String? userAvatarUrl;
    final String? userName;
    final int? shareCount;
    final String? status;
    final User? user;
    final BoatInfo? boatInfo;
    final BoatEngine? boatEngine;
    final BoatAdditional? boatAdditional;
    final List<Media>? media;
    final bool? isLiked;
    final bool? isSaved;

    Data({
        this.id,
        this.userId,
        this.title,
        this.caption,
        this.location,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.commentsCount,
        this.likesCount,
        this.displayTitle,
        this.userAvatarUrl,
        this.userName,
        this.shareCount,
        this.status,
        this.user,
        this.boatInfo,
        this.boatEngine,
        this.boatAdditional,
        this.media,
        this.isLiked,
        this.isSaved,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        title: json["title"],
        caption: json["caption"],
        location: json["location"],
        price: json["price"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        commentsCount: json["commentsCount"],
        likesCount: json["likesCount"],
        displayTitle: json["displayTitle"],
        userAvatarUrl: json["userAvatarUrl"],
        userName: json["userName"],
        shareCount: json["shareCount"],
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        boatInfo: json["boatInfo"] == null ? null : BoatInfo.fromJson(json["boatInfo"]),
        boatEngine: json["boatEngine"] == null ? null : BoatEngine.fromJson(json["boatEngine"]),
        boatAdditional: json["boatAdditional"] == null ? null : BoatAdditional.fromJson(json["boatAdditional"]),
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        isLiked: json["isLiked"],
        isSaved: json["isSaved"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "title": title,
        "caption": caption,
        "location": location,
        "price": price,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "commentsCount": commentsCount,
        "likesCount": likesCount,
        "displayTitle": displayTitle,
        "userAvatarUrl": userAvatarUrl,
        "userName": userName,
        "shareCount": shareCount,
        "status": status,
        "user": user?.toJson(),
        "boatInfo": boatInfo?.toJson(),
        "boatEngine": boatEngine?.toJson(),
        "boatAdditional": boatAdditional?.toJson(),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
        "isLiked": isLiked,
        "isSaved": isSaved,
    };
}

class BoatAdditional {
    final String? id;
    final String? postId;
    final String? manufacturer;
    final String? engineModel;
    final int? fuelCapacity;
    final int? freshWaterTank;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? additionalEquipment;
    final int? beam;
    final int? bridgeClearance;
    final int? cabin;
    final int? cruiseSpeed;
    final String? deckHullEquipment;
    final int? draft;
    final String? galleyEquipment;
    final int? loa;
    final int? maxSpeed;
    final String? mechanicalEquipment;
    final String? navigationSystem;

    BoatAdditional({
        this.id,
        this.postId,
        this.manufacturer,
        this.engineModel,
        this.fuelCapacity,
        this.freshWaterTank,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.additionalEquipment,
        this.beam,
        this.bridgeClearance,
        this.cabin,
        this.cruiseSpeed,
        this.deckHullEquipment,
        this.draft,
        this.galleyEquipment,
        this.loa,
        this.maxSpeed,
        this.mechanicalEquipment,
        this.navigationSystem,
    });

    factory BoatAdditional.fromJson(Map<String, dynamic> json) => BoatAdditional(
        id: json["_id"],
        postId: json["postId"],
        manufacturer: json["manufacturer"],
        engineModel: json["engineModel"],
        fuelCapacity: json["fuelCapacity"],
        freshWaterTank: json["freshWaterTank"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        additionalEquipment: json["additionalEquipment"],
        beam: json["beam"],
        bridgeClearance: json["bridgeClearance"],
        cabin: json["cabin"],
        cruiseSpeed: json["cruiseSpeed"],
        deckHullEquipment: json["deckHullEquipment"],
        draft: json["draft"],
        galleyEquipment: json["galleyEquipment"],
        loa: json["loa"],
        maxSpeed: json["maxSpeed"],
        mechanicalEquipment: json["mechanicalEquipment"],
        navigationSystem: json["navigationSystem"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "manufacturer": manufacturer,
        "engineModel": engineModel,
        "fuelCapacity": fuelCapacity,
        "freshWaterTank": freshWaterTank,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "additionalEquipment": additionalEquipment,
        "beam": beam,
        "bridgeClearance": bridgeClearance,
        "cabin": cabin,
        "cruiseSpeed": cruiseSpeed,
        "deckHullEquipment": deckHullEquipment,
        "draft": draft,
        "galleyEquipment": galleyEquipment,
        "loa": loa,
        "maxSpeed": maxSpeed,
        "mechanicalEquipment": mechanicalEquipment,
        "navigationSystem": navigationSystem,
    };
}

class BoatEngine {
    final String? id;
    final String? postId;
    final List<Engine>? engines;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    BoatEngine({
        this.id,
        this.postId,
        this.engines,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory BoatEngine.fromJson(Map<String, dynamic> json) => BoatEngine(
        id: json["_id"],
        postId: json["postId"],
        engines: json["engines"] == null ? [] : List<Engine>.from(json["engines"]!.map((x) => Engine.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "engines": engines == null ? [] : List<dynamic>.from(engines!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Engine {
    final String? engineType;
    final String? fuelType;
    final String? engineMake;
    final String? engineModel;
    final int? horsePower;
    final int? engineHours;
    final String? id;

    Engine({
        this.engineType,
        this.fuelType,
        this.engineMake,
        this.engineModel,
        this.horsePower,
        this.engineHours,
        this.id,
    });

    factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        engineType: json["engineType"],
        fuelType: json["fuelType"],
        engineMake: json["engineMake"],
        engineModel: json["engineModel"],
        horsePower: json["horsePower"],
        engineHours: json["engineHours"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "engineType": engineType,
        "fuelType": fuelType,
        "engineMake": engineMake,
        "engineModel": engineModel,
        "horsePower": horsePower,
        "engineHours": engineHours,
        "_id": id,
    };
}

class BoatInfo {
    final String? id;
    final String? postId;
    final String? boatType;
    final String? category;
    final String? model;
    final String? hullMaterial;
    final int? length;
    final int? peopleCapacity;
    final int? year;
    final String? description;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    BoatInfo({
        this.id,
        this.postId,
        this.boatType,
        this.category,
        this.model,
        this.hullMaterial,
        this.length,
        this.peopleCapacity,
        this.year,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory BoatInfo.fromJson(Map<String, dynamic> json) => BoatInfo(
        id: json["_id"],
        postId: json["postId"],
        boatType: json["boatType"],
        category: json["category"],
        model: json["model"],
        hullMaterial: json["hullMaterial"],
        length: json["length"],
        peopleCapacity: json["peopleCapacity"],
        year: json["year"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "boatType": boatType,
        "category": category,
        "model": model,
        "hullMaterial": hullMaterial,
        "length": length,
        "peopleCapacity": peopleCapacity,
        "year": year,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Media {
    final String? id;
    final String? postId;
    final String? type;
    final String? url;
    final int? order;
    final int? durationSeconds;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    Media({
        this.id,
        this.postId,
        this.type,
        this.url,
        this.order,
        this.durationSeconds,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["_id"],
        postId: json["postId"],
        type: json["type"],
        url: json["url"],
        order: json["order"],
        durationSeconds: json["durationSeconds"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "postId": postId,
        "type": type,
        "url": url,
        "order": order,
        "durationSeconds": durationSeconds,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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

class UserId {
    final String? id;
    final String? name;

    UserId({
        this.id,
        this.name,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}
