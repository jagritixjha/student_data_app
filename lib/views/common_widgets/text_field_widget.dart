import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_data_app/utils/global_data.dart';

class TextFieldWidget extends StatelessWidget {
  IconData? icon;
  String? hint, labelText;
  String? validatorVariable;
  String? Function(String?)? validatorFunc;
  void Function(String?)? saveData;
  int? maxline;

  TextFieldWidget({
    super.key,
    this.icon,
    required this.hint,
    required this.labelText,
    required this.validatorVariable,
    required this.validatorFunc,
    required this.saveData,
    this.maxline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText!,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade800,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            onSaved: saveData,
            validator: validatorFunc,
            initialValue: validatorVariable,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.indigo.shade200),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1.4,
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            ),
            maxLines: maxline,
          ),
        ],
      ),
    );
  }
}
