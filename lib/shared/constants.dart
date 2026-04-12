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

/*
const avataresPessoa = {
  "Luan":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCLsOdDiVqw1jHYFLTFsZtDtSfKbfAzkdGoHzM4nLWI1WxIb0kP7sqGL2TjNJI8Xuilj8fqvIVG7nX8E5tLBnBM4A0mQ80dPL0Mlqq3ki60WXbQG4fcdsGsXT1d3CPvjro9PA_C9JKGPUJcGuqWFgqHLfBl8Ikg-vKFRDFIp9UKnyiNm2tV74gzMxFuioDe0JrdH-o03dUxOTurDfivq4BYL7y2uXDVLKtKUDe4QM2RnzHP3GHS-UdHywYQ3M47kCEpaKvc-PQhDA4",
  "Luciana":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuCt4nQEYHbjgarBON2P1qyXu9rkgL_wTlopryVYoHzlOMzVDG1r2mm0DW1VBiTu2KVPqLsoqTGZVI3l6GYylI7yvtKJ79g0CQmayvKQ061rlVGCp01DUIuMx5ijTMEZf_0jRFVGOK4jI2D9WLr3SVKZSdZHZPs7aMFv4Le9xiY3FSg16KyXf5M3JCKos2nvkiJlILyoiZoHaGEnvZeTTYjA8ig9clH_vKlO_naPrYTT6ytujH6A_0n6oJ5Y7M4yvZHZXzUWDDCY3A8",
  "Giovanna":
      "https://lh3.googleusercontent.com/aida-public/AB6AXuDnIzmHTTjmIjsYpMJNrP7AmMFitdfOqNNMZIqSGVe6B9DtUPrnNhO4nOylR2pGKD9s4tUO9rfdG_oEGlUHEQDnl3BZeEdeMnBr100NO-Awv2LmZgy-jHzicfHYWgwtGmy5fAHwNXIaeTG2yPEF0U4y9UfQVloa176F1PQFC4jmbozRDWuTR5y-IPO5e4fuJtnjerft8z-0mAo4Si3QiZuNk20eYVkHBjAkB_rgc6Tq10N8B1dWvDw3OvgYoGNB6Sa8o_KbQJhlHNs",
};
*/

const kPrimaryColor = Color(
  0xFFE63819,
); // Primary / Debt (legacy — migrate to kPrimaryOlive)
const kPaper = Color(
  0xFFF4F1EA,
); // Warm off-white (legacy — migrate to kSurfacePaper)
const kInk = Color(
  0xFF2C2C2C,
); // Black toner (legacy — migrate to kTextPrimary)
const kInkFaded = Color(0xFF6B6B6B);
const kLine = Color(0xFFD1CDC5);
const kPaid = Color(0xFF2A7F62);
const kHighlight = Color(0xFFFCEDA8);

// ============================================================
// New semantic color tokens (UX-DR1) — additive, backward compat
// ============================================================

// Core palette
const kPrimaryOlive = Color(0xFF6B705C); // New primary (calm, earthy)
const kSurfacePaper = Color(0xFFFAF6F1); // New surface (paper kraft light)
const kPaperDepth = Color(0xFFEDE8E0); // Paper shadow / depth

// Text colors
const kTextPrimary = Color(0xFF2C2825); // Warm charcoal
const kTextSecondary = Color(0xFF6B6560); // Warm gray dark
const kTextMuted = Color(0xFF8B8178); // Warm gray

// Semantic states (emotional semaphore — never red for guilt)
const kSemanticPaid = Color(0xFF2A7F62); // Green — paid/settled
const kSemanticPending = Color(0xFFD4953B); // Amber — attention
const kSemanticOverdue = Color(0xFFC2654A); // Rust — overdue

// Darker variants for text contrast (WCAG AA)
const kSemanticPaidDark = Color(0xFF1E5C45);
const kSemanticPendingDark = Color(0xFF96692A);
const kSemanticOverdueDark = Color(0xFF8E4632);

// Resident color aliases (for future use alongside coresPessoa)
const kLuanBlue = Color(0xFF3B82F6);
const kLucianaPink = Color(0xFFEC4899);
const kGiovannaPurple = Color(0xFF8B5CF6);

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

// Spacing scale (base 8px)
const kSpacingXs = 4.0;
const kSpacingSm = 8.0;
const kSpacingMd = 16.0;
const kSpacingLg = 24.0;
const kSpacingXl = 32.0;
const kSpacingXxl = 48.0;
