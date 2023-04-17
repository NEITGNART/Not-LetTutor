final List<HistoryInfo> historyInfo = [
  // create history info
  HistoryInfo(
      date: 'Fri, 30, 2022',
      lesson: 2,
      lessonTime: '18:30 - 18:55',
      videoUrl: '',
      requestContent: 'I want to learn more about the future of technology',
      reviewContent:
          'I really enjoyed the lesson. I learned a lot about the future of technology. I would like to have more lessons with this tutor.'),
  // create history info with no review
  HistoryInfo(
      date: 'Fri, 30, 2022',
      lesson: 2,
      lessonTime: '18:30 - 18:55',
      videoUrl: '',
      requestContent:
          'I want to learn more about the future of technology I really enjoyed the lesson. I learned a lot about the future of technology. I would like to have more lessons with this tutor.',
      reviewContent: null),
  // create history info with no request
  HistoryInfo(
      date: 'Fri, 30, 2022',
      lesson: 2,
      lessonTime: '18:30 - 18:55',
      videoUrl: '',
      requestContent: null,
      reviewContent:
          'I really enjoyed the lesson. I learned a lot about the future of technology. I would like to have more lessons with this tutor.'),
  // create history info with no request and no review
  HistoryInfo(
      date: 'Fri, 30, 2022',
      lesson: 2,
      lessonTime: '18:30 - 18:55',
      videoUrl: '',
      requestContent: null,
      reviewContent: null),
];

class HistoryInfo {
  final String date;
  final int lesson;
  final String lessonTime;
  final String videoUrl;

  static const String requestTitle = 'Request from student';
  String? requestContent;

  static const String reviewTitle = 'Review from tutor';
  String? reviewContent;

  HistoryInfo({
    required this.date,
    required this.lesson,
    required this.lessonTime,
    required this.videoUrl,
    this.requestContent,
    this.reviewContent,
  });
}
