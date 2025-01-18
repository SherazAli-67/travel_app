import 'package:flutter/material.dart';
import 'package:travel_app/src/res/app_text_styles.dart';

class AvatarStackWidget extends StatelessWidget {
  final List<String> avatarUrls; // URLs or asset paths of the images
  final String overlayText;

  const AvatarStackWidget({
    super.key,
    required this.avatarUrls,
    required this.overlayText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjust based on avatar size
      child: Stack(
        children: [
          ...List.generate(avatarUrls.length, (index) {
            return Positioned(
              left: index * 40.0, // Adjust overlap distance
              child: CircleAvatar(
                radius: 25, // Adjust size as needed
                backgroundImage: NetworkImage(avatarUrls[index]), // Replace with AssetImage if needed
                backgroundColor: Colors.grey.shade200,
              ),
            );
          }),
          Positioned(
            left: avatarUrls.length * 40.0,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black45,
              child: Text(
                overlayText,
                style: AppTextStyles.mediumTextStyle.copyWith(color: Colors.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
}