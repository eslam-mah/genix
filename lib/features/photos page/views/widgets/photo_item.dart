import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:genix/features/photos%20page/data/models/photos_model.dart';

class PhotoItem extends StatelessWidget {
  final PhotosModel photosModel;

  const PhotoItem({super.key, required this.photosModel});

  void _openImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: photosModel.fileUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openImageDialog(context),
      child: CachedNetworkImage(
        imageUrl: photosModel.fileUrl,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
