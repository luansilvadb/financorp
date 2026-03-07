import 'package:flutter/material.dart';

/// Global key for showing SnackBars from anywhere (e.g., optimistic rollback errors).
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const pessoas = ["Luan", "Luciana", "Giovanna"];

const mesesAbrev = [
  "Jan",
  "Fev",
  "Mar",
  "Abr",
  "Mai",
  "Jun",
  "Jul",
  "Ago",
  "Set",
  "Out",
  "Nov",
  "Dez",
];

const mesesFull = [
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro",
];

const coresPessoa = {
  "Luan": Color(0xFF3b82f6),
  "Luciana": Color(0xFFec4899),
  "Giovanna": Color(0xFF8b5cf6),
};

const avataresPessoa = {
  "Luan":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCLsOdDiVqw1jHYFLTFsZtDtSfKbfAzkdGoHzM4nLWI1WxIb0kP7sqGL2TjNJI8Xuilj8fqvIVG7nX8E5tLBnBM4A0mQ80dPL0Mlqq3ki60WXbQG4fcdsGsXT1d3CPvjro9PA_C9JKGPUJcGuqWFgqHLfBl8Ikg-vKFRDFIp9UKnyiNm2tV74gzMxFuioDe0JrdH-o03dUxOTurDfivq4BYL7y2uXDVLKtKUDe4QM2RnzHP3GHS-UdHywYQ3M47kCEpaKvc-PQhDA4",
  "Luciana":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCt4nQEYHbjgarBON2P1qyXu9rkgL_wTlopryVYoHzlOMzVDG1r2mm0DW1VBiTu2KVPqLsoqTGZVI3l6GYylI7yvtKJ79g0CQmayvKQ061rlVGCp01DUIuMx5ijTMEZf_0jRFVGOK4jI2D9WLr3SVKZSdZHZPs7aMFv4Le9xiY3FSg16KyXf5M3JCKos2nvkiJlILyoiZoHaGEnvZeTTYjA8ig9clH_vKlO_naPrYTT6ytujH6A_0n6oJ5Y7M4yvZHZXzUWDDCY3A8",
  "Giovanna":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuDnIzmHTTjmIjsYpMJNrP7AmMFitdfOqNNMZIqSGVe6B9DtUPrnNhO4nOylR2pGKD9s4tUO9rfdG_oEGlUHEQDnl3BZeEdeMnBr100NO-Awv2LmZgy-jHzicfHYWgwtGmy5fAHwNXIaeTG2yPEF0U4y9UfQVloa176F1PQFC4jmbozRDWuTR5y-IPO5e4fuJtnjerft8z-0mAo4Si3QiZuNk20eYVkHBjAkB_rgc6Tq10N8B1dWvDw3OvgYoGNB6Sa8o_KbQJhlHNs",
};

const kPrimaryColor = Color(0xFFE63819); // Primary / Debt
const kPaper = Color(0xFFF4F1EA); // Warm off-white
const kInk = Color(0xFF2C2C2C); // Black toner
const kInkFaded = Color(0xFF6B6B6B);
const kLine = Color(0xFFD1CDC5);
const kPaid = Color(0xFF2A7F62);
const kHighlight = Color(0xFFFCEDA8);

// Remaining values for compatibility until removed
const kBackgroundLight = kPaper;
const kBackgroundDark = kInk;
const kSlate900 = kInk;
const kSlate600 = kInkFaded;
const kSlate500 = kInkFaded;
const kSlate400 = kLine;
const kSlate200 = kLine;
const kSlate100 = Color(0xFFFFFFFF); // White paper layer
const kGreen500 = kPaid;
const kRed500 = kPrimaryColor;
