import 'package:toodoo_bank/generated/json/base/json_convert_content.dart';
import 'package:toodoo_bank/network/models/billet_payment_entity.dart';

BilletPaymentEntity $BilletPaymentEntityFromJson(Map<String, dynamic> json) {
	final BilletPaymentEntity billetPaymentEntity = BilletPaymentEntity();
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		billetPaymentEntity.description = description;
	}
	final String? barCodeNumber = jsonConvert.convert<String>(json['barCodeNumber']);
	if (barCodeNumber != null) {
		billetPaymentEntity.barCodeNumber = barCodeNumber;
	}
	final String? dueDate = jsonConvert.convert<String>(json['dueDate']);
	if (dueDate != null) {
		billetPaymentEntity.dueDate = dueDate;
	}
	final String? assignor = jsonConvert.convert<String>(json['assignor']);
	if (assignor != null) {
		billetPaymentEntity.assignor = assignor;
	}
	final String? assignorDocument = jsonConvert.convert<String>(json['assignorDocument']);
	if (assignorDocument != null) {
		billetPaymentEntity.assignorDocument = assignorDocument;
	}
	final int? discount = jsonConvert.convert<int>(json['discount']);
	if (discount != null) {
		billetPaymentEntity.discount = discount;
	}
	final int? interest = jsonConvert.convert<int>(json['interest']);
	if (interest != null) {
		billetPaymentEntity.interest = interest;
	}
	final int? fine = jsonConvert.convert<int>(json['fine']);
	if (fine != null) {
		billetPaymentEntity.fine = fine;
	}
	final int? amount = jsonConvert.convert<int>(json['amount']);
	if (amount != null) {
		billetPaymentEntity.amount = amount;
	}
	final bool? scheduleNextWindow = jsonConvert.convert<bool>(json['scheduleNextWindow']);
	if (scheduleNextWindow != null) {
		billetPaymentEntity.scheduleNextWindow = scheduleNextWindow;
	}
	return billetPaymentEntity;
}

Map<String, dynamic> $BilletPaymentEntityToJson(BilletPaymentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['description'] = entity.description;
	data['barCodeNumber'] = entity.barCodeNumber;
	data['dueDate'] = entity.dueDate;
	data['assignor'] = entity.assignor;
	data['assignorDocument'] = entity.assignorDocument;
	data['discount'] = entity.discount;
	data['interest'] = entity.interest;
	data['fine'] = entity.fine;
	data['amount'] = entity.amount;
	data['scheduleNextWindow'] = entity.scheduleNextWindow;
	return data;
}