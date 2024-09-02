import 'package:flutter/material.dart';

class WebhookConfigScreen extends StatelessWidget {
  const WebhookConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webhook Config'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Webhook Config options go here'),
      ),
    );
  }
}