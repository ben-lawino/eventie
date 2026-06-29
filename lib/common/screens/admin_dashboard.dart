import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../../widgets/button.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, this would be a list from Firebase/API
    // For this prototype, we'll just show the current profile if it's an organizer
    final profile = ref.watch(profileProvider);
    final isPendingOrganizer = !profile.isApproved && profile.businessName != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Approvals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (isPendingOrganizer)
              Card(
                child: ListTile(
                  title: Text(profile.businessName ?? 'Unknown Business'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${profile.email}'),
                      Text('ID Number: ${profile.idNumber}'),
                      const Text('Status: PENDING', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: ElevatedButton(
                    onPressed: () {
                      ref.read(profileProvider.notifier).update(
                        profile.copyWith(isApproved: true),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Organizer Approved!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    child: const Text('Approve'),
                  ),
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('No pending approvals at the moment.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
