import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class videoWidget extends StatelessWidget {
  final String url;
  const videoWidget({
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }
              },
              errorBuilder: (_, error, stackTrace) {
                return const Center(
                    child: Icon(
                  Icons.wifi,
                  color: Colors.white,
                ));
              },
            )),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
