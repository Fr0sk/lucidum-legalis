import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/pages/main_page/omnibox/omnibox_list_tile_base.dart';
import 'package:lucidum_legalis/utils/constants.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';
import 'package:path/path.dart' as p;

class OmniboxListTileClientFile extends OmniboxListTileBase {
  final String filename;
  final Client client;
  final List<StringMatch> filenameMatches;
  final List<StringMatch> clientNameMatches;
  final void Function()? onOpenClient;

  OmniboxListTileClientFile({
    Key? key,
    required this.client,
    required this.filename,
    void Function()? onPressed,
    this.onOpenClient,
    this.filenameMatches = const [],
    this.clientNameMatches = const [],
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
            message: 'Open client'.tr(),
            child: OutlinedButton(
                onPressed: onOpenClient,
                child: IconUtils.clientIcon(client.type)),
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
            child: IconUtils.clientIcon(client.type),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: MatchedText(
              text: client.name,
              matches: clientNameMatches,
            ),
          ),
        ],
      ),
    );
  }
}
