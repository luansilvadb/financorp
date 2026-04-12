import 'package:flutter_riverpod/flutter_riverpod.dart';

class Period {
  final int mes;
  final int ano;
  Period(this.mes, this.ano);

  Period copyWith({int? mes, int? ano}) {
    return Period(mes ?? this.mes, ano ?? this.ano);
  }
}

class PeriodNotifier extends Notifier<Period> {
  @override
  Period build() => Period(DateTime.now().month - 1, DateTime.now().year);

  void setMes(int mes) => state = state.copyWith(mes: mes);
  void setAno(int ano) => state = state.copyWith(ano: ano);

  void nextMonth() {
    int nextM = state.mes + 1;
    int nextY = state.ano;
    if (nextM > 11) {
      nextM = 0;
      nextY++;
    }
    state = Period(nextM, nextY);
  }

  void prevMonth() {
    int prevM = state.mes - 1;
    int prevY = state.ano;
    if (prevM < 0) {
      prevM = 11;
      prevY--;
    }
    state = Period(prevM, prevY);
  }

  void nextYear() => state = state.copyWith(ano: state.ano + 1);
  void prevYear() => state = state.copyWith(ano: state.ano - 1);

  void resetToToday() {
    state = Period(DateTime.now().month - 1, DateTime.now().year);
  }

  bool isToday(int mes) {
    final now = DateTime.now();
    return mes == (now.month - 1) && state.ano == now.year;
  }
}

final periodProvider = NotifierProvider<PeriodNotifier, Period>(() {
  return PeriodNotifier();
});
