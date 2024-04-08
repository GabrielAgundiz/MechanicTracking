import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Icons.edit,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(icon, size: 18,color: Colors.green,),
          ],
        ),
      ),
    );
  }
}
