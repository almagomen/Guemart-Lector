import 'package:app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ElevBttnContinue extends StatelessWidget {
  const ElevBttnContinue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Modular.to.navigate('/packages'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          GuapliTexts.tContinue,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,),
      ),
    );
  }
}