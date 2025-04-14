import 'package:flutter/material.dart';
import 'package:group_system_app/common/constants/colors.dart';
class CustomButton extends StatefulWidget {
  Widget child;
  void Function() onPressed;
  CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  @override
  State<CustomButton> createState() => _CustomButtonState();
}
class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              widget.onPressed();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
