import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchOpenProvider = StateProvider<bool>((ref) => false);
final searchQueryProvider = StateProvider<String>((ref) => '');
