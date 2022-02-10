// This file contains the Diary Entry object definition.

class DiaryEntry {
  final String date;
  final String title;
  final String entry;

  DiaryEntry({required this.date, required this.title, required this.entry});

  Map<String, String> toMap() {
    return {
      'date': date,
      'title': title,
      'entry': entry,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'DiaryEntry{title: ${title}}';
  }
}
