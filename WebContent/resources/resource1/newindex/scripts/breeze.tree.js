// Breeze对zTree的扩展
var bzTree = {
	"defaultSplitChar" : "-",
	/**
	 * 得到树的节点以及父节点的全部名称
	 */
	getTreeNames : function(treeNode, splitChar) {
		if (splitChar == null) {
			splitChar = this.defaultSplitChar;
		}
		if (treeNode != null) {
			var parentNode = treeNode.getParentNode();
			if (parentNode == null) {
				return treeNode.name;
			} else {
				return this.getTreeNames(parentNode, splitChar, "") + splitChar + treeNode.name;
			}
		} else {
			return "";
		}
	},
	/**
	 * 将树的节点位置在首页面的导航中添加
	 */
	addTreePositionValue : function(treeNode) {
		if (treeNode != null) {
			var parentNode = treeNode.getParentNode();
			if (parentNode != null) {
				this.addTreePositionValue(parentNode);
			}
			page.addPosition(treeNode.name, treeNode.url, treeNode.target);
		}
	},
	/**
	 * 设置数据状态
	 *
	 * @param checkbox
	 *            是否为多选
	 * @param onClick
	 *            单击执行的方法
	 * @param onCheck
	 *            checkbox点击执行的方法
	 * @param onDblClick
	 *            双击执行的方法
	 * @param onRightClick
	 *            右击执行的方法
	 * @return 返回
	 */
	setDataType : function(checkbox, onClick, onCheck, onDblClick, onRightClick) {
		if (checkbox != null && checkbox != false) {
			dataType.check = {
				enable : true
			};
		}
		if (onClick != null && onClick != "") {
			dataType.callback.onClick = eval(onClick);
		} else {
			dataType.callback.onClick = function(event, treeId, treeNode) {
				bzTree.setSelectNode(treeId, treeNode);
			};
		}
		if (onCheck != null && onCheck != "") {
			dataType.callback.onCheck = eval(onCheck);
		}
		if (onDblClick != null && onDblClick != "") {
			dataType.callback.onDblClick = eval(onDblClick);
		}
		if (onRightClick != null && onRightClick != "") {
			dataType.callback.onRightClick = eval(onRightClick);
		}
		return dataType;
	},
	/**
	 * 得到指定树的选择值
	 *
	 * @param treeId
	 *            树ID
	 * @return 返回选择的节点node对象集合
	 */
	getSelectNodes : function(treeId) {
		if (treeId == null) {
			treeId = "tree";
		}
		var treeObj = $.fn.zTree.getZTreeObj(treeId);
		var nodes = treeObj.getCheckedNodes(true);
		return nodes;
	},
	/**
	 * 单选的值
	 */
	"selectNode" : [],
	getSelectNode : function(treeId) {
		if (treeId == null) {
			treeId = "tree";
		}
		return this.selectNode[treeId];
	},
	setSelectNode : function(treeId, treeNode) {
		this.selectNode[treeId] = treeNode;
	}
};
var dataType = {
	data : {
		simpleData : {
			enable : true
		}
	},
	callback : {}
};