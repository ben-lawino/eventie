import 'package:eventie/widgets/button.dart';
import 'package:eventie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bottom_nav.dart';
import '../providers/scanner_provider.dart';

class ScannerScreen extends ConsumerWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final state = ref.watch(scannerProvider);
    final notifier = ref.read(scannerProvider.notifier);
    final isIdle = state.status == ScanStatus.idle;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan', backDestination: BottomNav()),
      body: Center(
        child: Column(
          children: [
            Text(
              'Scan Event Ticket',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 60),

            // ── Camera / result circle
            _ScanCircle(primaryColor: primaryColor),

            const SizedBox(height: 16),

            // ── Status / hint text
            _StatusText(primaryColor: primaryColor),

            const SizedBox(height: 16),

            // ── Scan Again (shown after a result)
            if (!isIdle) ...[
              Button(
                width: 300,
                onPressed: notifier.reset,
                text: 'Scan Again',
              ),
              const SizedBox(height: 12),
            ],

            // ── Manual entry (shown only when idle)
            if (isIdle) ...[
              Text(
                'Or',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              //add manually button
              Button(
                width: 300,
                onPressed: () => _showManualDialog(context, notifier),
                text: 'Add Manually',
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showManualDialog(BuildContext context, ScannerNotifier notifier) {
    showDialog(
      context: context,
      builder: (_) => _ManualEntryDialog(notifier: notifier),
    );
  }
}

// Camera inside a circle

class _ScanCircle extends ConsumerStatefulWidget {
  const _ScanCircle({required this.primaryColor});
  final Color primaryColor;

  @override
  ConsumerState<_ScanCircle> createState() => _ScanCircleState();
}

class _ScanCircleState extends ConsumerState<_ScanCircle> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerProvider);
    final notifier = ref.read(scannerProvider.notifier);

    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: widget.primaryColor.withOpacity(0.10),
        border: Border.all(color: widget.primaryColor, width: 2),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: switch (state.status) {
        ScanStatus.idle => MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final code =
                capture.barcodes.firstOrNull?.rawValue;

            if (code != null) {
              notifier.onBarcodeDetected(code);
            }
          },
        ),

        ScanStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),

        ScanStatus.success => const Icon(
          Icons.check_circle_outline_rounded,
          size: 100,
          color: Colors.green,
        ),

        ScanStatus.failure => const Icon(
          Icons.cancel_outlined,
          size: 100,
          color: Colors.red,
        ),
      },
    );
  }
}

// Status / hint text

class _StatusText extends ConsumerWidget {
  const _StatusText({required this.primaryColor});
  final Color primaryColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerProvider);

    final (text, color) = switch (state.status) {
      ScanStatus.idle => ('Align the QR code within the circle', Colors.grey),
      ScanStatus.loading => ('Validating ticket…', Colors.grey),
      ScanStatus.success => (
      state.message ?? 'Success!',
      Colors.green.shade700,
      ),
      ScanStatus.failure => (
      state.message ?? 'Validation failed.',
      Colors.red.shade700,
      ),
    };

    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: color,
        fontWeight: state.status == ScanStatus.idle
            ? FontWeight.normal
            : FontWeight.w600,
      ),
    );
  }
}

// Manual entry dialog

class _ManualEntryDialog extends StatefulWidget {
  const _ManualEntryDialog({required this.notifier});
  final ScannerNotifier notifier;

  @override
  State<_ManualEntryDialog> createState() => _ManualEntryDialogState();
}

class _ManualEntryDialogState extends State<_ManualEntryDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop();
    await widget.notifier.validateManually(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text('Enter Ticket ID',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold
      ),),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            hintText: 'e.g. TKT-00123',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
          validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Please enter a ticket ID' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: _submit,
          child: const Text('Validate', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}