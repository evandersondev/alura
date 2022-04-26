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
            spreadRadius: 3,
            blurRadius: 4,
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
              'Lista de usuários',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.library_books_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
