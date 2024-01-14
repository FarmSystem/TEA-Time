import 'package:flutter/cupertino.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Opacity(
          opacity: 0.3,
          child: ModalBarrier(
            dismissible: false,
            color: CupertinoColors.black,
          ),
        ),
        Center(
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ],
    );
  }
}