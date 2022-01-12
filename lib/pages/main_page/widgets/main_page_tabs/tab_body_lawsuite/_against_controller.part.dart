part of 'tab_body_lawsuite.dart';

class _AgainstController {
  final int id;
  final TextEditingController against;
  final TextEditingController vat;
  final TextEditingController address;

  _AgainstController(
      {required this.id, againstText = '', vatText = '', addressText = ''})
      : against = TextEditingController(text: againstText),
        vat = TextEditingController(text: vatText),
        address = TextEditingController(text: addressText);
}
