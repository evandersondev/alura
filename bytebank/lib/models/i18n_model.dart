class I18NModel {
  final Map<String, dynamic> _messages;
  I18NModel(this._messages);

  String get(String key) {
    assert(_messages.containsKey(key));
    assert(_messages[key] != null);
    return _messages[key]!;
  }
}

class DashboardPageLazyI18N {
  const DashboardPageLazyI18N(this.messages);

  final I18NModel messages;

  String get list_transaction => messages.get('list_transaction');
  String get error_list => messages.get('error_list');
}
