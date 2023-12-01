import 'dart:ui';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/controllers/movies_controller.dart';

import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/models/review.dart';
import 'package:movies_app/utils/utils.dart';
import 'package:movies_app/widgets/top_rated_item.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {
    Future<Person?> updatedPerson = ApiService.getPersonDetails(person);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Image.network(
                          Api.imageBaseUrl + person.profilePath,
                          width: Get.width,
                          height: 250,
                          fit: BoxFit.cover,
                          loadingBuilder: (_, __, ___) {
                            if (___ == null) return __;
                            return FadeShimmer(
                              width: Get.width,
                              height: 250,
                              highlightColor: const Color(0xff22272f),
                              baseColor: const Color(0xff20252d),
                            );
                          },
                          errorBuilder: (_, __, ___) => const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.broken_image,
                              size: 250,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${person.profilePath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          person.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              person.popularity == 0.0
                                  ? 'N/A'
                                  : person.popularity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<Person?>(
                          future: updatedPerson,
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!.birthday == ""
                                  // ignore: prefer_const_constructors
                                  ? Text(
                                      'Unknown',
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      person.birthday,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    );
                            } else {
                              return const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            }
                          }),
                      const Text(' | '),
                      FutureBuilder<Person?>(
                          future: updatedPerson,
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data!.placeOfBirth == ""
                                  // ignore: prefer_const_constructors
                                  ? Text(
                                      'Unknown',
                                      textAlign: TextAlign.center,
                                    )
                                  : Flexible(
                                      child: Text(
                                        person.placeOfBirth,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                            } else {
                              return const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'Biography'),
                            Tab(text: 'Known For'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<Person?>(
                                future: updatedPerson,
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data!.biography == ""
                                        ? const Padding(
                                            padding: EdgeInsets.only(top: 30.0),
                                            child: Text(
                                              'No biography available',
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Text(
                                            person.biography,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          );
                                  } else {
                                    return const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ),
                          // FutureBuilder<List<Review>?>(
                          //   future: ApiService.getMovieReviews(movie.id),
                          //   builder: (_, snapshot) {
                          //     if (snapshot.hasData) {
                          //       return snapshot.data!.isEmpty
                          //           ? const Padding(
                          //               padding: EdgeInsets.only(top: 30.0),
                          //               child: Text(
                          //                 'No review',
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //             )
                          //           : ListView.builder(
                          //               itemCount: snapshot.data!.length,
                          //               itemBuilder: (_, index) => Padding(
                          //                 padding: const EdgeInsets.all(10.0),
                          //                 child: Row(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Column(
                          //                       children: [
                          //                         SvgPicture.asset(
                          //                           'assets/avatar.svg',
                          //                           height: 50,
                          //                           width: 50,
                          //                           // fit: BoxFit.cover,
                          //                         ),
                          //                         const SizedBox(
                          //                           height: 15,
                          //                         ),
                          //                         Text(
                          //                           snapshot.data![index].rating
                          //                               .toString(),
                          //                           style: const TextStyle(
                          //                             color: Color(0xff0296E5),
                          //                           ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                     const SizedBox(
                          //                       width: 10,
                          //                     ),
                          //                     Column(
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         Text(
                          //                           snapshot
                          //                               .data![index].author,
                          //                           style: const TextStyle(
                          //                             fontSize: 16,
                          //                             fontWeight:
                          //                                 FontWeight.w400,
                          //                           ),
                          //                         ),
                          //                         const SizedBox(
                          //                           height: 10,
                          //                         ),
                          //                         SizedBox(
                          //                           width: 250,
                          //                           child: Text(snapshot
                          //                               .data![index].comment),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             );
                          //     } else {
                          //       return const Center(
                          //         child: Text('Wait...'),
                          //       );
                          //     }
                          //   },
                          // ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<Person?>(
                                future: updatedPerson,
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data!.credits.isEmpty
                                        ? const Padding(
                                            padding: EdgeInsets.only(top: 30.0),
                                            child: Text(
                                              'No movies found, check your connection',
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : GridView.builder(
                                            itemCount: person.credits.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  TopRatedItem(
                                                      movie: person
                                                          .credits[index]),
                                                ],
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 2,
                                            ),
                                          );
                                  } else {
                                    return const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
