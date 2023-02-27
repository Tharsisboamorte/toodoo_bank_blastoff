import 'package:toodoo_bank/generated/json/base/json_field.dart';
import 'package:toodoo_bank/generated/json/billet_payment_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class BilletPaymentEntity {

	late String description;
	late String barCodeNumber;
	late String dueDate;
	late String assignor;
	late String assignorDocument;
	late int discount;
	late int interest;
	late int fine;
	late int amount;
	late bool scheduleNextWindow;
  
  BilletPaymentEntity();

  factory BilletPaymentEntity.fromJson(Map<String, dynamic> json) => $BilletPaymentEntityFromJson(json);

  Map<String, dynamic> toJson() => $BilletPaymentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}