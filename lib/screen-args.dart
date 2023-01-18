class ScreenArgs {
  final String dirPath;
  final String filePath;

  int activeTab;

  ScreenArgs(
      {required this.dirPath, required this.filePath, this.activeTab = 0});
}
