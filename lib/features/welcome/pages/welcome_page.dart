import 'package:app/commons/widgets/elevated_button_continue.dart';
import 'package:app/utils/constants/sizes.dart';
import 'package:app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                GuapliTexts.homeAppbarTitle,
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: GuapliSizes.spaceBtwSections),

              // Button Continue              
              ElevBttnContinue(),
            ],
          ),
        ),
      ),
    );
  }
}
