import 'package:beatiful_ui/common/app_sizes.dart';
import 'package:beatiful_ui/features/course/discover/representation/banner.dart';
import 'package:beatiful_ui/features/course/discover/representation/book_tab.dart';
import 'package:beatiful_ui/features/course/discover/representation/interactive_tab.dart';
import 'package:flutter/material.dart';

import 'course_tab.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const DiscoveryBanner(),
            gapH12,

            gapH12,
            const Row(
              children: [
                // Expanded(child: SearchAutocompleteWithChips()),
                // Expanded(child: SearchAutocompleteWithChips()),
                // Expanded(child: SearchAutocompleteWithChips()),
                // Expanded(child: SearchAutocompleteWithChips()),
              ],
            ),
            // SearchAutocompleteWithChips(),
            // SearchAutocompleteWithChips(),

            SizedBox(
              height: 50,
              width: double.maxFinite,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  labelColor: Colors.blue,
                  controller: tabController,
                  isScrollable: true,
                  // indicator: const CircleTabIndicator(
                  //   color: Color.fromARGB(255, 16, 136, 235),
                  // ),
                  tabs: const [
                    Tab(text: 'Course'),
                    Tab(text: 'E-book'),
                    Tab(text: 'Interactive Ebook'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  CourseTab(),
                  BookTab(),
                  InteractiveTab(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class SearchAutocompleteWithChips extends StatefulWidget {
  const SearchAutocompleteWithChips({super.key});

  @override
  _SearchAutocompleteWithChipsState createState() =>
      _SearchAutocompleteWithChipsState();
}

class _SearchAutocompleteWithChipsState
    extends State<SearchAutocompleteWithChips> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _chips = [];

  final List<String> _options = [
    'Apple',
    'Banana',
    'Cherry',
    'Durian',
    'Elderberry',
    'Fig',
  ];

  List<String> _searchOptions = [];

  void _onTextChanged(String value) {
    _searchOptions = [];
    if (value.isNotEmpty) {
      for (var option in _options) {
        if (option.toLowerCase().contains(value.toLowerCase())) {
          _searchOptions.add(option);
        }
      }
    }
    setState(() {});
  }

  void _onChipAdded(String value) {
    setState(() {
      _chips.add(value);
      _textEditingController.clear();
      _searchOptions = [];
    });
  }

  void _onChipDeleted(String value) {
    setState(() {
      _chips.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              onChanged: _onTextChanged,
              // onClick of the text field
              onTap: () {
                // show the autocomplete
                setState(() {
                  // display the remaining options

                  // _options - _chips;

                  _searchOptions = _options
                      .where((option) => !_chips.contains(option))
                      .toList();
                  // _searchOptions = _options;
                });
              },
              // on click of the clear button
              decoration: InputDecoration(
                hintText: 'Set level...',
                suffixIcon: _chips.isEmpty
                    ? const Icon(Icons.search)
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          // clear the text field
                          _textEditingController.clear();
                          // hide the autocomplete
                          setState(() {
                            _searchOptions = [];
                            // clear the chips
                            _chips.clear();
                          });
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _chips
                  .map(
                    (chip) => Chip(
                      label: Text(chip),
                      onDeleted: () => _onChipDeleted(chip),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            // SizedBox(
            //   height: 200,
            //   child: ListView.builder(
            //     itemCount: _searchOptions.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return ListTile(
            //         title: Container(child: Text(_searchOptions[index])),
            //         onTap: () => _onChipAdded(_searchOptions[index]),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  const CircleTabIndicator({this.color = Colors.white});

  final Color color;

  @override
  _CirclePainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(this, onChanged!);
  }
}

class _CirclePainter extends BoxPainter {
  _CirclePainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  final CircleTabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()..color = decoration.color;
    final Offset circleOffset = offset +
        Offset(configuration.size!.width / 2, configuration.size!.height - 3);
    canvas.drawCircle(circleOffset, 3.0, paint);
  }
} 


// class SearchAutocompleteChips extends StatefulWidget {
//   const SearchAutocompleteChips({super.key});

//   @override
//   _SearchAutocompleteChipsState createState() =>
//       _SearchAutocompleteChipsState();
// }

// class _SearchAutocompleteChipsState extends State<SearchAutocompleteChips> {
//   List<String> optionsList = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Elderberry',
//     'Fig',
//     'Grape',
//     'Honeydew',
//     'Ivy gourd',
//     'Jackfruit',
//   ];

//   List<String> resultsList = [];

//   final TextEditingController _searchController = TextEditingController();
//   bool showAllOptions = true;

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(() {
//       setState(() {
//         String query = _searchController.text.toLowerCase().trim();

//         if (query.isEmpty) {
//           resultsList = [];
//           showAllOptions = true;
//         } else {
//           resultsList = optionsList
//               .where((option) => option.toLowerCase().contains(query))
//               .toList();
//           showAllOptions = false;
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           decoration: const InputDecoration(
//             hintText: 'Search...',
//             prefixIcon: Icon(Icons.search),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               showAllOptions = resultsList.isEmpty;
//             });
//           },
//           child: Wrap(
//             children: showAllOptions
//                 ? optionsList
//                     .map((option) => Chip(
//                           label: Text(option),
//                           onDeleted: () {},
//                         ))
//                     .toList()
//                 : resultsList
//                     .map((option) => Chip(
//                           label: Text(option),
//                           onDeleted: () {},
//                         ))
//                     .toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class AutocompleteChips extends StatefulWidget {
//   final List<String> optionsList;
//   final Function(List<String>) onSelected;
//   final String placeholder;

//   const AutocompleteChips({
//     super.key,
//     required this.optionsList,
//     required this.onSelected,
//     required this.placeholder,
//   });

//   @override
//   _AutocompleteChipsState createState() => _AutocompleteChipsState();
// }

// class _AutocompleteChipsState extends State<AutocompleteChips> {
//   final List<String> _selectedOptions = [];
//   List<String> _remainingOptions = [];

//   final TextEditingController _searchController = TextEditingController();
//   bool _isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _remainingOptions = widget.optionsList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InputDecorator(
//           decoration: InputDecoration(
//             border: const OutlineInputBorder(),
//             hintText: widget.placeholder,
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           ),
//           child: Wrap(
//             spacing: 8,
//             children: _selectedOptions
//                 .map(
//                   (option) => InputChip(
//                     label: Text(option),
//                     onDeleted: () => _removeOption(option),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//         TextField(
//           controller: _searchController,
//           onTap: () {
//             if (_remainingOptions.isEmpty) {
//               _isExpanded = true;
//               setState(() {});
//             }
//           },
//           onChanged: (query) {
//             _remainingOptions = widget.optionsList
//                 .where((option) =>
//                     !_selectedOptions.contains(option) &&
//                     option.toLowerCase().contains(query.toLowerCase()))
//                 .toList();
//             setState(() {});
//           },
//           onSubmitted: (_) => _addSelectedOption(_searchController.text),
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             hintText: 'Search options',
//             contentPadding: EdgeInsets.symmetric(horizontal: 16),
//           ),
//         ),
//         if (_isExpanded)
//           SizedBox(
//             height: 200,
//             child: ListView.builder(
//               itemCount: _remainingOptions.length,
//               itemBuilder: (context, index) {
//                 final option = _remainingOptions[index];
//                 return ListTile(
//                   title: Text(option),
//                   onTap: () => _addSelectedOption(option),
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }

//   void _addSelectedOption(String option) {
//     if (option.isNotEmpty) {
//       _selectedOptions.add(option);
//       _searchController.clear();
//       _remainingOptions = widget.optionsList
//           .where((option) => !_selectedOptions.contains(option))
//           .toList();
//       widget.onSelected(_selectedOptions);
//       setState(() {});
//     }
//   }

//   void _removeOption(String option) {
//     _selectedOptions.remove(option);
//     _remainingOptions = widget.optionsList
//         .where((option) => !_selectedOptions.contains(option))
//         .toList();
//     widget.onSelected(_selectedOptions);
//     setState(() {});
//   }
// }

// class SearchAutocomplete extends StatefulWidget {
//   final List<String> options;
//   final Function(List<String>) onSelected;

//   const SearchAutocomplete(
//       {super.key, required this.options, required this.onSelected});

//   @override
//   _SearchAutocompleteState createState() => _SearchAutocompleteState();
// }

// class _SearchAutocompleteState extends State<SearchAutocomplete> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final List<String> _selectedOptions = [];

//   List<String> get _remainingOptions => widget.options
//       .where((option) => !_selectedOptions.contains(option))
//       .toList();

//   List<String> get _displayedOptions =>
//       _remainingOptions.isEmpty ? widget.options : _remainingOptions;

//   void _onChipDeleted(String option) {
//     setState(() {
//       _selectedOptions.remove(option);
//     });
//     widget.onSelected(_selectedOptions);
//   }

//   void _onOptionSelected(String option) {
//     setState(() {
//       _selectedOptions.add(option);
//       _textEditingController.clear();
//     });
//     widget.onSelected(_selectedOptions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Wrap(
//           spacing: 8,
//           children: _selectedOptions
//               .map((option) => Chip(
//                     label: Text(option),
//                     onDeleted: () => _onChipDeleted(option),
//                   ))
//               .toList(),
//         ),
//         TextField(
//           controller: _textEditingController,
//           onChanged: (_) => setState(() {}), // to update the displayed options
//           decoration: const InputDecoration(
//             labelText: 'Search',
//             border: OutlineInputBorder(),
//             suffixIcon: Icon(Icons.search),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: _displayedOptions
//               .map((option) => ActionChip(
//                     label: Text(option),
//                     onPressed: () => _onOptionSelected(option),
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class AppProfile {
//   final String name;
//   final String email;
//   final String imageUrl;

//   const AppProfile(this.name, this.email, this.imageUrl);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is AppProfile &&
//           runtimeType == other.runtimeType &&
//           name == other.name;

//   @override
//   int get hashCode => name.hashCode;

//   @override
//   String toString() {
//     return name;
//   }
// }

// const mockResults = <AppProfile>[
//   AppProfile('John Doe', 'jdoe@flutter.io',
//       'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
//   AppProfile('Paul', 'paul@google.com',
//       'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
//   AppProfile('Fred', 'fred@google.com',
//       'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
//   AppProfile('Brian', 'brian@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('John', 'john@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Thomas', 'thomas@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Nelly', 'nelly@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Marie', 'marie@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Charlie', 'charlie@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Diana', 'diana@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Ernie', 'ernie@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
//   AppProfile('Gina', 'fred@flutter.io',
//       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
// ]; 

// class SearchAutocompleteWithChips extends StatefulWidget {
//   const SearchAutocompleteWithChips({super.key});

//   @override
//   _SearchAutocompleteWithChipsState createState() =>
//       _SearchAutocompleteWithChipsState();
// }

// class _SearchAutocompleteWithChipsState
//     extends State<SearchAutocompleteWithChips> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final List<String> _chips = [];

//   final List<String> _options = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Durian',
//     'Elderberry',
//     'Fig',
//     'Grape',
//     'Honeydew',
//     'Isabella grape',
//     'Jackfruit',
//     'Kiwi',
//     'Lemon',
//     'Mango',
//     'Nectarine',
//     'Orange',
//     'Pineapple',
//     'Quince',
//     'Raspberry',
//     'Strawberry',
//     'Tangerine',
//     'Ugli fruit',
//     'Vanilla bean',
//     'Watermelon',
//     'Xigua (Chinese watermelon)',
//     'Yellow passionfruit',
//     'Zinfandel grapes'
//   ];

//   List<String> _searchOptions = [];

//   bool _isSearching = false;

//   void _onFocusChanged(bool hasFocus) {
//     if (hasFocus && _textEditingController.text.isEmpty) {
//       _searchOptions = List<String>.from(_options);
//       _isSearching = false;
//     } else {
//       _isSearching = true;
//     }
//     setState(() {});
//   }

//   void _onTextChanged(String value) {
//     if (value.isEmpty) {
//       _searchOptions = List<String>.from(_options);
//       _isSearching = false;
//     } else {
//       _searchOptions = [];
//       for (var option in _options) {
//         if (option.toLowerCase().contains(value.toLowerCase())) {
//           _searchOptions.add(option);
//         }
//       }
//       _isSearching = true;
//     }
//     setState(() {});
//   }

//   void _onChipAdded(String value) {
//     setState(() {
//       _chips.add(value);
//       _textEditingController.clear();
//       _searchOptions = [];
//       _isSearching = false;
//     });
//   }

//   void _onChipDeleted(String value) {
//     setState(() {
//       _chips.remove(value);
//     });
//   }

//   Widget _buildChips() {
//     if (_chips.isEmpty) {
//       return Container();
//     }
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: _chips
//           .map(
//             (chip) => InputChip(
//               label: Text(chip),
//               onDeleted: () => _onChipDeleted(chip),
//             ),
//           )
//           .toList(),
//     );
//   }

//   Widget _buildOptions() {
//     if (!_isSearching) {
//       return Container();
//     }
//     return Expanded(
//       child: ListView.builder(
//         itemCount: _searchOptions.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_searchOptions[index]),
//             onTap: () => _onChipAdded(_searchOptions[index]),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               child: TextField(
//                 controller: _textEditingController,
//                 onTap: () {
//                   if (_textEditingController.text.isEmpty) {
//                     _onFocusChanged(true);
//                   }
//                 },
//                 onChanged: _onTextChanged,
//                 // sho
//                 decoration: InputDecoration(
//                     hintText: 'Search for a fruit',
//                     border: const OutlineInputBorder(),
//                     prefix: Wrap(children: [
//                       ..._chips.map((chip) => InputChip(
//                             label: Text(chip),
//                             onDeleted: () => _onChipDeleted(chip),
//                           ))
//                     ])),
//               ),
//             ),
//             _buildOptions(),
//           ],
//         ),
//       ),
//     );
//   }
// }
