import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final int listCount;

  LoadingList(this.listCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: listCount == 1 ? 0 : 5),
      child: Column(
        children: List.generate(
          listCount,
          (i) => Container(
            height: 100,
            margin: EdgeInsets.only(
              top: 5,
              left: 3,
              right: 3,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Center(
              child: ListTile(
                title: Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[300],
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
