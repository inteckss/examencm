import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final String? productName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  final bool forceOfflineMode; // Nueva opción para forzar placeholders

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.productName,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.forceOfflineMode = true, // Por defecto en modo offline
  });

  IconData _getProductIcon(String? productName) {
    if (productName == null) return Icons.inventory;
    
    final name = productName.toLowerCase();
    
    // Consolas
    if (name.contains('playstation') || name.contains('ps')) {
      return Icons.sports_esports;
    } else if (name.contains('xbox')) {
      return Icons.videogame_asset;
    } else if (name.contains('nintendo') || name.contains('switch')) {
      return Icons.gamepad;
    }
    // Controladores
    else if (name.contains('controller') || name.contains('dualsense') || 
             name.contains('dualshock') || name.contains('joy-con')) {
      return Icons.gamepad;
    }
    // Accesorios
    else if (name.contains('headset') || name.contains('audio')) {
      return Icons.headphones;
    } else if (name.contains('keyboard') || name.contains('teclado')) {
      return Icons.keyboard;
    } else if (name.contains('mouse')) {
      return Icons.mouse;
    }
    
    return Icons.inventory;
  }

  Color _getProductColor(String? productName) {
    if (productName == null) return const Color(0xFF6C63FF);
    
    final name = productName.toLowerCase();
    
    if (name.contains('playstation') || name.contains('ps')) {
      return const Color(0xFF0070F3); // Azul PlayStation
    } else if (name.contains('xbox')) {
      return const Color(0xFF107C10); // Verde Xbox
    } else if (name.contains('nintendo') || name.contains('switch')) {
      return const Color(0xFFE60012); // Rojo Nintendo
    } else if (name.contains('headset') || name.contains('audio')) {
      return const Color(0xFFFF6B6B); // Rojo para audio
    } else if (name.contains('keyboard')) {
      return const Color(0xFF4ECDC4); // Verde azulado para teclado
    }
    
    return const Color(0xFF6C63FF);
  }

  Widget _buildPlaceholder(bool isLarge) {
    final icon = _getProductIcon(productName);
    final color = _getProductColor(productName);
    final size = isLarge ? 64.0 : 32.0;
    
    return Container(
      color: const Color(0xFF1A1A2E),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isLarge ? 12 : 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: size,
              color: color,
            ),
          ),
          if (isLarge && productName != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                productName!.length > 20 
                    ? '${productName!.substring(0, 20)}...'
                    : productName!,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLarge = height != null && height! > 100;
    
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: const Color(0xFF1A1A2E),
        border: Border.all(
          color: _getProductColor(productName).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: forceOfflineMode 
            ? _buildPlaceholder(isLarge)
            : (imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: fit,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF1A1A2E),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  strokeWidth: 2,
                                  color: _getProductColor(productName),
                                ),
                              ),
                              if (isLarge) ...[
                                const SizedBox(height: 8),
                                const Text(
                                  'Cargando...',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $imageUrl - $error');
                      return _buildPlaceholder(isLarge);
                    },
                  )
                : _buildPlaceholder(isLarge)),
      ),
    );
  }
}