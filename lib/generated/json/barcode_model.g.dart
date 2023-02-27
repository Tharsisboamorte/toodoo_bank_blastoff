import 'package:toodoo_bank/generated/json/base/json_convert_content.dart';
import 'package:toodoo_bank/network/models/barcode_model.dart';

BarcodeModelEntity $BarcodeModelEntityFromJson(Map<String, dynamic> json) {
	final BarcodeModelEntity barcodeModelEntity = BarcodeModelEntity();
	final String? barcode = jsonConvert.convert<String>(json['barcode']);
	if (barcode != null) {
		barcodeModelEntity.barcode = barcode;
	}
	final String? paymentType = jsonConvert.convert<String>(json['paymentType']);
	if (paymentType != null) {
		barcodeModelEntity.paymentType = paymentType;
	}
	final String? dueDate = jsonConvert.convert<String>(json['dueDate']);
	if (dueDate != null) {
		barcodeModelEntity.dueDate = dueDate;
	}
	final String? paymentLimitDate = jsonConvert.convert<String>(json['paymentLimitDate']);
	if (paymentLimitDate != null) {
		barcodeModelEntity.paymentLimitDate = paymentLimitDate;
	}
	final double? value = jsonConvert.convert<double>(json['value']);
	if (value != null) {
		barcodeModelEntity.value = value;
	}
	final String? recipient = jsonConvert.convert<String>(json['recipient']);
	if (recipient != null) {
		barcodeModelEntity.recipient = recipient;
	}
	final int? discount = jsonConvert.convert<int>(json['discount']);
	if (discount != null) {
		barcodeModelEntity.discount = discount;
	}
	final int? interest = jsonConvert.convert<int>(json['interest']);
	if (interest != null) {
		barcodeModelEntity.interest = interest;
	}
	final double? totalAmountDue = jsonConvert.convert<double>(json['totalAmountDue']);
	if (totalAmountDue != null) {
		barcodeModelEntity.totalAmountDue = totalAmountDue;
	}
	return barcodeModelEntity;
}

Map<String, dynamic> $BarcodeModelEntityToJson(BarcodeModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['barcode'] = entity.barcode;
	data['paymentType'] = entity.paymentType;
	data['dueDate'] = entity.dueDate;
	data['paymentLimitDate'] = entity.paymentLimitDate;
	data['value'] = entity.value;
	data['recipient'] = entity.recipient;
	data['discount'] = entity.discount;
	data['interest'] = entity.interest;
	data['totalAmountDue'] = entity.totalAmountDue;
	return data;
}