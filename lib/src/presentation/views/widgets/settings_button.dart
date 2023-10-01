import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/app_router_constants.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () {
          context.pushNamed(AppRoutConstants.settingsRoutName);
        },
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
