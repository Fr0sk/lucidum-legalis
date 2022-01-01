import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucidum_legalis/utils/list_notifier.dart';
import 'package:lucidum_legalis/widgets/flexible_text_field.dart';

class Omnibox extends StatelessWidget {
  final _focusNode = FocusNode();

  Omnibox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: const Color.fromARGB(100, 0, 0, 0),
        child: Column(
          children: [
            SizedBox(
              width: 600,
              height: 400,
              child: Card(
                elevation: 8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        /*onKey: (e) {
                          if (e.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                            selected.value = selected.value + 1;
                          }
                        },*/
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Search Everything'),
                          focusNode: _focusNode..requestFocus(),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        controller: ScrollController(),
                        itemCount: 10,
                        itemBuilder: (_, idx) {
                          return ListTile(
                            title: Text('Client haah $idx'),
                            onTap: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
