import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/screens/person_details_screen.dart';
import 'package:movies_app/widgets/index_number.dart';

class TopRatedPerson extends StatelessWidget {
  const TopRatedPerson({
    Key? key,
    required this.person,
    required this.index,
  }) : super(key: key);

  final Person person;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            PersonDetailsScreen(person: person),
          ),
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                Api.imageBaseUrl + person.profilePath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
                errorBuilder: (_, __, ___) => Container(
                  color: Color(0xff20252d),
                  height: 250,
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person, size: 180, color: Colors.white),
                      const Text('NO IMAGE')
                    ],
                  ),
                ),
                loadingBuilder: (_, __, ___) {
                  if (___ == null) return __;
                  return const FadeShimmer(
                    width: 180,
                    height: 250,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          width: 180,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IndexNumber(number: index),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF242A32),
                      ],
                    )),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        person.name,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
