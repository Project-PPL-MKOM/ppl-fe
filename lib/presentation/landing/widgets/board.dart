import 'package:flutter/material.dart';

const _pageTitleStyle = TextStyle(
  fontSize: 20.0,
  wordSpacing: 1,
  letterSpacing: 1.2,
  fontWeight: FontWeight.w900,
  color: Colors.black,
);
const _pageDescStyle = TextStyle(
  color: Colors.black,
  letterSpacing: 0.8,
  height: 1.6,
  fontSize: 14,
);

class BoardCard extends StatelessWidget {
  final String asset, title, description;

  const BoardCard({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //   width: 0.0,
          //   color: background,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(asset),
            ),
            SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      title,
                      style: _pageTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      description,
                      style: _pageDescStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
