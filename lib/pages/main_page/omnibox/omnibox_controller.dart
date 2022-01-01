import 'package:easy_localization/easy_localization.dart';
import 'package:file_explorer/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_client.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_lawsuite.dart';
import 'package:lucidum_legalis/utils/utils.dart';

class OmniboxController {
  //final Stream<Client> clientStream;
  //final Stream<Lawsuite> lawsuiteSteam;
  final _clients = <Client>[];
  final _lawsuites = <Lawsuite>[];
  final searchClients = ValueNotifier<bool>(true);
  final searchLawsuites = ValueNotifier<bool>(true);
  final searchResults = ListNotifier<Widget>([]);
  final searchFilter = ValueNotifier<String>('');
  final visibility = ValueNotifier<bool>(false);
  final hintText = ValueNotifier<String>('');
  final allowClients = ValueNotifier<bool>(true);
  final allowLawsuites = ValueNotifier<bool>(true);
  void Function(Client client)? onClientSelected;
  void Function(Lawsuite lawsuite)? onLawsuiteSelected;

  OmniboxController(
      Stream<List<Client>> clientStream, Stream<List<Lawsuite>> lawsuiteSteam) {
    clientStream.listen((clients) {
      _clients
        ..clear()
        ..addAll(clients);
      _rebuildSearchResults();
    });

    lawsuiteSteam.listen((lawsuites) {
      _lawsuites
        ..clear()
        ..addAll(lawsuites);
      _rebuildSearchResults();
    });

    searchClients.addListener(_rebuildSearchResults);
    searchLawsuites.addListener(_rebuildSearchResults);
    searchFilter.addListener(_rebuildSearchResults);
  }

  void show({
    String hint = '',
    bool allowClients = true,
    bool allowLawsuites = true,
    bool searchClients = true,
    bool searchLawsuites = true,
    void Function(Client client)? onClientSelected,
    void Function(Lawsuite lawsuite)? onLawsuiteSelected,
  }) {
    hintText.value = hint;

    this.allowClients.value = allowClients;
    this.allowLawsuites.value = allowLawsuites;

    this.searchClients.value = searchClients;
    this.searchLawsuites.value = searchLawsuites;

    this.onClientSelected = onClientSelected;
    this.onLawsuiteSelected = onLawsuiteSelected;

    visibility.value = true;
  }

  void hide() => visibility.value = false;

  void setSearchClients(bool enabled) => searchClients.value = enabled;
  void setSearchLawsuites(bool enabled) => searchLawsuites.value = enabled;

  void toggleSearchClients() => searchClients.value = !searchClients.value;
  void toggleSearchLawsuites() =>
      searchLawsuites.value = !searchLawsuites.value;

  void _rebuildSearchResults() {
    final tempSearchResults = <Widget>[];
    final searchFilterList = searchFilter.value.toLowerCase().split(' ');

    if (searchClients.value) {
      tempSearchResults.addAll(
        _clients
            .where((c) =>
                searchFilter.value.isEmpty ||
                ListUtils.findMatches(
                        ':${"Client".tr()} ${c.name}'.toLowerCase().split(' '),
                        searchFilterList) >
                    searchFilterList.length)
            .map(
              (c) => OmniboxListTileClient(
                client: c,
                onPressed: () => onClientSelected?.call(c),
              ),
            ),
      );
    }

    if (searchLawsuites.value) {
      tempSearchResults.addAll(
        _lawsuites
            .where((l) =>
                searchFilter.value.isEmpty ||
                ListUtils.findMatches(
                        ':${"Lawsuite".tr()} ${l.name} ${l.id} ${l.processNumber ?? ""}'
                            .toLowerCase()
                            .split(' '),
                        searchFilterList) >=
                    searchFilterList.length)
            .map(
              (l) => OmniboxListTileLawsuite(
                lawsuite: l,
                onPressed: () => onLawsuiteSelected?.call(l),
              ),
            ),
      );
    }

    searchResults.replace(tempSearchResults);
  }
}
