import 'package:flutter/material.dart';

class detail_space extends StatefulWidget {
  String title;
  String introduce;
  String datetime;

  detail_space(
      {super.key,
      required this.title,
      required this.introduce,
      required this.datetime});

  @override
  State<detail_space> createState() => _detail_spaceState();
}

class _detail_spaceState extends State<detail_space> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (panelIndex, isExpanded) => setState(() {
        _isExpanded = isExpanded;
      }),
      children: [
        ExpansionPanel(
            headerBuilder: (context, _isExpanded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Padding(padding: EdgeInsets.all(10)),
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    widget.datetime.replaceAll(RegExp(r'T'), ' '),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ],
              );
            },
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.introduce,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
            isExpanded: _isExpanded)
      ],
    );
  }
}
