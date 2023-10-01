import 'package:flutter/material.dart';

class ExtraWeatherDetails extends StatelessWidget {
  final IconData icon;
  final String textMain;
  final String textSub;
  const ExtraWeatherDetails({
    super.key,
    required this.icon,
    required this.textMain,
    required this.textSub,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            textMain,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textSub,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
