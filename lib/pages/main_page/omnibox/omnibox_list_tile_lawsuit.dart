import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';

class OmniboxListTileLawsuit extends OmniboxListTileBase {
  final Lawsuite lawsuit;
  final List<StringMatch> nameMatches;
  final List<StringMatch> idMatches;
  final List<StringMatch> processNumberMatches;

  OmniboxListTileLawsuit({
    Key? key,
    required this.lawsuit,
    void Function()? onPressed,
    this.nameMatches = const [],
    this.idMatches = const [],
    this.processNumberMatches = const [],
  }) : super(key: key, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: selected,
      builder: (_, isSelected, child) => ListTile(
        leading: IconUtils.lawsuiteIcon(lawsuit.state),
        title: MatchedText(text: lawsuit.name, matches: nameMatches),
        subtitle: child,
        onTap: onPressed,
        tileColor: isSelected ? Theme.of(context).selectedRowColor : null,
      ),
      child: Row(
        children: [
          MatchedText(text: '# ${lawsuit.id}', matches: idMatches),
          const VerticalDivider(),
          MatchedText(
            text: '${lawsuit.processNumber}',
            matches: processNumberMatches,
          ),
        ],
      ),
    );
  }
}
