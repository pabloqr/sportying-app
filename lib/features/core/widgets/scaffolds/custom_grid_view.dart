import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomGridView extends BoxScrollView {
  const CustomGridView.expressive({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    required this.maxCrossAxisExtent,
    required this.childAspectRatio,
    this.mainAxisSpacing = 2.0,
    this.crossAxisSpacing = 2.0,
    required this.itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    this.itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    super.cacheExtent,
    int? semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.hitTestBehavior,
  }) : super(semanticChildCount: semanticChildCount ?? itemCount);

  final double maxCrossAxisExtent;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  final Widget Function(BuildContext context, int index, int crossAxisCount) itemBuilder;

  final int? itemCount;

  @override
  Widget buildChildLayout(BuildContext context) {
    // Usar [SliverLayoutBuilder] para obtener las constraints de las dimensiones del espacio disponible
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        // Obtener el ancho disponible para el grid
        final double crossAxisExtent = constraints.crossAxisExtent;

        // Calcular el número máximo de elementos por fila. Se usa la condición para evitar división de INF o entre 0
        int maxCrossAxisCount = crossAxisExtent.isFinite && maxCrossAxisExtent > 0
            ? math.max(1, ((crossAxisExtent + crossAxisSpacing) / (maxCrossAxisExtent + crossAxisSpacing)).ceil())
            : 1;

        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) => itemBuilder(ctx, index, maxCrossAxisCount),
            childCount: itemCount,
          ),
          // Como se ha calculado el número máximo de elementos por fila, se puede emplear el delegate que especifica
          // el número de elementos por fila
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: maxCrossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
        );
      },
    );
  }
}
