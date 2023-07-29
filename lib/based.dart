import 'package:flutter/material.dart';
import 'package:fooder_web/client.dart';


abstract class BasedScreen extends StatefulWidget {
  final ApiClient apiClient;

  const BasedScreen({super.key, required this.apiClient});
}
