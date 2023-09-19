import 'package:flutter/material.dart';

class LabelAndText extends StatelessWidget {
  const LabelAndText({
    super.key,
    required this.label,
    required this.text,
  });

  final String label, text;

  @override
  Widget build(BuildContext context) {
    // return Text('Born: ${castInfo.birthday} (${castInfo.placeOfBirth})',
    //   style: Theme.of(context).textTheme.titleMedium,);
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$label: ',
            style: Theme.of(context).textTheme.labelMedium
          ),
          TextSpan(
            text: text,
              style: Theme.of(context).textTheme.titleSmall
          ),
        ],
      ),
    );
  }
}