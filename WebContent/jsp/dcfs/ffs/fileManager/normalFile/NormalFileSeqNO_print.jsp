<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head language="EN">
	<title>流水号打印</title>
	<BZ:webScript edit="true" tree="false"/>
	<script>
	//-----  下面是打印控制语句  ----------
	window.onbeforeprint=beforePrint;
	window.onafterprint=afterPrint;
	//打印之前隐藏不想打印出来的信息
	function beforePrint()
	{
		print1.style.display='none';
	}
	//打印之后将隐藏掉的信息再显示出来
	function afterPrint()
	{
		print1.style.display='';
	}
	//打印函数
	function _print()
	{
	    window.print();
	}
	</script>
</BZ:head>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS">
	<BZ:form name="srcForm" method="post">
	
	<BZ:for property="printShow">
		<div class="bz-edit clearfix" desc="编辑区域" style="height: 310px;">
			<div class="bz-edit-data-content clearfix" desc="内容体">
				<table class="bz-edit-data-table" border="0" style="width: 500px;height: 290px;" align="center">
					<tr>
						<td class="bz-edit-data-title" width="30%">Serial Number</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="AF_SEQ_NO" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Country</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="COUNTRY_EN" defaultValue="" onlyValue="true" />
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Agency (CN)</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="NAME_EN" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Adoptive father</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Adoptive mother</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
					<tr>
						<td class="bz-edit-data-title" width="30%">Document type</td>
						<td class="bz-edit-data-value" width="70%">
							<BZ:data field="FILE_TYPE" codeName="WJLX" isShowEN="true" defaultValue="" onlyValue="true"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</BZ:for>
	<br/>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区" id="print1">
			<input type="button" value="Print" class="btn btn-sm btn-primary" onclick="beforePrint();_print();afterPrint();"/>
		</div>
	</div>
	<!-- 按钮区 结束 -->
	</BZ:form>
</BZ:body>
</BZ:html>
