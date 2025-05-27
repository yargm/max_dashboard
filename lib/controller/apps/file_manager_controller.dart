import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:maxdash/controller/my_controller.dart';

class FileManagerController extends MyController {
  List<Map<String, dynamic>> indexFiles = [
    {"name": "Documents", "icon": LucideIcons.folder},
    {"name": "Photos", "icon": LucideIcons.image},
    {"name": "Videos", "icon": LucideIcons.video},
    {"name": "Shared", "icon": LucideIcons.users},
    {"name": "Downloads", "icon": LucideIcons.download},
    {"name": "Trash", "icon": LucideIcons.trash_2},
    {"name": "Music", "icon": LucideIcons.music},
    {"name": "Projects", "icon": LucideIcons.briefcase},
    {"name": "Archives", "icon": LucideIcons.archive},
    {"name": "Receipts", "icon": LucideIcons.file_text},
    {"name": "Favorites", "icon": LucideIcons.star},
    {"name": "Notes", "icon": LucideIcons.file_text}
  ];
}
