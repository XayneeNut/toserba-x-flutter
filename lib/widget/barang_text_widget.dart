import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toserba/models/barang_models.dart';
import 'package:toserba/providers/favorites_barang_providers.dart';
import 'package:toserba/widget/size_config.dart';
import 'package:intl/intl.dart';

class BarangTextWidget extends ConsumerWidget {
  const BarangTextWidget(
      {super.key,
      required this.index,
      required this.barangModels,
      required this.barangModel});

  final int index;
  final List<BarangModels> barangModels;
  final BarangModels barangModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat.simpleCurrency(locale: 'id_ID');
    final style = GoogleFonts.ubuntu(
      decoration: TextDecoration.none,
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 0,
    );
    var marginTitleSubtitle =
        EdgeInsets.only(left: SizeConfig.blockSizeVertical! * 3);
    final favoritesBarangProvider = ref.watch(favoritesBarangProviders);
    final isFavorites = favoritesBarangProvider.contains(barangModel);
    SizeConfig().init(context);
    return ListTile(
      title: Container(
        margin: marginTitleSubtitle,
        child: Text(
          barangModels[index].namaBarang,
          style: style,
        ),
      ),
      subtitle: Container(
        margin: marginTitleSubtitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 1),
            Text(
              formatter.format(barangModels[index].hargaBarang),
              style: style.copyWith(fontSize: 15),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal! * 1,
            ),
            Text(
              'Stok : ${barangModels[index].stokBarang}',
              style: style.copyWith(fontSize: 17),
            )
          ],
        ),
      ),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: FileImage(barangModels[index].imageBarang),
      ),
      trailing: IconButton(
        onPressed: () {
          final wasAdded = ref
              .read(favoritesBarangProviders.notifier)
              .toogleBarangFavorites(barangModel);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                wasAdded
                    ? "berhasil menambahkan ke favorites"
                    : "berhasil dihapus dari favorites",
                style: style,
              ),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical! * 10,
                  horizontal: SizeConfig.blockSizeVertical! * 10),
            ),
          );
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
              child: child,
            );
          },
          child: Icon(
            isFavorites ? Icons.star : Icons.star_border,
            key: ValueKey(isFavorites),
          ),
        ),
      ),
    );
  }
}
