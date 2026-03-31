import 'package:boat_sells_app/features/home/model/boat_model.dart';

class UserAllPostModel {
    final bool? success;
    final int? statusCode;
    final String? message;
    final List<BoatItem>? data;
    final Meta? meta;

    UserAllPostModel({
        this.success,
        this.statusCode,
        this.message,
        this.data,
        this.meta,
    });

    factory UserAllPostModel.fromJson(Map<String, dynamic> json) => UserAllPostModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? [] : List<BoatItem>.from(json["data"]!.map((x) => BoatItem.fromJson(x))),
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
