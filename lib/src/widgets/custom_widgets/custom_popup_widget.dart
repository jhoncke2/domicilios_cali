import 'package:flutter/material.dart';
class CustomPopupWidget extends StatefulWidget {
  CustomPopupWidget({
    @required this.show,
    @required this.items,
    @required this.builderFunction,
  });

  final bool show;
  final List<dynamic> items;
  final Function(BuildContext context, dynamic item) builderFunction;

  @override
  _CustomPopupWidgetState createState() => _CustomPopupWidgetState();
}

class _CustomPopupWidgetState extends State<CustomPopupWidget> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Offstage(
      offstage: !widget.show,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: widget.show ? size.height / 3 : 0,
        width: MediaQuery.of(context).size.width / 3,
        child: Card(
          elevation: 3,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                Widget item = widget.builderFunction(
                  context,
                  widget.items[index],
                );
                return item;
              },
            ),
          ),
        ),
      ),
    );
  }
}