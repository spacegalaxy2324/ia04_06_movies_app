import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movies_controller.dart';
import 'package:movies_app/controllers/search_controller.dart';
import 'package:movies_app/widgets/other_person.dart';
import 'package:movies_app/widgets/top_rated_person.dart';

class NewHomeScreen extends StatelessWidget {
  NewHomeScreen({Key? key}) : super(key: key);

  final MoviesController controller = Get.put(MoviesController());
  final SearchController1 searchController = Get.put(SearchController1());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'TMDB Actors',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 46,
            ),
            Obx(
              (() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        itemCount: controller.popularPeople.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => TopRatedPerson(
                            person: controller.popularPeople[index],
                            index: index + 1),
                      ),
                    )),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Other popular people',
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.75),
                )),
            const SizedBox(
              height: 24,
            ),
            Obx(
              (() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 170,
                      child: ListView.separated(
                        itemCount: controller.otherPopularPeople.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 24),
                        itemBuilder: (_, index) => OtherPerson(
                            person: controller.otherPopularPeople[index],
                            index: index + 1),
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}
