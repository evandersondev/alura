import 'dart:convert';

class ContactModel {
  final String id;
  final String name;
  final String agency;
  final String account;

  ContactModel({
    required this.id,
    required this.name,
    required this.agency,
    required this.account,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? agency,
    String? account,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      agency: agency ?? this.agency,
      account: account ?? this.account,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'agency': agency});
    result.addAll({'account': account});

    return result;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      agency: map['agency'].toString(),
      account: map['account'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, agency: $agency, account: $account)';
  }
}
