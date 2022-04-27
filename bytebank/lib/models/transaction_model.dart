import 'dart:convert';

import 'package:bytebank/models/contact_model.dart';

class TransactionModel {
  final double value;
  final ContactModel contact;
  TransactionModel({
    required this.value,
    required this.contact,
  });

  TransactionModel copyWith({
    double? value,
    ContactModel? contact,
  }) {
    return TransactionModel(
      value: value ?? this.value,
      contact: contact ?? this.contact,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'value': value});
    result.addAll({'contact': contact.toMap()});

    return result;
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      value: map['value']?.toDouble() ?? 0.0,
      contact: ContactModel.fromMap(map['contact']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() => 'TransactionModel(value: $value, contact: $contact)';
}
