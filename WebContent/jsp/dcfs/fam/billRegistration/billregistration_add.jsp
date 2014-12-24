<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.DataList"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: billregistration_add.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-14 下午13:22:54
 * @version V1.0   
 */
   
    /******Java代码功能区域Start******/
    //获取数据对象列表
    DataList dataList = (DataList)session.getAttribute("fileList");
	Data tdata =(Data)request.getAttribute("regData");
	String CHEQUE_ID ="";
	if(tdata!=null){
		if(tdata.getString("CHEQUE_ID",null)!=null){
			CHEQUE_ID=tdata.getString("CHEQUE_ID","");
		}
	}else{
	   	tdata=new Data();
	   	session.setAttribute("regData", tdata);
	}
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	
	//获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>

<BZ:head language="CN">
	<title>票据登记</title>
	<up:uploadResource/>
	<BZ:webScript edit="true" list="true" />
	<up:uploadResource/>
	<script src="<BZ:resourcePath/>/jquery/jquery-1.7.1.min.js"></script>
	<script src="<BZ:resourcePath/>/jquery/jquery-ui.js"></script>
	<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery/jquery-ui.min.css"/>
	<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/dcfs/countryOrg.js"></script>
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
		_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID');
		
		//当文件列表有数据时，将国家、收养组织置灰
		<%
		if(dataList.size() != 0){
		%>
			$("#P_COUNTRY_CODE").attr("disabled",true);
			$("#P_ADOPT_ORG_ID").attr("disabled",true);
		<%
		}
		%>
		
	});
	
	//添加文件
	function _fileSelect() {
		var CHEQUE_ID = document.getElementById("P_CHEQUE_ID").value;
		var PAID_NO = document.getElementById("P_PAID_NO").value;
		var country_code = document.getElementById("P_COUNTRY_CODE").value;
		var adopt_org_id = document.getElementById("P_ADOPT_ORG_ID").value;
		var name_cn = document.getElementById("P_NAME_CN").value;
		var PAID_WAY = document.getElementById("P_PAID_WAY").value;
		var PAR_VALUE = document.getElementById("P_PAR_VALUE").value;
		var BILL_NO = document.getElementById("P_BILL_NO").value;
		var REMARKS = document.getElementById("P_REMARKS").value;
		if(country_code=="" || adopt_org_id=="null" || adopt_org_id==""){
			alert("请选择国家和收养组织！");
			return false;
		}else{
			var url = "fam/billRegistration/selectFileList.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&country_code="+country_code+"&adopt_org_id="+adopt_org_id+"&name_cn="+name_cn+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
			//编码处理
			url=encodeURI(url);
			url=encodeURI(url);
			window.open(path + url,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
	}
	
	function _timeout(){
		var count = 0,is_true = false;
	    setInterval(function(){
	        if(!count){
	        	is_true = start_project();
	        	count++;
	        }
	        if(is_true){
	            start_config();
	            is_true = false;
	        }
	    },1000);
	}
	function refreshLocalList(CHEQUE_ID,PAID_NO,COUNTRY_CODE,ADOPT_ORG_ID,NAME_CN,PAID_WAY,PAR_VALUE,BILL_NO,REMARKS){
		var url = "fam/billRegistration/billRegistrationAdd.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
		//编码处理
		url=encodeURI(url);
		url=encodeURI(url);
		window.location.href = path + url;
	}
	function _gray(){
		//当文件列表有数据时，将国家、收养组织置灰
		$("#P_COUNTRY_CODE").attr("disabled",true);
		$("#P_NAME_CN").attr("disabled",true);
	}
	
	//移除文件
	function _delete(){
	  	var num = 0;
		var chioceuuid = [];
		var arrays = document.getElementsByName("abc");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				chioceuuid[num++] = arrays[i].value.split("#")[0];
			}
		}
		if(num < 1){
			page.alert('请选择要移除的文件！');
			return;
		}else{
	  		var uuid = chioceuuid.join("#");
			var CHEQUE_ID = document.getElementById("P_CHEQUE_ID").value;
			var PAID_NO = document.getElementById("P_PAID_NO").value;
			var COUNTRY_CODE = document.getElementById("P_COUNTRY_CODE").value;
			var ADOPT_ORG_ID = document.getElementById("P_ADOPT_ORG_ID").value;
			var NAME_CN = document.getElementById("P_NAME_CN").value;
			var PAID_WAY = document.getElementById("P_PAID_WAY").value;
			var PAR_VALUE = document.getElementById("P_PAR_VALUE").value;
			var BILL_NO = document.getElementById("P_BILL_NO").value;
			var REMARKS = document.getElementById("P_REMARKS").value;
	  		if (confirm("确定移除这些文件？")){
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.fam.billRegistration.BillRegistrationAjax2',
					type: 'POST',
					data: {'uuid':uuid,'date':new Date().valueOf()},
					dataType: 'json',
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert("错误信息："+XMLHttpRequest+":"+textStatus+":"+errorThrown);
					},
					success: function(data){
						var url = "fam/billRegistration/billRegistrationAdd.action?CHEQUE_ID="+CHEQUE_ID+"&PAID_NO="+PAID_NO+"&COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
						//编码处理
						url=encodeURI(url);
						url=encodeURI(url);
						window.location.href = path + url;
					}
			  	});
			}
	  	}
	}
	
	//保存操作
	function _save() {
		//页面表单校验
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		
		//只读下拉列表重置为可编辑，目的为了后台获得此数据
		$("#P_COUNTRY_CODE").attr("disabled",false);
		$("#P_ADOPT_ORG_ID").attr("disabled",false);
		$("#P_COST_TYPE").attr("disabled",false);
		//表单提交
		document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 0;
		document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action?type=pjdjsave";
		document.srcForm.submit();
	}
	//提交操作
	function _submit(){
		if(confirm("确定提交吗？")){
			//页面表单校验
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}
			
			//只读下拉列表重置为可编辑，目的为了后台获得此数据
			$("#P_COUNTRY_CODE").attr("disabled",false);
			$("#P_ADOPT_ORG_ID").attr("disabled",false);
			$("#P_COST_TYPE").attr("disabled",false);
			//表单提交
			document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 1;
			document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action?type=pjdjsubmit";
			document.srcForm.submit();
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'fam/billRegistration/billRegistrationList.action';
	}
	
	
	
</script>

<BZ:body codeNames="GJSY;SYS_GJSY_CN;WJLX;FYLB;JFFS;FWF" property="regData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input prefix="P_" field="CHEQUE_ID" id="P_CHEQUE_ID" type="hidden" defaultValue=""/>
		<BZ:input prefix="P_" field="CHEQUE_TRANSFER_STATE" id="P_CHEQUE_TRANSFER_STATE" type="hidden" />
		<BZ:input prefix="P_" field="PAID_NO" id="P_PAID_NO" type="hidden" defaultValue=""/>
		<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="create" />
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!-- 隐藏区域end -->
		
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>票据登记基本信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:select field="COUNTRY_CODE" formTitle="" notnull="请输入国家"
									prefix="P_" isCode="true" codeName="SYS_GJSY_CN" width="70%"
									onchange="_findSyzzNameListForNew('P_COUNTRY_CODE','P_ADOPT_ORG_ID','P_HIDDEN_ADOPT_ORG_ID')">
									<option value="">
										--请选择--
									</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>收养组织</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:select prefix="P_" field="ADOPT_ORG_ID" id="P_ADOPT_ORG_ID" notnull="请输入收养组织" formTitle="" width="70%"
									onchange="_setOrgID('P_HIDDEN_ADOPT_ORG_ID',this.value)">
									<option value="">--请选择--</option>
								</BZ:select>
								<input type="hidden" id="P_HIDDEN_ADOPT_ORG_ID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'>
								<BZ:input type="hidden" field="NAME_CN"  prefix="P_" id="P_NAME_CN"/>
								<BZ:input type="hidden" field="NAME_EN"  prefix="P_" id="P_NAME_EN"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>费用类别</td>
							<td class="bz-edit-data-value">
								<BZ:select field="COST_TYPE" formTitle="" prefix="P_" isCode="true" codeName="FYLB" defaultValue="10" disabled="true" width="70%">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>缴费方式</td>
							<td class="bz-edit-data-value">
								<BZ:select field="PAID_WAY"  formTitle="" prefix="P_" isCode="true" codeName="JFFS" width="70%" notnull="请输入缴费方式">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>票面金额</td>
							<td class="bz-edit-data-value">
								<BZ:input field="PAR_VALUE" id="P_PAR_VALUE" prefix="P_" type="String" restriction="number"  formTitle="票面金额" defaultValue="" style="width:67%" notnull="请输入票面金额"/>
							</td>
							<td class="bz-edit-data-title">缴费票号</td>
							<td class="bz-edit-data-value">
								<BZ:input field="BILL_NO" prefix="P_" type="String" id="P_BILL_NO" formTitle="缴费票号" defaultValue="" style="width:67%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title poptitle">缴费备注</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:input field="REMARKS" id="P_REMARKS" type="textarea" prefix="P_" formTitle="缴费备注" maxlength="500" style="width:80%" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
				<div class="ui-state-default bz-edit-title" desc="按钮">
					<div style="text-align:right;">
						<input type="button" value="添加文件" class="btn btn-sm btn-primary" onclick="_fileSelect()"/>&nbsp;
						<input type="button" value="移除文件" class="btn btn-sm btn-primary" onclick="_delete();"/>&nbsp;&nbsp;
					</div>
				</div>
				<div class="bz-edit-data-content clearfix" desc="内容体">
				<div class="table-responsive">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td colSpan=7 style="padding: 0;">
								<table class="table  table-bordered dataTable" adsorb="both" init="true" id=info>
									<thead>
									<tr>
										<th class="center" style="width:5%;">
											<div class="sorting_disabled">
												<input name="abcd" type="checkbox" class="ace">
											</div>
										</th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled">序号</div></th>
										<th style="width: 30%; text-align: center;">
											<div class="sorting_disabled" id="FILE_NO">文件编号</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="REG_DATE">登记日期</div></th>
										<th style="width: 20%; text-align: center;">
											<div class="sorting_disabled" id="FILE_TYPE">文件类型</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="AF_COST">应缴金额</div></th>
									</tr>
									</thead>
									<tbody>
										<BZ:for property="fileList">
											<tr class="emptyData">
												<td class="center"><input name="abc" type="checkbox"
													value="<BZ:data field="AF_ID" onlyValue="true"/>" class="ace">
												</td>
												<td class="center">
													<BZ:i/>
												</td>
												<td class="center"><BZ:data field="FILE_NO" defaultValue="" onlyValue="true"/></td>
												<td class="center"><BZ:data field="REG_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
												<td><BZ:data field="FILE_TYPE" defaultValue="" codeName="WJLX" onlyValue="true"/></td>
												<td><BZ:data field="AF_COST" defaultValue="" onlyValue="true"/></td>
											</tr>
										</BZ:for>
									</tbody>
								</table>
								<!-- <table class="bz-edit-data-table" border="0">
									<tr>
										<td class="bz-edit-data-title" width="85%" style="text-align: center; border-top:none;">
											<font size="2px"><strong>合计</strong></font>
										</td>
										<td class="bz-edit-data-value" width="15%" style="border-top:none;">
										</td>
									</tr>
								</table> -->
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
		<br/>
		<!-- 按钮区域begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="按钮区">
				<input type="button" value="保&nbsp;&nbsp;存" class="btn btn-sm btn-primary" onclick="_save()"/>&nbsp;
				<input type="button" value="提&nbsp;&nbsp;交" class="btn btn-sm btn-primary" onclick="_submit()"/>&nbsp;
				<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback();"/>
			</div>
		</div>
		<!-- 按钮区域end -->
	</BZ:form>
</BZ:body>
</BZ:html>
