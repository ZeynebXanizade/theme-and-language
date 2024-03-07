import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnimationWelcomeText extends StatefulWidget {
  const AnimationWelcomeText({super.key});

  @override
  State<AnimationWelcomeText> createState() => _AnimationWelcomeTextState();
}

class _AnimationWelcomeTextState extends State<AnimationWelcomeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Animasyon süresi
    );

    _controller.forward(); // Animasyonu başlat
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon controller'ını temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(
              AppLocalizations.of(context)!.welcome.toString().length,
              (index) {
                String letter =  AppLocalizations.of(context)!.welcome.toString()[index];
                double opacity =
                    _controller.value - index / 30.0; // Harfin görünürlüğü

                opacity = opacity < 0
                    ? 0
                    : (opacity > 1 ? 1 : opacity); // Opacity sınırları

                return Opacity(
                  opacity: opacity,
                  child: Text(
                    letter,
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
