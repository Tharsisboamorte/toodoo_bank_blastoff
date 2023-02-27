import 'package:toodoo_bank/generated/json/base/json_field.dart';
import 'package:toodoo_bank/generated/json/barcode_model.g.dart';
import 'dart:convert';

@JsonSerializable()
class BarcodeModelEntity {

	late String barcode;
	late String paymentType;
	late String dueDate;
	late String paymentLimitDate;
	late double value;
	late String recipient;
	late int discount;
	late int interest;
	late double totalAmountDue;
  
  BarcodeModelEntity();

  factory BarcodeModelEntity.fromJson(Map<String, dynamic> json) => $BarcodeModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $BarcodeModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}