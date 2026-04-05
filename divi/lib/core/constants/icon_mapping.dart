import 'package:flutter/material.dart';

/// Icon mapping table for migrating from PhosphorIcons to Lucide icons (via forui_assets).
///
/// This file documents all icon mappings needed for the UI/UX refactoring to use
/// forui.dev exclusively. Each entry maps a PhosphorIcon name and style to its
/// closest Lucide icon equivalent.
///
/// Usage:
/// ```dart
/// // Instead of: PhosphorIcons.receipt(PhosphorIconsStyle.fill)
/// // Use: IconMapping.receiptFill (which maps to Lucide icon)
/// ```
///
/// Note: The actual Lucide icon access will be implemented during Phase 3 migration.
/// This table serves as a reference for the migration work.
class IconMapping {
  // Receipt icons
  static const String receiptFill = 'receipt'; // PhosphorIcons.receipt(fill) -> LucideIcons.receipt
  static const String receiptRegular = 'receipt'; // PhosphorIcons.receipt(regular) -> LucideIcons.receipt
  
  // Folder icons
  static const String folderOpenFill = 'folder-open'; // PhosphorIcons.folderOpen(fill) -> LucideIcons.folderOpen
  static const String folderOpenRegular = 'folder-open'; // PhosphorIcons.folderOpen(regular) -> LucideIcons.folderOpen
  static const String folderSimpleFill = 'folder'; // PhosphorIcons.folderSimple(fill) -> LucideIcons.folder
  
  // Status icons
  static const String checkCircleFill = 'check-circle'; // PhosphorIcons.checkCircle(fill) -> LucideIcons.checkCircle
  static const String checkCircleRegular = 'check-circle'; // PhosphorIcons.checkCircle(regular) -> LucideIcons.checkCircle
  static const String warningCircleFill = 'alert-circle'; // PhosphorIcons.warningCircle(fill) -> LucideIcons.alertCircle (closest match)
  
  // Navigation icons
  static const String caretRightBold = 'chevron-right'; // PhosphorIcons.caretRight(bold) -> LucideIcons.chevronRight
  static const String caretLeftBold = 'chevron-left'; // PhosphorIcons.caretLeft(bold) -> LucideIcons.chevronLeft
  static const String caretLeftRegular = 'chevron-left'; // PhosphorIcons.caretLeft(regular) -> LucideIcons.chevronLeft
  
  // Action icons
  static const String pencilSimpleRegular = 'pencil'; // PhosphorIcons.pencilSimple(regular) -> LucideIcons.pencil
  static const String plusCircleRegular = 'plus-circle'; // PhosphorIcons.plusCircle(regular) -> LucideIcons.plusCircle
  static const String xCircleFill = 'x-circle'; // PhosphorIcons.xCircle(fill) -> LucideIcons.xCircle
  static const String xCircleRegular = 'x-circle'; // PhosphorIcons.xCircle(regular) -> LucideIcons.xCircle
  static const String trashRegular = 'trash'; // PhosphorIcons.trash(regular) -> LucideIcons.trash
  static const String trashFill = 'trash'; // PhosphorIcons.trash(fill) -> LucideIcons.trash
  
  // Location/building icons
  static const String houseLineFill = 'home'; // PhosphorIcons.houseLine(fill) -> LucideIcons.home
  
  // Search icons
  static const String magnifyingGlassBold = 'search'; // PhosphorIcons.magnifyingGlass(bold) -> LucideIcons.search
  
  // Navigation/refresh icons
  static const String arrowClockwiseBold = 'refresh-cw'; // PhosphorIcons.arrowClockwise(bold) -> LucideIcons.refreshCw
  static const String arrowCounterClockwiseRegular = 'rotate-ccw'; // PhosphorIcons.arrowCounterClockwise(regular) -> LucideIcons.counterClockwise (or rotate-ccw)
  
  // Financial icons
  static const String piggyBankRegular = 'piggy-bank'; // PhosphorIcons.piggyBank(regular) -> LucideIcons.piggyBank
  static const String creditCardRegular = 'credit-card'; // PhosphorIcons.creditCard(regular) -> LucideIcons.creditCard
  
  // Brand/logo icons
  static const String intersectFill = 'intersect'; // PhosphorIcons.intersect(fill) -> LucideIcons.intersect
  
  // Summary icons
  static const String receipt = 'receipt'; // Used in despesa_details_sheet
}

/// Helper class to get Lucide icon data from PhosphorIcon references.
/// This will be used during Phase 3 to replace all PhosphorIcon usages.
class IconMapper {
  /// Maps a PhosphorIcons reference to the corresponding Lucide icon name.
  /// Returns the Lucide icon name as a string.
  static String mapPhosphorIconToLucide(String phosphorIconName, String style) {
    // Normalize style to just the key part (handle both "fill" and "PhosphorIconsStyle.fill")
    String normalizedStyle = style.toLowerCase()
        .replaceAll('phosphoriconsstyle.', '')
        .replaceAll(RegExp(r'[\s()]+'), '');
    
    // Create lookup key - normalize icon name + style
    String key = phosphorIconName.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    if (normalizedStyle.contains('fill')) {
      key += 'fill';
    } else if (normalizedStyle.contains('regular')) {
      key += 'regular';
    } else if (normalizedStyle.contains('bold')) {
      key += 'bold';
    }
    
    // Map based on known conversions
    switch (key) {
      case 'receiptfill':
      case 'receiptregular':
        return IconMapping.receiptFill;
      case 'folderopenfill':
      case 'folderopenregular':
        return IconMapping.folderOpenFill;
      case 'foldersimplefill':
        return IconMapping.folderSimpleFill;
      case 'checkcirclefill':
      case 'checkcircleregular':
        return IconMapping.checkCircleFill;
      case 'warningcirclefill':
        return IconMapping.warningCircleFill;
      case 'caretrightbold':
        return IconMapping.caretRightBold;
      case 'caretleftbold':
      case 'caretleftregular':
        return IconMapping.caretLeftBold;
      case 'pencilsimpleregular':
        return IconMapping.pencilSimpleRegular;
      case 'pluscircleregular':
        return IconMapping.plusCircleRegular;
      case 'xcirclefill':
      case 'xcircleregular':
        return IconMapping.xCircleFill;
      case 'trashregular':
      case 'trashfill':
        return IconMapping.trashRegular;
      case 'houselinefill':
        return IconMapping.houseLineFill;
      case 'magnifyingglassbold':
        return IconMapping.magnifyingGlassBold;
      case 'arrowclockwisebold':
        return IconMapping.arrowClockwiseBold;
      case 'arrowcounterclockwiseregular':
        return IconMapping.arrowCounterClockwiseRegular;
      case 'piggybankregular':
        return IconMapping.piggyBankRegular;
      case 'creditcardregular':
        return IconMapping.creditCardRegular;
      case 'intersectfill':
        return IconMapping.intersectFill;
      default:
        // Fallback: return the icon name as-is (will need manual review)
        return phosphorIconName.toLowerCase();
    }
  }
}
