import 'package:file_explorer/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_client.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_lawsuite.dart';
import 'package:lucidum_legalis/utils/extensions.dart';

class OmniboxController {
  final _clients = <Client>[];
  final _lawsuites = <Lawsuite>[];
  final selected = ValueNotifier<int>(0);
  final searchClients = ValueNotifier<bool>(true);
  final searchLawsuites = ValueNotifier<bool>(true);
  final searchResults = ListNotifier<OmniboxListTileBase>([]);
  final visibility = ValueNotifier<bool>(false);
  final hintText = ValueNotifier<String>('');
  final allowClients = ValueNotifier<bool>(true);
  final allowLawsuites = ValueNotifier<bool>(true);
  final textController = TextEditingController();
  void Function(Client client)? onClientSelected;
  void Function(Lawsuite lawsuite)? onLawsuiteSelected;

  OmniboxController(
      Stream<List<Client>> clientStream, Stream<List<Lawsuite>> lawsuiteSteam) {
    clientStream.listen((clients) {
      _clients
        ..clear()
        ..addAll(clients);
      _rebuildSearchResults();
      _selectWidget();
    });

    lawsuiteSteam.listen((lawsuites) {
      _lawsuites
        ..clear()
        ..addAll(lawsuites);
      _rebuildSearchResults();
      _selectWidget();
    });

    searchClients.addListener(_rebuildSearchResults);
    searchLawsuites.addListener(_rebuildSearchResults);
    textController.addListener(_rebuildSearchResults);

    selected.addListener(_selectWidget);
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

  void onKeyPressed(RawKeyEvent e) {
    if (searchResults.isEmpty) {
      return;
    }

    if (e.isKeyPressed(LogicalKeyboardKey.enter)) {
      _openSelected();
      return;
    }

    var delta = 0;
    if (e.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      delta = 1;
    } else if (e.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      delta = -1;
    }

    if (delta == 0) {
      return;
    }

    final currentSelection = textController.selection;
    Future.delayed(Duration.zero).then((value) {
      textController.selection = currentSelection;
    });

    selected.value =
        (selected.value + delta).clamp(0, searchResults.length - 1);
  }

  void _selectWidget() {
    for (var i = 0; i < searchResults.length; i++) {
      searchResults[i].selected.value = selected.value == i;
    }
  }

  void _openSelected() => searchResults[selected.value].onPressed?.call();

  void _rebuildSearchResults() {
    final tempSearchResults = <OmniboxListTileBase>[];
    final pattern = textController.text;

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
    selected.value = 0;
    _selectWidget();
  }
}
