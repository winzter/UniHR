import 'dart:convert';
import '../../domain/entities/entities.dart';

List<ReasonModel> reasonFromJson(String str) => List<ReasonModel>.from(json.decode(str).map((x) => ReasonModel.fromJson(x)));

String reasonToJson(List<ReasonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReasonModel extends ReasonEntity{


  const ReasonModel({
    required int? idRequestReason,
    required String? name,
    required int? idCompany,
    required int? isPayShift,
    required int? index,
  }):super(
      idRequestReason:idRequestReason,
      name: name,
      idCompany: idCompany,
      isPayShift: isPayShift,
      index: index
  );

  factory ReasonModel.fromJson(Map<String, dynamic> json) => ReasonModel(
    idRequestReason: json["idRequestReason"],
    name: json["name"],
    idCompany: json["idCompany"],
    isPayShift: json["isPayShift"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "idRequestReason": idRequestReason,
    "name": name,
    "idCompany": idCompany,
    "isPayShift": isPayShift,
    "index": index,
  };
}
