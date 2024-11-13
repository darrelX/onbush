// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:gap/gap.dart';
// import 'package:intl/intl.dart';
// import 'package:onbush/history/data/models/ticket_model.dart';
// import 'package:onbush/history/logic/cubit/ticket_cubit.dart';
// import 'package:onbush/history/presentation/widgets/bottom_sheet_wiget.dart';
// import 'package:onbush/shared/extensions/context_extensions.dart';
// import 'package:onbush/shared/widget/app_bottom_sheet.dart';
// import '../../../shared/theme/app_colors.dart';

// class TicketWidget extends StatelessWidget {
//   const TicketWidget(
//       {super.key,
//       this.width,
//       required this.ticket,
//       this.status = false,
//       required this.total});

//   final double? width;
//   final TicketModel ticket;
//   final bool status;
//   final int total;

//   @override
//   Widget build(BuildContext context) {
//     final TicketCubit _cubit = TicketCubit();
//     return Stack(
//       children: [
//         InkWell(
//           onTap: () {
//             AppBottomSheet.showModelBottomSheet(
//                 context: context,
//                 backgroundColor: AppColors.primary,
//                 child: BottomSheetWiget(
//                   total: total,
//                   ticket: ticket,
//                   products: ticket.products!,
//                 ));
//             // showModalBottomSheet(
//             //   context: context,
//             //   backgroundColor: Colors.transparent,
//             //   builder: (context) {
//             //     return BottomSheetWiget(
//             //       total: total,
//             //       ticket: ticket,
//             //       products: ticket.products!,
//             //     );
//             //   },
//             // );
//           },
//           child: Container(
//             height: 90.h,
//             width: width ?? double.infinity,
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: context.theme.scaffoldBackgroundColor,
//               // color: Colors.blue,
//               borderRadius: BorderRadius.circular(15),
//               // border: Border.all(width: 0.04),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0x1A191C32),
//                   offset: Offset(3, 0),
//                   blurRadius: 2,
//                   spreadRadius: 0,
//                 ),
//                 BoxShadow(
//                   color: Color(0x1A191C32),
//                   offset: Offset(-5, 10),
//                   blurRadius: 2,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             padding: EdgeInsets.all(10.r),
//             child: Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: status ? null : AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Image.asset(
//                         status
//                             ? 'assets/images/ticket_confirmed.png'
//                             : 'assets/images/ticket.png',
//                         width: 28,
//                         height: 26,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Gap(14.w),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Ticket ${ticket.id!}',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: context.textTheme.bodyMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         DateFormat('dd.MM').format(ticket.createdAt!) +
//                             DateFormat('/hh.mm').format(ticket.createdAt!),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: context.textTheme.titleSmall!.copyWith(
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           // ticket..toStringAsFixed(2),
//                           ticket.totalAmount!.toStringAsFixed(1),
//                           style: context.textTheme.headlineMedium?.copyWith(
//                             color: AppColors.primary,
//                             fontSize: 24,
//                           ),
//                         ),
//                         const Gap(4),
//                         Text(
//                           "nkap",
//                           style: context.textTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           right: 20.r,
//           height: 50.r,
//           child: IconButton(
//             onPressed: () {
//               _cubit.deleteTicket(int.parse(ticket.id!));
//             },
//             icon: const Icon(Icons.delete),
//             color: AppColors.primary,
//           ),
//         ),
//       ],
//     );
//   }
// }
