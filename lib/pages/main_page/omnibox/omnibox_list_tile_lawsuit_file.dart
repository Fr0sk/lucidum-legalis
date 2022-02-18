import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';
import 'package:path/path.dart' as p;

class OmniboxListTileLawsuitFile extends OmniboxListTileBase {
  final String filename;
  final Lawsuite lawsuit;
  final List<StringMatch> filenameMatches;
  final List<StringMatch> lawsuitNameMatches;
  final void Function()? onOpenLawsuit;

  OmniboxListTileLawsuitFile({
    Key? key,
    required this.lawsuit,
    required this.filename,
    void Function()? onPressed,
    this.onOpenLawsuit,
    this.filenameMatches = const [],
    this.lawsuitNameMatches = const [],
    bool selected = false,
  }) : super(key: key, onPressed: onPressed);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: selected,
      builder: (_, isSelected, child) => ListTile(
        leading:
            Mappings.filesIcons[p.extension(filename)] ?? AppIcons.fileUnkown,
        title: MatchedText(
          text: filename,
          matches: filenameMatches,
        ),
        trailing: SizedBox(
          height: double.infinity,
          child: Tooltip(
            message: 'Open lawsuit'.tr(),
            child: OutlinedButton(
                onPressed: onOpenLawsuit,
                child: IconUtils.lawsuiteIcon(lawsuit.state)),
          ),
        ),
        subtitle: child,
        onTap: onPressed,
        tileColor: isSelected ? Theme.of(context).selectedRowColor : null,
      ),
      child: Row(
        children: [
          IconTheme(
            data: IconThemeData(
              color: Theme.of(context).disabledColor,
              size: 16,
            ),
            child: IconUtils.lawsuiteIcon(lawsuit.state),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: MatchedText(
              text: lawsuit.name,
              matches: lawsuitNameMatches,
            ),
          ),
        ],
      ),
    );
  }
}
