import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/details_screen.dart';

class TopRatedItem extends StatelessWidget {
  const TopRatedItem({
    Key? key,
    required this.movie,
    // required this.index,
  }) : super(key: key);

  final Movie movie;
  // final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            () => DetailsScreen(movie: movie),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + movie.posterPath,
                fit: BoxFit.cover,
                height: 100,
                width: 80,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xff20252d),
                  child: SizedBox(
                      height: 100,
                      width: 80,
                      child: Center(
                        child: Text(
                          movie.title,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                loadingBuilder: (_, __, ___) {
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 80,
                    height: 100,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.bottomLeft,
        //   child: IndexNumber(number: index),
        // )
      ],
    );
  }
}
