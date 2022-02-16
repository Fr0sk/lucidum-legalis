import 'package:easy_localization/easy_localization.dart';
import 'package:file_explorer/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/database/tables/clients.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_client.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_lawsuite.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/utils/extensions.dart';

class OmniboxController {
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
    final pattern = searchFilter.value;

    if (searchClients.value) {
      for (var c in _clients) {
        final matches = c.name.search(pattern);
        if (pattern.isEmpty || matches.isNotEmpty) {
          tempSearchResults.add(
            OmniboxListTileClient(
              client: c,
              matches: matches,
              onPressed: () => onClientSelected?.call(c),
            ),
          );
        }
      }
    }

    if (searchLawsuites.value) {
      for (var l in _lawsuites) {
        final nameMatches = l.name.search(pattern);
        final idMatches = '# ${l.id}'.search(pattern);
        final processNumberMatches = l.processNumber?.search(pattern) ?? [];

        if (pattern.isEmpty ||
            nameMatches.isNotEmpty ||
            idMatches.isNotEmpty ||
            processNumberMatches.isNotEmpty) {
          tempSearchResults.add(
            OmniboxListTileLawsuite(
              lawsuite: l,
              onPressed: () => onLawsuiteSelected?.call(l),
              nameMatches: nameMatches,
              idMatches: idMatches,
              processNumberMatches: processNumberMatches,
            ),
          );
        }
      }
    }

    searchResults.replace(tempSearchResults);
  }
}
