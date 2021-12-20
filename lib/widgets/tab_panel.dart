import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TabPanel extends StatelessWidget {
  final int selected;
  final _scrollController = ScrollController();
  final _tabs = <Widget>[];
  final _keys = <GlobalKey>[];
  final _scrollbarKey = GlobalKey();

  //TODO: Drag&Drop tabs: https://www.youtube.com/watch?v=WhVXkCFPmK4
  TabPanel({Key? key, this.selected = -1, required List<Widget> tabs})
      : super(key: key) {
    _tabs.addAll(tabs.map((t) {
      _keys.add(GlobalKey());
      return Container(key: _keys.last, child: t);
    }));
  }

  @override
  Widget build(BuildContext context) {
    if (selected >= 0 && selected < _tabs.length) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => _scrollTo(selected));
    }

    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          final pos = _scrollController.offset + pointerSignal.scrollDelta.dy;

          _scrollController.jumpTo(
            pos.clamp(_scrollController.position.minScrollExtent,
                _scrollController.position.maxScrollExtent),
          );
        }
      },
      child: Scrollbar(
        key: _scrollbarKey,
        controller: _scrollController,
        radius: Radius.zero,
        thickness: 4,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Center(
            child: Row(
              children: _tabs,
              mainAxisSize: MainAxisSize.max,
            ),
          ),
        ),
      ),
    );
  }

  void _scrollTo(int index) {
    assert(index >= 0 && index < _keys.length);

    final node = FocusNode();
    final attachment = node.attach(_keys[index].currentContext);
    final scrollbarNode = FocusNode();
    final scrollbarAttachment =
        scrollbarNode.attach(_scrollbarKey.currentContext);

    final viewportWidth = _scrollController.position.viewportDimension;
    final nodeWidth = node.size.width;
    final nodeXi = node.offset.dx - scrollbarNode.offset.dx;
    final nodeXf = nodeXi + nodeWidth;

    if (nodeXi < 0) {
      // Widget start is not visible on the left
      _scrollController.jumpTo(_scrollController.offset + nodeXi);
      //Scrollable.ensureVisible(tabs[index].currentContext!, alignment: 0.0);
    } else if (nodeXf > viewportWidth) {
      // Widget end is not visible on the right
      _scrollController
          .jumpTo(_scrollController.offset + (nodeXf - viewportWidth));
      //Scrollable.ensureVisible(tabs[index].currentContext!, alignment: 1.0);
    } else {
      // Widget is visible
    }

    // Clean up
    attachment.detach();
    scrollbarAttachment.detach();
  }
}
