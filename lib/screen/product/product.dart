import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shoe/screen/product/DetailsProduct.dart';
import 'package:shoe/screen/product/cubit/product_cubit.dart';
import 'package:shoe/screen/product/model/Productmodel.dart';

import '../diohelper/urlapi.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

@override
  void initState() {
  context.read<ProductCubit>().getproduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: height * 0.02,
          ),
          CircleAvatar(
            backgroundColor: Color(0xffF4F4F4),
            radius: 25,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);

              },
              icon: Icon(
                Icons.chevron_left,
                size: 30,
              ),
              color: Colors.black,
            ),
          ),

          SizedBox(
            height: height * 0.02,
          ),
          Text(
            '${Datasend.namecategory} ',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {


              if (state is ProductLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 84, 176),
                ));
              } else if (state is ProductSuccess) {
                List<ProductData>? dproduct = [];
                dproduct = context.read<ProductCubit>().productmodel.data?.data;
                print(ApiUrl.product);
                print(Datasend.idcategory);
                return Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: width * 0.7,
                          mainAxisExtent: height * 0.47,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemCount: dproduct?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xffF4F4F4),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: '${dproduct?[index].image}',
                                        fit: BoxFit.fill,
                                        width: width * 0.4,
                                        height: height * 0.4,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          color: Color.fromARGB(255, 74, 84, 176),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    '${dproduct?[index].name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: ' EGP ',
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 12),
                                          children: [
                                        TextSpan(
                                          text: '${dproduct?[index].price}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ])),

                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Datasend.idproduct=index;
                            Datasend.idddproduct=dproduct?[index].id as int;

                            Get.to(DetailsProduct());
                          },
                        );
                      }),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ]),
      ),
    );
  }
}
