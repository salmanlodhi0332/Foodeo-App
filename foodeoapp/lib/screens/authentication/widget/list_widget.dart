import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final List imagelist;
  final double padding;

  const ListWidget(
      {super.key,
      required this.scrollController,
      required this.imagelist,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: padding),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: imagelist.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    '${imagelist[index]}',
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
