import 'package:pjbooks/backend/user_prefs.dart';
import 'package:pjbooks/bookPages/book.dart';
import 'package:pjbooks/bookPages/home_screen.dart';
import 'package:pjbooks/book_service.dart';
import 'package:pjbooks/common/color_extenstion.dart';
import 'package:pjbooks/view/book_reading/book_reading_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../common_widget/best_seller_cell.dart';
import '../../common_widget/genres_cell.dart';
import '../../common_widget/recently_cell.dart';
// import '../../common_widget/round_button.dart';
// import '../../common_widget/round_textfield.dart';
import '../../common_widget/top_picks_cell.dart';
// import '../login/sign_up_view.dart';
import '../main_tab/main_tab_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  BookService service = BookService();

  List topPicksArr = [];

  List bestArr = [];

  List genresArr = [];

  List recentArr = [];

  List allBooks = [];

  @override
  void initState() {
    super.initState();
    load_top_pick();
    load_most_rated();
    load_genres_user();
    load_recent_added();
    load_books();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.5,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                        color: TColor.primary,
                        borderRadius: BorderRadius.circular(media.width * 0.5),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: media.width * 0.1),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Row(
                        children: const [
                          Text(
                            "Our Top Picks",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      leading: Container(),
                      leadingWidth: 1,
                      actions: [
                        IconButton(
                          key: Key("menu"),
                          onPressed: () {
                            sideMenuScaffoldKey.currentState?.openEndDrawer();
                          },
                          icon: const Icon(Icons.menu, size: 50),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.5,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (
                          BuildContext context,
                          int itemIndex,
                          int pageViewIndex,
                        ) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return GestureDetector(
                            onTap: () {
                              openBookById(iObj['id'], context);
                            },

                            child: TopPicksCell(iObj: iObj),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: false,
                          aspectRatio: 1,
                          enlargeCenterPage: true,
                          viewportFraction: 0.45,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Bestsellers",
                            style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.6,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: bestArr.length,
                        itemBuilder: ((context, index) {
                          var bObj = bestArr[index] as Map? ?? {};

                          return GestureDetector(
                            onTap: () {
                              openBookById(bObj['id'], context);
                            },

                            child: TopPicksCell(iObj: bObj),
                          );
                        }),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Genres",
                            style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.3,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: genresArr.length,
                        itemBuilder: ((context, index) {
                          String bObj = genresArr[index] ?? "";

                          return GenresCell(
                            bObj: bObj,
                            bgcolor:
                                index % 2 == 0 ? TColor.color1 : TColor.color2,
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: media.width * 0.1),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Recently Added",
                            style: TextStyle(
                              color: TColor.text,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.5,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: recentArr.length,
                        itemBuilder: ((context, index) {
                          var bObj = recentArr[index] as Map? ?? {};

                          return GestureDetector(
                            onTap: () {
                              openBookById(bObj['id'], context);
                            },

                            child: TopPicksCell(iObj: bObj),
                          );
                        }),
                      ),
                    ),
                    // SizedBox(
                    //   height: media.width * 0.1,
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(children: [
                    //     Text(
                    //       "Monthly Newsletter",
                    //       style: TextStyle(
                    //           color: TColor.text,
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.w700),
                    //     )
                    //   ]),
                    // ),
                    // Container(
                    //   width: double.maxFinite,
                    //   margin: const EdgeInsets.symmetric(
                    //       vertical: 20, horizontal: 20),
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 15, horizontal: 15),
                    //   decoration: BoxDecoration(
                    //       color: TColor.textbox.withOpacity(0.4),
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Receive our monthly newsletter and receive updates on new stock, books and the occasional promotion.",
                    //           style: TextStyle(
                    //             color: TColor.subTitle,
                    //             fontSize: 12,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 15,
                    //         ),
                    //         RoundTextField(
                    //           controller: txtName,
                    //           hintText: "Name",
                    //         ),
                    //         const SizedBox(
                    //           height: 15,
                    //         ),
                    //         RoundTextField(
                    //           controller: txtEmail,
                    //           hintText: "Email Address",
                    //         ),
                    //         const SizedBox(
                    //           height: 15,
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             MiniRoundButton(
                    //               title: "Sign Up",
                    //               onPressed: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             const SignUpView()));
                    //               },
                    //             )
                    //           ],
                    //         )
                    //       ]),
                    // ),
                    // SizedBox(
                    //   height: media.width * 0.1,
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void load_top_pick() async {
    await service.loadBooksTopPick();
    setState(() {
      topPicksArr = service.books_top_pick;
    });
  }

  void load_most_rated() async {
    await service.loadBooksRated();
    setState(() {
      bestArr = service.books_most_rated;
    });
  }

  void load_genres_user() async {
    final genres = await UserPrefs.getGenres();
    setState(() {
      genresArr = genres ?? []; // ברירת מחדל אם לא קיים
    });
  }

  void load_recent_added() async {
    await service.loadBooksRecentAdded();
    setState(() {
      recentArr = service.books_recent_added;
    });
  }

  void load_books() async {
    await service.loadBooks();
    setState(() {
      allBooks = service.books;
    });
  }

  void openBookById(String bookId, BuildContext context) {
    var fullBook = allBooks.firstWhere(
      (book) => book['id'] == bookId,
      orElse: () => <String, dynamic>{},
    );

    if (fullBook.isEmpty) {
      // אפשר להציג הודעת שגיאה
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Book not found.")));
      return;
    }

    final Book newBook = Book(
      title: fullBook["title"] ?? "",
      coverImage: fullBook["pages"]?[0]?["img_url"] ?? "",
      pages:
          (fullBook["pages"] as List<dynamic>? ?? []).map((page) {
              return BookPage(
                imagePath: page["img_url"] ?? "",
                text: page["text_page"] ?? "",
                voiceUrl: page["voice_file_url"] ?? "",
              );
            }).toList()
            ..add(
              BookPage(imagePath: "", text: "", voiceUrl: "", isEndPage: true),
            ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(book: newBook)),
    );
  }
}
