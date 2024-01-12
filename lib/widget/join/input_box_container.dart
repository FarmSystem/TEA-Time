import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_time/view/base/base_widget.dart';

typedef ValidationCallback = String? Function(String value);
typedef ButtonPressedCallback = void Function();

class InputBoxContainer extends BaseWidget {
  final String label;
  final ValidationCallback? validate;
  final ButtonPressedCallback? onPressed;
  final String? buttonText;
  final bool hasButton;
  final String hint;
  final String? Function(String?)? validator;

  const InputBoxContainer({
    super.key,
    required this.label,
    this.validate,
    this.onPressed,
    this.buttonText,
    required this.hasButton,
    required this.hint,
    this.validator,
  });

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendards'
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 30,
              child: TextFormField(
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: hint,
                    suffixIcon: hasButton ? Align(
                      alignment: Alignment.center,
                      widthFactor: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(210, 232, 223, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          elevation: 0,
                        ),
                        child: const Text(
                          '중복확인',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(38, 38, 38, 1),
                          ),
                        ),
                      ),
                    )
                    : null,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    String? result = validator!(value);

                    if (result != null) {
                      return result;
                    }

                    return null;
                  }
              )
          )
        )
      ],
    );
  }
}