import 'package:flutter/material.dart';

class BuildBarWidget extends StatelessWidget {
  const BuildBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 2,
            blurRadius: 3,
          )
        ],
      ),
      child: Container(
        width: double.infinity,
        height: AppBar().preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Contact list',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.account_box,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
