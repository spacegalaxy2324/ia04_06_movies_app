import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/screens/person_details_screen.dart';
import 'package:movies_app/widgets/index_number.dart';

class OtherPerson extends StatelessWidget {
  const OtherPerson({
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              Api.imageBaseUrl + person.profilePath,
              fit: BoxFit.cover,
              height: 150,
              width: 100,
              errorBuilder: (_, __, ___) => Container(
                height: 150,
                width: 100,
                child: const Icon(Icons.person, size: 180, color: Colors.white),
              ),
              loadingBuilder: (_, __, ___) {
                if (___ == null) return __;
                return const FadeShimmer(
                  width: 100,
                  height: 150,
                  highlightColor: Color(0xff22272f),
                  baseColor: Color(0xff20252d),
                );
              },
            ),
          ),
        ),
        SizedBox(
            width: 100,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  person.name,
                  overflow: TextOverflow.ellipsis,
                )))
      ],
    );
  }
}
