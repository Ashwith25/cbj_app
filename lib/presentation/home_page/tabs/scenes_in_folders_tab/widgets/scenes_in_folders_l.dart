import 'package:auto_route/auto_route.dart';
import 'package:cybear_jinni/application/folders_of_scenes/folders_of_scenes_bloc.dart';
import 'package:cybear_jinni/domain/folder_of_scenes/folder_of_scene.dart';
import 'package:cybear_jinni/domain/folder_of_scenes/folder_of_scenes_failures.dart';
import 'package:cybear_jinni/presentation/routes/app_router.gr.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScenesInFoldersL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<FoldersOfScenesBloc, FoldersOfScenesState>(
      builder: (context, state) {
        return state.map(
          (value) => const Text('sd'),
          loading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (state) {
            return ListView.builder(
              reverse: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final sceneFolder =
                    state.foldersOfScenes.foldersOfScenesList[index];
                return scenesFoldersWidget(
                  context,
                  sceneFolder,
                );
              },
              itemCount: state.foldersOfScenes.foldersOfScenesList.size,
            );
          },
          error: (_) {
            return const Text('Error');
          },
        );
      },
    );
  }

  Widget scenesFoldersWidget(BuildContext context,
      Either<FolderOfScenesFailures<dynamic>, FolderOfScenes> folderOfScenes) {
    const double borderRadius = 5;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(
            folderOfScenes.fold((l) => null!, (r) => r.backgroundImageUrl!),
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(
          color: Colors.black.withOpacity(0.7),
          width: 0.4,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.zero,
          ),
        ),
        onPressed: () {
          context.router.push(ScenesRoute(
            folderOfScenes: folderOfScenes.fold((l) => null!, (r) => r),
          ));
        },
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
              ),
              child: Text(
                folderOfScenes.fold((l) => 'NoName', (r) => r.name!),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
