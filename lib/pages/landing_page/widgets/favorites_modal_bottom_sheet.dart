import 'package:aoeiv_leaderboard/config/styles/colors.dart';
import 'package:aoeiv_leaderboard/config/styles/spacing.dart';
import 'package:aoeiv_leaderboard/config/styles/theme.dart';
import 'package:aoeiv_leaderboard/cubit/favorites_cubit.dart';
import 'package:aoeiv_leaderboard/exceptions/no_data_exception.dart';
import 'package:aoeiv_leaderboard/models/favorite.dart';
import 'package:aoeiv_leaderboard/models/rating_history_screen_args.dart';
import 'package:aoeiv_leaderboard/widgets/centered_circular_progress_indicator.dart';
import 'package:aoeiv_leaderboard/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesModalBottomSheet extends StatefulWidget {
  const FavoritesModalBottomSheet({Key? key}) : super(key: key);

  @override
  _FavoritesModalBottomSheetState createState() => _FavoritesModalBottomSheetState();
}

class _FavoritesModalBottomSheetState extends State<FavoritesModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: Spacing.m.value,
          bottom: MediaQuery.of(context).padding.bottom,
          left: Spacing.m.value,
          right: Spacing.m.value,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kcFavoritesButtonColor,
              kcSecondaryColor,
            ],
          ),
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: Spacing.l.value),
        _buildFavoritesSection(),
      ],
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.of(context)!.favoritesModalBottomSheetHeaderTitle,
        style: Theme.of(context).textTheme.headline2?.copyWith(color: kcPrimaryColor),
      ),
    );
  }

  Widget _buildFavoritesSection() {
    return Expanded(
      child: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesNavigation) {
            Navigator.of(context).pushNamed(
              '/player',
              arguments: RatingHistoryScreenArgs(leaderboardId: state.leaderboardId!, player: state.favorite!),
            );
          }
          if (state is FavoritesError) {
            final String errorMessage =
                state.error is NoDataException ? AppLocalizations.of(context)!.errorMessageNoDataFound : AppLocalizations.of(context)!.errorMessageFetchData;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 2500),
                backgroundColor: kcTertiaryColor,
                content: Wrap(
                  spacing: Spacing.s.value,
                  children: [const Icon(Icons.warning), Text(errorMessage)],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const CenteredCircularProgressIndicator();
          }

          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: Spacing.xs.value),
            physics: const ClampingScrollPhysics(),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final Favorite favorite = state.favorites[index];

              return _buildFavoritesListItem(favorite);
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoritesListItem(Favorite favorite) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kcTertiaryColor,
            kcFavoritesButtonColor,
          ],
        ),
        boxShadow: customBoxShadow,
        borderRadius: BorderRadius.circular(kbBorderRadius),
      ),
      child: ListTile(
        onTap: () => BlocProvider.of<FavoritesCubit>(context).fetchFavorite(favorite.leaderboardId, favorite.profileId),
        dense: true,
        title: Text(
          favorite.name,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: kcPrimaryColor,
        ),
      ),
    );
  }
}
