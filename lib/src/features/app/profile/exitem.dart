class ExpansionPanelItem {
  ExpansionPanelItem({
    required this.headerValue,
    required this.itemList,
    this.isExpanded = false,
  });

  String headerValue;
  List<Map<String, dynamic>> itemList;
  bool isExpanded;
}
