import 'package:flutter/material.dart';

/// Reusable card used on hub screens (Home, Lab) to present a GoRouter feature.
class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? badge;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _IconBadge(icon: icon, color: color),
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    _Label(text: badge!, color: color),
                  ],
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 13,
                    color: theme.colorScheme.outline,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon, color: color, size: 20),
  );
}

class _Label extends StatelessWidget {
  final String text;
  final Color color;
  const _Label({required this.text, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
