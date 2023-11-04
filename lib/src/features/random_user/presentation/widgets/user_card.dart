import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity? user;
  final bool? isRemovable;
  final void Function(UserEntity user)? onRemove;
  final void Function(UserEntity user)? onUserPressed;

  const UserCard({
    super.key,
    this.user,
    this.isRemovable = false,
    this.onRemove,
    this.onUserPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
          onPressed: _onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildImage(context),
                _buildUserDescription(),
                _buildRemoveArea(),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if(user!.urlToThumbnail == null) {
      return const Icon(Icons.person);
    }
    return CachedNetworkImage(
        imageUrl: user!.urlToThumbnail!,
        imageBuilder : (context, imageProvider) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: SizedBox(
            width: 75.0,
            height: 75.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
          ),
        ),
        progressIndicatorBuilder : (context, url, downloadProgress) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height:  double.maxFinite,
              child: const CupertinoActivityIndicator(),
            ),
          ),
        ),
        errorWidget : (context, url, error) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: const Icon(Icons.error),
                ),
              ),
            )
    );
  }

  Widget _buildUserDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Text(
          '${user!.firstName?? ''} ${user!.lastName?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveArea() {
    if (isRemovable!) {
      return GestureDetector(
        onTap: _onRemove,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.remove_circle_outline, color: Colors.red),
        ),
      );
    }
    return Container();
  }

  void _onTap() {
    if (onUserPressed != null) {
      onUserPressed!(user!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(user!);
    }
  }
}
