import 'package:flutter/material.dart';

import 'src/random_user_app.dart';
import 'src/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const RandomUserApp());
}
