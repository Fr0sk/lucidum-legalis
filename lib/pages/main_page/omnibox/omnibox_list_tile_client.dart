import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';

class OmniboxListTileClient extends StatelessWidget {
  final Client client;
  final void Function()? onPressed;
  final List<StringMatch> matches;

  const OmniboxListTileClient(
      {Key? key, required this.client, this.onPressed, this.matches = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconUtils.clientIcon(client.type),
      title: MatchedText(
        text: client.name,
        matches: matches,
      ),
      onTap: onPressed,
    );
  }
}
