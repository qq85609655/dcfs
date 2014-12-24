<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String type = (String) request.getAttribute("type");
	String title = (String) request.getAttribute("title");
	if(title==null||"".equals(title)){
		title="ѡ������";
	}
	String showParent = (String) request.getAttribute("showParent");
	String sync = (String) request.getAttribute("sync");
%>
<html>
<BZ:head>
	<title><%=title%></title>
	<BZ:script tree="true" />
	<script language="JavaScript">
		var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
		var isShowParent = false;
		if ("true" == isShowParentString) {
			isShowParent = true;
		}
		/******************************************/
		/**
		 * ˫���ڵ�ʱ�Ĳ���
		 * @param node ѡ�еĽڵ�
		 */
		function _nodedbClick(node) {
			//alert("˫����" + node.text);
			if (!tree.useCheckbox) {
				if (!node.hasChild) {
					_ok();
				}
			}
		}
		function _ok() {
			if (tree.useCheckbox) {
				var nodes = tree.nodes;
				var sel = false;
				var isSelect = false;
				for ( var i in nodes) {
					if (nodes[i].checked) {
						if (tree.onlyCheckChild) {

							if (!nodes[i].hasChild) {
								sel = true;
								break;
							} else {
								isSelect = true;
							}
						} else {
							sel = true;
							break;
						}
					}
				}
				if (tree.onlyCheckChild) {
					if (!sel && isSelect) {
						alert("��ֻ��ѡ��Ҷ�ӽڵ㣬��ѡ��Ľڵ��в�����Ҷ�ӽڵ㣬������ѡ��");
						return;
					}
				}
				if (!sel) {
					alert("��ѡ�����ݡ�");
					return;
				}
			} else {
				if (tree.onlyCheckChild) {
					var node = tree.selectedNode;
					if (node.hasChild) {
						alert("ֻ��ѡ��Ҷ�ӽڵ㣬������ѡ��");
						return;
					}
				}
				if (tree.selectedNode.id == null) {
					alert("��ѡ�����ݡ�");
					return;
				}
			}
			var reValue = null;
			if (tree.useCheckbox && !tree.onlySelectSelf) {
				reValue = getSelectValue(tree, isShowParent, true);
			} else {
				reValue = getSelectValue(tree, isShowParent, false);
			}
			window.returnValue = reValue;
			if (tree.useCheckbox) {
				//alert(reValue["name"] + "\n" + reValue["value"]);
			} else {
				for ( var m = 0; m < reValue; m++) {
					alert(reValue[m]["name"] + "\n" + reValue[m]["value"]);
				}

			}
			window.close();
		}
		function _clearData() {
			var reValue = new Array();
			if (tree.useCheckbox) {
				reValue[0] = {};
				reValue[0]["name"] = "";
				reValue[0]["value"] = "";
			} else {
				reValue["name"] = "";
				reValue["value"] = "";
			}
			window.returnValue = reValue;
			window.close();
		}
		function _closeMe() {
			window.close();
		}
		function _loadData() {
			var vs = window.dialogArguments;
			if (vs != null) {
     			loadTreeValues(tree, "tree", vs[0]);
			}
		}
		function L(id, selNode, node) {
			_getDataValue(tree, id);
		}
	</script>
	<style type="text/css">
.style1 {
	background-color: #F8FAFC;
	height: 35px;
	border: 1px #CCCCCC solid;
	padding-left: 10px;
}

.style2 {
	background-color: #EFEFEF;
	height: 28px;
	border-right: 1px #CCCCCC solid;
	border-left: 1px #CCCCCC solid;
	border-bottom: 1px #CCCCCC solid;
	padding-left: 10px;
	font-size: 12px;
	color: #41505A;
}

.style2 span {
	font-size: 12px;
	color: #41505A;
}

.style3 {
	font-size: 14px;
	color: #1F73B3;
	font-weight: bold;
	white-space: normal;
	padding: 3px;
	vertical-align: top;
}

.style6 {
	width: 50%;
	white-space: nowrap;
	text-align: right;
	padding-right: 10px;
	border-left: 1px #CCCCCC solid;
}

.style6a {
	width: 50%;
	white-space: nowrap;
	text-align: left;
	/*border-left:1px #CCCCCC solid;*/
}

.style4 {
	font-size: 12px;
	color: #41505A;
	padding: 3px 3px 3px 3px;
	height: 21px;
	width: 120px;
	border: 1px #CCCCCC solid;
}

.style5 {
	font-size: 12px;
	color: #000000;
	padding: 2px 3px 2px 3px;
	height: 18px;
	width: 310px;
	background-color: #FFF6C3;
	border: 1px #CCCCCC solid;
}

.style7 {
	padding: 2px 3px 2px 3px;
	height: 18px;
	white-space: nowrap;
	font-size: 14px;
	color: #1F73B3;
	font-weight: bold;
	white-space: normal;
	padding: 3px;
}

#disview {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 380px;
}

.tbutton {
	BORDER-RIGHT: #7b9ebd 1px solid;
	PADDING-RIGHT: 2px;
	BORDER-TOP: #7b9ebd 1px solid;
	PADDING-LEFT: 2px;
	FONT-SIZE: 12px;
	FILTER: progid:  DXImageTransform.Microsoft.Gradient(  GradientType=  0,
		StartColorStr=  #F8FAFC, EndColorStr=  #F8FAFC );
	BORDER-LEFT: #7b9ebd 1px solid;
	CURSOR: pointer;
	COLOR: black;
	PADDING-TOP: 2px;
	BORDER-BOTTOM: #7b9ebd 1px solid
}
</style>

</BZ:head>
<body style="margin: 0px" scroll=no onload="_loadData();">
	<table style="width: 100%;" cellspacing="0" cellpadding="0">
		<tr>
			<td class="style1">
				<table style="width: 100%">
					<tr>
						<td class="style7">������ <input type="text" class="style4"
							id="search" tabindex="1" id="search" onkeyup="_keySearch(tree);">
							<input type="button" value="����" class="tbutton"
							onclick="_search();"> <input id="p" type="button"
							value="��һ��" class="tbutton" style="display: none"
							onclick="_previous(tree);"> <input id="n" type="button"
							value="��һ��" class="tbutton" style="display: none"
							onclick="_next(tree);">
							<div id="searchPlay" class="style5" style="display: none"></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div style="height: 400px; width: 100%; overflow: auto" id="treeDiv">
					<BZ:tree type="<%=type%>" property="codeList" selectvalue="values"
						treeName="tree" sync="<%=sync %>"/>
				</div>
			</td>
		</tr>
		<tr>
			<td class="style1">
				<table style="width: 100%">
					<tr>
						<td class="style6a"><input type="button" value="ȫ��չ��"
							class="tbutton" onclick="expandAll(tree);">&nbsp;&nbsp; <input
							type="button" value="ȫ���۵�" class="tbutton"
							onclick="collapseAll(tree);"></td>
						<td class="style6"><input type="button" value="ȷ��"
							class="tbutton" onclick="_ok();">&nbsp;&nbsp; <input
							type="button" value="���" class="tbutton" onclick="_clearData();">&nbsp;&nbsp;
							<input type="button" value="ȡ��" class="tbutton"
							onclick="_closeMe();"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="style2">ѡ���<span id="disView" title=""></span>
			</td>
		</tr>
	</table>

</body>
</html>


