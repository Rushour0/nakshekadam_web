class StudentTypeInfoData {
  static const data = [
    StudentTypeInfo(
      title: 'Type 1',
      description:
          'I am completely lost about what I am interested in as of now.',
      content:
          'Includes all students who are feeling completely lost about what they are interested in. They are suggested to give our comprehensive tests based on various researched parameters mentioned in their reports. You can download their reports and conversation summaries with Vidya bot in advance if they have chosen to opt for those routes to guide them better.',
    ),
    StudentTypeInfo(
      title: 'Type 2',
      description:
          "Interested in a few subject combinations but not really sure about whether it's my calling.",
      content:
          'Interested in their selected domain but have doubts. These students are suggested to give a selective test in advance. You can download their reports and conversation summaries with Vidya bot in advance if they have chosen to opt for those routes to guide them better.',
    ),
    StudentTypeInfo(
      title: 'Type 3',
      description:
          "I am fairly sure about which subjects I want to take up but I have my doubts.",
      content:
          'Includes students who are fairly sure about which subjects they want to take up but have their doubts. We have suggested that they contact industry mentors.',
    ),
    StudentTypeInfo(
      title: 'Type 4',
      description: 'Feeling pressured by friends or family? Feeling low?',
      content:
          'These students have experienced feelings of pressure from their friends or family regarding various career choices. We have consulted them to speak with in-app counsellors for professional help.',
    )
  ];
}

class StudentTypeInfo {
  const StudentTypeInfo({
    required this.title,
    required this.content,
    required this.description,
  });
  final String content, description, title;
}
