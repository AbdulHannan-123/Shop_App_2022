import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_2022/providers/products.dart';
import 'package:shop_app_2022/providers/productss.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/editScreen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _pricefocusnode = FocusNode();
  final _discriptionfocusnode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedproduct = Product(
      id: null.toString(), description: '', title: '', imageUrl: '', price: 0);

  @override
  void initState() {
    _imageUrlfocusnode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlfocusnode.removeListener(_updateImageURL);
    _pricefocusnode.dispose();
    _discriptionfocusnode.dispose();
    _imageUrlController.dispose();
    _imageUrlfocusnode.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageUrlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProducts(_editedproduct);
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8 * 2.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_pricefocusnode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide Something...';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedproduct = Product(
                      title: newValue.toString(),
                      id: null.toString(),
                      price: _editedproduct.price,
                      imageUrl: _editedproduct.imageUrl,
                      description: _editedproduct.description);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _pricefocusnode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_discriptionfocusnode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter The Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter the valid numer';
                  }
                },
                onSaved: (newValue) {
                  _editedproduct = Product(
                      title: _editedproduct.title,
                      id: null.toString(),
                      price: double.parse(newValue!),
                      imageUrl: _editedproduct.imageUrl,
                      description: _editedproduct.description);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Discription',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _discriptionfocusnode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a discription';
                  }
                  if (value.length < 10) {
                    return 'Should be atleast 10 characters';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedproduct = Product(
                    title: _editedproduct.title,
                    id: null.toString(),
                    price: _editedproduct.price,
                    imageUrl: _editedproduct.imageUrl,
                    description: newValue.toString(),
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlfocusnode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onEditingComplete: () {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Image-URL';
                      }if (value.startsWith('http') || value.startsWith('https')) {
                        return 'Please enter a valid URL';
                      }if (value.endsWith('.png') || value.endsWith('.jpg') || value.endsWith('jpeg')) {
                        return 'Please enter a valid Image-URL';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedproduct = Product(
                          title: _editedproduct.title,
                          id: null.toString(),
                          price: _editedproduct.price,
                          imageUrl: newValue.toString(),
                          description: _editedproduct.description);
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
