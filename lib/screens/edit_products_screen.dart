import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products.dart';

class EditUserProductScreen extends StatefulWidget {
  static const namedRout = '/edit-product';
  @override
  _EditUserProductScreenState createState() => _EditUserProductScreenState();
}

class _EditUserProductScreenState extends State<EditUserProductScreen> {
  final _priceFocusedNode = FocusNode();
  final _descriptionFocusedNode = FocusNode();
  final _imageUrlTextController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _emptyProduct = Product(
    id: null,
    title: '',
    price: 0,
    imageUrl: '',
    description: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _emptyProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _emptyProduct.title,
          'description': _emptyProduct.description,
          'price': _emptyProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlTextController.text = _emptyProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusedNode.dispose();
    _descriptionFocusedNode.dispose();
    _imageUrlTextController.dispose();
    super.dispose();
  }

  void _submmitedForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    if (_emptyProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_emptyProduct.id, _emptyProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_emptyProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _submmitedForm();
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title Of Your Product'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusedNode);
                },
                onSaved: (value) {
                  _emptyProduct = Product(
                      title: value,
                      id: _emptyProduct.id,
                      description: _emptyProduct.description,
                      price: _emptyProduct.price,
                      imageUrl: _emptyProduct.imageUrl);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'pleas enter title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price Of Your Product'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusedNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusedNode);
                },
                onSaved: (value) {
                  _emptyProduct = Product(
                      title: _emptyProduct.title,
                      id: _emptyProduct.id,
                      description: _emptyProduct.description,
                      price: double.parse(value),
                      imageUrl: _emptyProduct.imageUrl);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'pleas enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a number';
                  }
                  if (double.tryParse(value) <= 0) {
                    return 'Please enter a number grater than zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration:
                    InputDecoration(labelText: 'Description Of Your Product'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusedNode,
                onSaved: (value) {
                  _emptyProduct = Product(
                      title: _emptyProduct.title,
                      id: _emptyProduct.id,
                      description: value,
                      price: _emptyProduct.price,
                      imageUrl: _emptyProduct.imageUrl);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'pleas enter Description';
                  }
                  if (value.length <= 10) {
                    return 'the description mudt be at least 10 charecter';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 10, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.grey),
                    ),
                    child: _imageUrlTextController.text.isEmpty
                        ? Text('image is empty')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlTextController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Image Of Your Product'),
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlTextController,
                      onFieldSubmitted: (_) {
                        _submmitedForm();
                      },
                      onSaved: (value) {
                        _emptyProduct = Product(
                          title: _emptyProduct.title,
                          description: _emptyProduct.description,
                          price: _emptyProduct.price,
                          imageUrl: value,
                          id: _emptyProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'pleas url of your image ';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
