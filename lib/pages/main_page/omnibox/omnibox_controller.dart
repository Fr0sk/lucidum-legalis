import 'dart:io';

import 'package:file_explorer/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/main.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_client.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_client_file.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_lawsuit.dart';
import 'package:lucidum_legalis/services/app_directories.dart';
import 'package:lucidum_legalis/utils/extensions.dart';
import 'package:path/path.dart' as p;

import 'omnibox_list_tile_lawsuit_file.dart';

class OmniboxController {
  final _clients = <Client>[];
  final _lawsuits = <Lawsuite>[];
  final _clientFiles = <String>[];
  final _lawsuitFiles = <String>[];
  final selected = ValueNotifier<int>(0);
  final searchClients = ValueNotifier<bool>(true);
  final searchLawsuits = ValueNotifier<bool>(true);
  final searchFiles = ValueNotifier<bool>(true);
  final searchResults = ListNotifier<OmniboxListTileBase>([]);
  final visibility = ValueNotifier<bool>(false);
  final hintText = ValueNotifier<String>('');
  final allowClients = ValueNotifier<bool>(true);
  final allowLawsuits = ValueNotifier<bool>(true);
  final allowFiles = ValueNotifier<bool>(true);
  final textController = TextEditingController();
  void Function(Client client)? onClientSelected;
  void Function(Lawsuite lawsuit)? onLawsuitSelected;

  OmniboxController(
      Stream<List<Client>> clientStream, Stream<List<Lawsuite>> lawsuitSteam) {
    clientStream.listen((clients) {
      _clients
        ..clear()
        ..addAll(clients);
      _rebuildSearchResults();
      _highlightSelectedWidget();
    });

    lawsuitSteam.listen((lawsuits) {
      _lawsuits
        ..clear()
        ..addAll(lawsuits);
      _rebuildSearchResults();
      _highlightSelectedWidget();
    });

    _watchFiles(base: AppDirectories.clientsDir, dest: _clientFiles);
    _watchFiles(base: AppDirectories.lawsuitsDir, dest: _lawsuitFiles);

    searchClients.addListener(_rebuildSearchResults);
    searchLawsuits.addListener(_rebuildSearchResults);
    searchFiles.addListener(_rebuildSearchResults);
    selected.addListener(_highlightSelectedWidget);
  }

  void show({
    String hint = '',
    bool allowClients = true,
    bool allowLawsuits = true,
    bool allowFiles = true,
    bool searchClients = true,
    bool searchLawsuits = true,
    bool searchFiles = true,
    void Function(Client client)? onClientSelected,
    void Function(Lawsuite lawsuit)? onLawsuitSelected,
  }) {
    hintText.value = hint;

    this.allowClients.value = allowClients;
    this.allowLawsuits.value = allowLawsuits;
    this.allowFiles.value = allowFiles;

    this.searchClients.value = searchClients;
    this.searchLawsuits.value = searchLawsuits;
    this.searchFiles.value = searchFiles;

    this.onClientSelected = onClientSelected;
    this.onLawsuitSelected = onLawsuitSelected;

    visibility.value = true;
  }

  void hide() => visibility.value = false;

  void setSearchClients(bool enabled) => searchClients.value = enabled;

  void setSearchLawsuits(bool enabled) => searchLawsuits.value = enabled;

  void toggleSearchClients() => searchClients.value = !searchClients.value;

  void toggleSearchLawsuits() => searchLawsuits.value = !searchLawsuits.value;

  void toggleSearchFiles() => searchFiles.value = !searchFiles.value;

  void clearTextField() {
    textController.text = '';
    selected.value = 0;
    _rebuildSearchResults();
  }

  void onTextChanged(String text) {
    _rebuildSearchResults();
    selected.value = 0;
    _highlightSelectedWidget();
  }

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

  void _highlightSelectedWidget() {
    for (var i = 0; i < searchResults.length; i++) {
      searchResults[i].selected.value = selected.value == i;
    }
  }

  void _openSelected() => searchResults[selected.value].onPressed?.call();

  void _watchFiles({required Directory base, required List<String> dest}) {
    base.list(recursive: true).listen((event) {
      if (event is File) {
        dest.add(event.path.substring(base.path.length + 1));
      }
    }).onDone(() {
      _rebuildSearchResults();
    });

    base.watch(recursive: true).listen((event) {
      if (event.isDirectory || event is FileSystemModifyEvent) {
        return;
      }

      final subpath = event.path.substring(base.path.length + 1);

      if (event is FileSystemCreateEvent) {
        dest.add(subpath);
      } else if (event is FileSystemDeleteEvent) {
        dest.remove(subpath);
      } else if (event is FileSystemMoveEvent) {
        final destination = event.destination?.substring(base.path.length + 1);
        if (destination != null) {
          dest.remove(subpath);
          dest.add(destination);
        }
      }

      _rebuildSearchResults();
    });
  }

  void _rebuildSearchResults() {
    final tempSearchResults = <OmniboxListTileBase>[];
    final pattern = textController.text;

    if (searchClients.value) {
      tempSearchResults.addAll(_clientsSearchResults(pattern));
    }

    if (searchLawsuits.value) {
      tempSearchResults.addAll(_lawsuitsSearchResults(pattern));
    }

    if (searchFiles.value) {
      tempSearchResults.addAll(_clientFilesSearchResuts(pattern));
      tempSearchResults.addAll(_lawsuitFilesSearchResuts(pattern));
    }

    searchResults.replace(tempSearchResults);
  }

  List<OmniboxListTileBase> _clientsSearchResults(String pattern) {
    final searchResults = <OmniboxListTileBase>[];
    for (var c in _clients) {
      final matches = c.name.search(pattern);
      if (pattern.isEmpty || matches.isNotEmpty) {
        searchResults.add(
          OmniboxListTileClient(
            client: c,
            matches: matches,
            onPressed: () => onClientSelected?.call(c),
          ),
        );
      }
    }
    return searchResults;
  }

  List<OmniboxListTileBase> _lawsuitsSearchResults(String pattern) {
    final searchResults = <OmniboxListTileBase>[];

    for (var l in _lawsuits) {
      final nameMatches = l.name.search(pattern);
      final idMatches = '# ${l.id}'.search(pattern);
      final processNumberMatches = l.processNumber?.search(pattern) ?? [];

      if (pattern.isEmpty ||
          nameMatches.isNotEmpty ||
          idMatches.isNotEmpty ||
          processNumberMatches.isNotEmpty) {
        searchResults.add(
          OmniboxListTileLawsuit(
            lawsuit: l,
            onPressed: () => onLawsuitSelected?.call(l),
            nameMatches: nameMatches,
            idMatches: idMatches,
            processNumberMatches: processNumberMatches,
          ),
        );
      }
    }

    return searchResults;
  }

  List<OmniboxListTileBase> _clientFilesSearchResuts(String pattern) {
    final searchResults = <OmniboxListTileBase>[];

    // Files with matching client name only
    final subSearchResults = <OmniboxListTileBase>[];

    for (var f in _clientFiles) {
      try {
        final clientId = p.split(f)[0];
        final client = _clients.firstWhere((c) => c.id == int.parse(clientId));
        final path = f.substring(clientId.length + 1);

        final pathMatches = path.search(pattern);
        final clientNameMathces = client.name.search(pattern);

        final widget = OmniboxListTileClientFile(
          client: client,
          filename: path,
          filenameMatches: pathMatches,
          clientNameMatches: clientNameMathces,
          onPressed: () async {
            await api.openFile(
              file: p.join(AppDirectories.clientsDir.path, clientId, path),
            );
            api.closeOmnibox();
          },
          onOpenClient: () async {
            await api.openClient(id: client.id);
            api.closeOmnibox();
          },
        );

        if (pattern.isEmpty || pathMatches.isNotEmpty) {
          searchResults.add(widget);
        } else if (clientNameMathces.isNotEmpty) {
          subSearchResults.add(widget);
        }
      } catch (_) {
        // Client not found on list
      }
    }
    searchResults.addAll(subSearchResults);
    return searchResults;
  }

  List<OmniboxListTileBase> _lawsuitFilesSearchResuts(String pattern) {
    final searchResults = <OmniboxListTileBase>[];

    // Files with matching lawsuit name only
    final subSearchResults = <OmniboxListTileBase>[];

    for (var f in _lawsuitFiles) {
      try {
        final lawsuitId = p.split(f)[0];
        final lawsuit =
            _lawsuits.firstWhere((c) => c.id == int.parse(lawsuitId));
        final path = f.substring(lawsuitId.length + 1);

        final pathMatches = path.search(pattern);
        final lawsuitNameMatches = lawsuit.name.search(pattern);

        final widget = OmniboxListTileLawsuitFile(
          lawsuit: lawsuit,
          filename: path,
          filenameMatches: pathMatches,
          lawsuitNameMatches: lawsuitNameMatches,
          onPressed: () async {
            await api.openFile(
              file: p.join(AppDirectories.lawsuitsDir.path, lawsuitId, path),
            );
            api.closeOmnibox();
          },
          onOpenLawsuit: () async {
            await api.openLawsuit(id: lawsuit.id);
            api.closeOmnibox();
          },
        );

        if (pattern.isEmpty || pathMatches.isNotEmpty) {
          searchResults.add(widget);
        } else if (lawsuitNameMatches.isNotEmpty) {
          subSearchResults.add(widget);
        }
      } catch (_) {
        // Lawsuit not found on list
      }
    }
    searchResults.addAll(subSearchResults);
    return searchResults;
  }
}
