import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/history.dart';

class HistoryRepository {
  final List<HistoryInfo> _history = historyInfo;

  List<HistoryInfo> get history => _history;

  Future<List<HistoryInfo>> getHistory() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    return Future.value(_history);
  }

  Stream<List<HistoryInfo>> watchHistory() async* {
    await Future.delayed(const Duration(milliseconds: 500));
    yield _history;
  }
}

final hitoryRespository = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});

final historyListFutureProvider =
    FutureProvider.autoDispose<List<HistoryInfo>>((ref) {
  final repository = ref.watch(hitoryRespository);
  return repository.getHistory();
});

final historyProvider = StreamProvider.autoDispose<List<HistoryInfo>>((ref) {
  final repository = ref.watch(hitoryRespository);
  return repository.watchHistory();
});
