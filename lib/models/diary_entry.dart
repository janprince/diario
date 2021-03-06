// This file contains the Diary Entry object definition.

class DiaryEntry {
  int? id;
  final int mood;
  final String title;
  final String entry;

  DiaryEntry(
      {this.id, required this.mood, required this.title, required this.entry});

  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
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
