class SidebarController {
  final _onShowClientListners = <void Function()>[];
  final _onShowLawsuiteListners = <void Function()>[];

  void addOnShowClientListner(void Function() callback) =>
      _onShowClientListners.add(callback);

  void addOnShowLawsuiteListner(void Function() callback) =>
      _onShowLawsuiteListners.add(callback);

  void showClients() {
    for (var listner in _onShowClientListners) {
      listner();
    }
  }

  void showLawsuites() {
    for (var listner in _onShowLawsuiteListners) {
      listner();
    }
  }
}
