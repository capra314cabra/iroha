import "package:flutter/material.dart";
import "package:iroha/models/config.dart";
import "package:iroha/models/menu-items.dart";
import "package:iroha/widgets/foods-table.dart";

class IrohaOrderEditor extends StatefulWidget {
	final void Function(int tableNumber, Map<String, int> order) onOrderUpdated;

	IrohaOrderEditor({required this.onOrderUpdated, Key? key}) : super(key: key);

	@override
    _IrohaOrderEditorState createState() => _IrohaOrderEditorState();
}

class _IrohaOrderEditorState extends State<IrohaOrderEditor> {
	int _tableNumber = 1;
	final Map<String, int> _menuItemCounter = <String, int>{ };

    @override
    Widget build(BuildContext context) {
        return Column(
			mainAxisAlignment: MainAxisAlignment.start,
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[
				_buildTableDropDown(context),
				Container(
					margin: EdgeInsets.all(10),
					height: 2,
					color: Colors.blue
				),
				_buildFoodsTable(context),
				Container(
					margin: EdgeInsets.all(10),
					height: 2,
					color: Colors.blue
				)
			]
		);
    }

	@override
	void initState() {
		super.initState();

		final menuItems = MenuItems.get();

		for (var counter = 0; counter < menuItems.length; counter++) {
			_menuItemCounter[menuItems.elementAt(counter)] = 0;
		}

		widget.onOrderUpdated(_tableNumber, _menuItemCounter);
	}

	Widget _buildTableDropDown(BuildContext context) {
		return DropdownButton<int>(
			value: _tableNumber,
			items: [
				for (int i = 1; i <= IrohaConfig.tableCount; i++)
					DropdownMenuItem(
						child: Text(
							"$i番テーブル",
							style: TextStyle(fontSize: 25)
						),
						value: i,
					)
			],
			onChanged: (value) {
				setState(() {
					_tableNumber = value ?? 1;

					widget.onOrderUpdated(_tableNumber, _menuItemCounter);
				});
			}
		);
	}

	Widget _buildFoodsTable(BuildContext context) {
		return IrohaFoodsTable(
			data: MenuItems.get(),
			foodNameFromItem: (String item) {
				return item;
			},
			counterFromItem: (String item) {
				return DropdownButton<int>(
					value: _menuItemCounter[item],
					items: [
						for (int i = 0; i <= 5; i++)
							DropdownMenuItem(
								child: Text(
									i.toString(),
									style: TextStyle(fontSize: 25)
								),
								value: i,
							)
					],
					onChanged: (value) {
						setState(() {
							_menuItemCounter[item] = value ?? 0;

							widget.onOrderUpdated(_tableNumber, _menuItemCounter);
						});
					}
				);
			}
		);
	}
}
