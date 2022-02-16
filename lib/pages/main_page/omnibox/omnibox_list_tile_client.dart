import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';

class OmniboxListTileClient extends OmniboxListTileBase {
  final Client client;
  final List<StringMatch> matches;

  OmniboxListTileClient(
      {Key? key,
      required this.client,
      void Function()? onPressed,
      bool selected = false,
      this.matches = const []})
      : super(key: key, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: selected,
      builder: (_, isSelected, child) => ListTile(
        leading: IconUtils.clientIcon(client.type),
        title: child,
        onTap: onPressed,
        tileColor: isSelected ? Theme.of(context).selectedRowColor : null,
      ),
      child: MatchedText(
        text: client.name,
        matches: matches,
      ),
    );
  }
}
