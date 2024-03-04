import 'dart:convert';

import 'package:unihr/src/features/user/timeline/domain/entities/entities.dart';

ErrorTimeLineModel errorTimeLineModelFromJson(String str) => ErrorTimeLineModel.fromJson(json.decode(str));

String errorTimeLineModelToJson(ErrorTimeLineModel data) => json.encode(data.toJson());

class ErrorTimeLineModel extends ErrorTimeLine{
  ErrorTimeLineModel({
    required super.errorCode,
  });

  factory ErrorTimeLineModel.fromJson(Map<String, dynamic> json) => ErrorTimeLineModel(
    errorCode: json["errorCode"],
  );

  Map<String, dynamic> toJson() => {
    "errorCode": errorCode,
  };
}
