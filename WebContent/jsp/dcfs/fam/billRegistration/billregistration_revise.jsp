<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
/**   
 * @Title: billregistration_revise.jsp
 * @Description:  
 * @author panfeng   
 * @date 2014-11-19 下午20:19:38
 * @version V1.0   
 */
 	Data tdata =(Data)session.getAttribute("regData");
	System.out.println(tdata);
    /******Java代码功能区域Start******/
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
	/******Java代码功能区域End******/
	
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
</BZ:head>

<script>
	var seqNum = 0;
	$(document).ready(function() {
		dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	});
	
	//添加文件
	function _fileSelect() {
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
			var url = "fam/billRegistration/selectFileList.action?country_code="+country_code+"&adopt_org_id="+adopt_org_id+"&name_cn="+name_cn+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
			//编码处理
			url=encodeURI(url);
			url=encodeURI(url);
			window.open(path + url,"",",'height=800,width=1200,top=100,left=100,toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no'");
		}
	}
	
	function refreshLocalList(COUNTRY_CODE,ADOPT_ORG_ID,NAME_CN,PAID_WAY,PAR_VALUE,BILL_NO,REMARKS){
		var url = "fam/billRegistration/billRegistrationAdd.action?COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
		//编码处理
		url=encodeURI(url);
		url=encodeURI(url);
		window.location.href = path + url;
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
						var url = "fam/billRegistration/billRegistrationAdd.action?COUNTRY_CODE="+COUNTRY_CODE+"&ADOPT_ORG_ID="+ADOPT_ORG_ID+"&NAME_CN="+NAME_CN+"&PAID_WAY="+PAID_WAY+"&PAR_VALUE="+PAR_VALUE+"&BILL_NO="+BILL_NO+"&REMARKS="+REMARKS;
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
		$("#P_COST_TYPE").attr("disabled",false);
		//表单提交
		document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action";
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
			$("#P_COST_TYPE").attr("disabled",false);
			//表单提交
			document.getElementById("P_CHEQUE_TRANSFER_STATE").value = 1;
			document.srcForm.action = path + "fam/billRegistration/billRegistrationSave.action";
			document.srcForm.submit();
			
		}
	}
	
	//页面返回
	function _goback(){
		window.location.href=path+'fam/billRegistration/billRegistrationList.action';
	}
	//删除选择的文件信息
	function _deleteRow() {
		var num = 0;
		var arrays = document.getElementsByName("xuanze");
		for(var i=0; i<arrays.length; i++){
			if(arrays[i].checked){
				num += 1;
			}
		}
		var totalNum = (arrays.length-num)*800;
		$("#P_PAID_SHOULD_NUM").val(totalNum);//动态调整应缴费用
		$(':checkbox[name=xuanze]').each(function(){
			if($(this).attr('checked')){
				$(this).closest('tr').remove();
			}
		}); 
	}
	
	
	/**
	*票面金额是否大于等于应缴金额
	*@author： mayun
	*@date： 2014-7-17
	*@return:true 票面金额>=应缴金额; false:票面金额<应缴金额 
	*/
	function _checkBill(){
		var pmje=$("#P_PAR_VALUE").val();//票面金额
		var yjfy = $("#P_PAID_SHOULD_NUM").val();//应缴费用
		
		if(parseFloat(pmje)<parseFloat(yjfy)){
			alert("票面金额必须>=应缴金额,否则不予登记!");
			return false;
		}else{
			return true;
		}
	}
	
	
	/**
	*
	*根据国家列出所属收养组织
	*@ author :mayun
	*@ date:2014-7-24
	*/
	function _findSyzzNameList(){
		$("#P_NAME_CN").val("");//清空收养组织名称
		$("#P_ADOPT_ORG_ID").val("");//清空收养组织ID
		var countryCode = $("#P_COUNTRY_CODE").find("option:selected").val();//国家Code
		var language = $("#P_ADOPT_ORG_ID").attr("isShowEN");//是否显示英文
		if(null != countryCode&&""!=countryCode){
			$.ajax({
				url: path+'AjaxExecute?className=com.dcfs.ffs.common.FileCommonManagerAjax&method=findSyzzNameList&countryCode='+countryCode,
				type: 'POST',
				dataType: 'json',
				timeout: 1000,
				success: function(data){
			       var option ={
				      dataType: 'json',
					  width: 320,        //指定下拉框的宽度. Default: input元素的宽度
					  max: 100,            //下拉显示项目的个数.Default: 10
					  delay :1000,
					  highlight: false,
					  scroll: true,
					  minChars: 0,        //在触发autoComplete前用户至少需要输入的字符数.Default: 1，如果设为0，在输入框内双击或者删除输入框内内容时显示列表
					  autoFill: true,    //要不要在用户选择时自动将用户当前鼠标所在的值填入到input框. Default: false
					  mustMatch:false,    //如果设置为true,autoComplete只会允许匹配的结果出现在输入框,所有当用户输入的是非法字符时将会得不到下拉框.Default: false
				      matchContains: true,//决定比较时是否要在字符串内部查看匹配,如ba是否与foo bar中的ba匹配.使用缓存时比较重要.不要和autofill混用.Default: false
				      cacheLength:1,      //缓存的长度.即对从数据库中取到的结果集要缓存多少条记录.设成1为不缓存.Default: 10
				      matchSubset:false,   //autoComplete可不可以使用对服务器查询的缓存,如果缓存对foo的查询结果,那么如果用户输入foo就不需要再进行检索了,直接使用缓存.通常是打开这个选项以减轻服务器的负担以提高性能.只会在缓存长度大于1时有效.Default: true
				      matchCase:false,    // 比较是否开启大小写敏感开关.使用缓存时比较重要.如果你理解上一个选项,这个也就不难理解,就好比foot要不要到FOO的缓存中去找.Default: false   	  
			          multiple:false,     //是否允许输入多个值即多次使用autoComplete以输入多个值. Default: false
			          multipleSeparator:",",//如果是多选时,用来分开各个选择的字符. Default: ","
			          maxitemstoshow:-1,  //（默认值： -1 ） 限制的结果数量将显示在下拉。这是非常有用的如果您有大量的数据和不想为用户提供一份清单，列出可能包含数以百计的项目。要禁用此功能，将该值设置为-1 。
						
			          formatItem: function(row, i, max){//数据加载处理
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME;
			          	}
			               
			          },
			          formatMatch: function(row, i, max){//数据匹配处理
			          if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          },
			          formatResult: function(row){//数据结果处理
			          	if(language){
			          		return row.CODELETTER ;
			          	}else {
			          		return row.CODENAME ;
			          	}
			          }            
					}
					$("#P_NAME_CN").autocomplete(data,option);   
					$("#P_NAME_CN").setOptions(data).flushCache();//清除缓存
			        $("#P_NAME_CN").result(function(event, value, formatted){//选择后进行Code赋值操作
			        	$("#P_ADOPT_ORG_ID").val(value.CODEVALUE);
					}); 
				}
			  });
		}else{
			//alert("请选择国家!");
			return false;
		}
	}
	
</script>

<BZ:body codeNames="GJSY;WJLX;FYLB;JFFS;FWF" property="regData">

	<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- 隐藏区域begin -->
		<BZ:input prefix="P_" field="CHEQUE_ID" id="P_CHEQUE_ID" type="hidden" />
		<BZ:input prefix="P_" field="CHEQUE_TRANSFER_STATE" id="P_CHEQUE_TRANSFER_STATE" type="hidden" />
		<input type="hidden" id="P_PAGEACTION" name="P_PAGEACTION" value="update" />
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
								<BZ:select field="COUNTRY_CODE" notnull="请输入国家" formTitle="" prefix="P_" isCode="true" codeName="GJSY" width="70%" disabled="true" onchange="_findSyzzNameList()">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>收养组织</td>
							<td class="bz-edit-data-value" width="35%">
								<BZ:input prefix="P_" field="NAME_CN" id="P_NAME_CN" defaultValue="" className="inputOne" formTitle="收养组织" style="width:67%" maxlength="300" notnull="请输入收养组织"  disabled="true"/>
								<BZ:input type="hidden" field="ADOPT_ORG_ID"  prefix="P_" id="P_ADOPT_ORG_ID"/>
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
								<BZ:input field="BILL_NO" id="P_BILL_NO" prefix="P_" type="String"  formTitle="缴费票号" defaultValue="" style="width:67%"/>
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
				<!-- 按钮区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="按钮">
					<div style="text-align:right;">
						<input type="button" value="添加文件" class="btn btn-sm btn-primary" onclick="_fileSelect()"/>&nbsp;
						<input type="button" value="移除文件" class="btn btn-sm btn-primary" onclick="_delete();"/>&nbsp;&nbsp;
					</div>
				</div>
				<!-- 按钮区域 end -->
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
											<div class="sorting_disabled" id="FAMILY_TYPE">文件编号</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="MALE_NAME">登记日期</div></th>
										<th style="width: 20%; text-align: center;">
											<div class="sorting_disabled" id="MALE_BIRTHDAY">文件类型</div></th>
										<th style="width: 15%; text-align: center;">
											<div class="sorting_disabled" id="FEMALE_NAME">应缴金额</div></th>
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
