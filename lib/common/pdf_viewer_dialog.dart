import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/pdf_viewer_widget.dart';
import 'package:user/constant.dart';

Future viewPdfs(BuildContext context,
    {String? pdfUrl, String? title, void Function(int?, int?)? onPageChanged}) {
  int currentPage = 0, totalPage = 1;
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.7.sw,
                      child: Text(title ?? ''),
                     ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                width: 450,
                child: PdfViewerPage(
                  url: pdfUrl,
                  onPageChanged: (p0, p1) {
                    totalPage = p1!;
                    setState(() {
                      currentPage = p0!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${currentPage + 1} / $totalPage'),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    }),
  );
}
