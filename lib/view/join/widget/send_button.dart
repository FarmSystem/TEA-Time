import 'package:flutter/material.dart';
import 'package:tea_time/view/base/base_widget.dart';

class SendButton extends BaseWidget {

  const SendButton({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(210, 232, 223, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {  },
            child: const Text(
                '회원가입 하기',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(38, 38, 38, 70),
                )
            )
        )
      )
    );
  }
}