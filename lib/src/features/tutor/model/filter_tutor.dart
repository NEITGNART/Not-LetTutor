// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchFilter {
  Filters? filters;
  int? page;
  int? perPage;
  String? search;

  SearchFilter({this.filters, this.page, this.perPage});

  @override
  String toString() =>
      'SearchFilter(filters: $filters, page: $page, perPage: $perPage)';
}

class Filters {
  List<String>? specialties;
  String? date;
  Map? nationality;
  List<int>? tutoringTimeAvailable;

  Filters(
      {this.specialties,
      this.date,
      this.nationality,
      this.tutoringTimeAvailable});

  @override
  String toString() {
    return 'Filters(specialties: $specialties, date: $date, nationality: $nationality, tutoringTimeAvailable: $tutoringTimeAvailable)';
  }
}
