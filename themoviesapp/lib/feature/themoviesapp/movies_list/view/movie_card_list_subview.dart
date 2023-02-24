import 'package:flutter/material.dart';
import '../../../../product/route/generate_route.dart';
import '../../../product/widget/movie_card.dart';
import '../model/movie_list_model.dart';

class MovieCardListSubView extends StatelessWidget {
  const MovieCardListSubView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<Movie> list;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return InkWell(
            key: Key('item_${index}_card'),
            onTap: () {
              Navigator.pushNamed(context, movieDetailViewRoute,
                  arguments: list[index].id);
            },
            child: MovieCard(movie: list[index], context: context),
          );
        },
        childCount: list.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
      ),
    );
  }
}
