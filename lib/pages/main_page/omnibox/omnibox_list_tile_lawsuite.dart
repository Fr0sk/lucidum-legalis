import 'package:flutter/material.dart';
import 'package:lucidum_legalis/data/match.dart';
import 'package:lucidum_legalis/database/user_database.dart';
import 'package:lucidum_legalis/utils/utils.dart';
import 'package:lucidum_legalis/widgets/matched_text.dart';

class OmniboxListTileLawsuite extends StatelessWidget {
  final Lawsuite lawsuite;
  final void Function()? onPressed;
  final List<StringMatch> nameMatches;
  final List<StringMatch> idMatches;
  final List<StringMatch> processNumberMatches;

  const OmniboxListTileLawsuite({
    Key? key,
    required this.lawsuite,
    this.onPressed,
    this.nameMatches = const [],
    this.idMatches = const [],
    this.processNumberMatches = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconUtils.lawsuiteIcon(lawsuite.state),
      title: MatchedText(text: lawsuite.name, matches: nameMatches),
      subtitle: Row(
        children: [
          MatchedText(text: '# ${lawsuite.id}', matches: idMatches),
          const VerticalDivider(),
          MatchedText(
            text: '${lawsuite.processNumber}',
            matches: processNumberMatches,
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
