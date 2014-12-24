<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_jh_add.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 Data data= (Data)request.getAttribute("data");
 String pub_type = data.getString("PUB_TYPE");//发布类型
 String pub_mode = data.getString("PUB_MODE");//点发类型
 String pub_orgid = data.getString("PUB_ORGID");//点发组织ID
 String country_code = data.getString("COUNTRY_CODE");//点发国家
 String adopt_org_name = data.getString("ADOPT_ORG_NAME");//点发组织名称
 String tmp_tmp_pub_orgid_name = data.getString("TMP_TMP_PUB_ORGID_NAME");//群发组织名称
 String pub_remarks = data.getString("PUB_REMARKS");//点发备注
%>
<BZ:html>
	<BZ:head>
		<title>制定计划详细页面</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			_dynamicFblx();
			_getAzqxForFb();
			dyniframesize(['mainFrame']);
		});
		
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		/**
		*
		*根据国家列出所属收养组织
		*@ author :mayun
		*@ date:2014-7-24
		*/
		function _findSyzzNameList(){
			$("#P_ADOPT_ORG_NAME").val("");//清空收养组织名称
			$("#P_PUB_ORGID").val("");//清空收养组织ID
			var countryCode = $("#P_COUNTRY_CODE").find("option:selected").val();//国家Code
			var language = $("#P_PUB_ORGID").attr("isShowEN");//是否显示英文
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
						$("#P_ADOPT_ORG_NAME").autocomplete(data,option);   
						$("#P_ADOPT_ORG_NAME").setOptions(data).flushCache();//清除缓存
				        $("#P_ADOPT_ORG_NAME").result(function(event, value, formatted){//选择后进行Code赋值操作
				        	$("#P_PUB_ORGID").val(value.CODEVALUE);
						}); 
					}
				  });
			}else{
				//alert("请选择国家!");
				return false;
			}
		}
		
		//儿童发布计划提交
		function _submit(){
			if(confirm("确定提交吗？")){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}
				//只读下拉列表重置为可编辑，目的为了后台获得此数据
				$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
				$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
				//表单提交
				var obj = document.forms["srcForm"];
				obj.action=path+'sce/publishPlan/saveFbInfo.action';
				obj.submit();
			}
		}
		
		//儿童发布计划保存
		function _save(){
			if(confirm("确定保存吗？")){
				//页面表单校验
				if (!runFormVerify(document.srcForm, false)) {
					return;
				}
				//只读下拉列表重置为可编辑，目的为了后台获得此数据
				$("#P_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#P_SETTLE_DATE_SPECIAL").attr("disabled",false);
				$("#M_SETTLE_DATE_NORMAL").attr("disabled",false);
				$("#M_SETTLE_DATE_SPECIAL").attr("disabled",false);
				//表单提交
				var obj = document.forms["srcForm"];
				obj.action=path+'sce/publishPlan/saveFbInfo.action';
				obj.submit();
			}
		}
		
		//根据点发、群发动态展现相关区域
		function _dynamicFblx(){
			$("#P_COUNTRY_CODE").val("");
			$("#P_ADOPT_ORG_NAME").val("");
			$("#P_PUB_ORGID").val("");
			$("#M_PUB_ORGID").val("");
			$("#PUB_ORGID").val("");
			$("#P_PUB_MODE").val("");
			$("#M_PUB_MODE").val("");
			$("#P_SETTLE_DATE_NORMAL").val("");
			$("#P_SETTLE_DATE_SPECIAL").val("");
			$("#M_SETTLE_DATE_NORMAL").val("");
			$("#M_SETTLE_DATE_SPECIAL").val("");
			$("#P_PUB_REMARKS").val("");
			
			//**************处理回显begin********************
			var hx_pub_type = $("#H_PUB_TYPE").val();
			var hx_pub_mode = $("#H_PUB_MODE").val();
			var hx_country_code = $("#H_COUNTRY_CODE").val();
			var hx_adopt_org_name = $("#H_ADOPT_ORG_NAME").val();
			var hx_tmp_tmp_pub_orgid_name = $("#H_TMP_TMP_PUB_ORGID_NAME").val();
			var hx_pub_remarks = $("#H_PUB_REMARKS").val();
			
			if(null==hx_adopt_org_name||"null"==hx_adopt_org_name){
				hx_adopt_org_name="";
			}
			
			if(null==hx_tmp_tmp_pub_orgid_name||"null"==hx_tmp_tmp_pub_orgid_name){
				hx_tmp_tmp_pub_orgid_name="";
			}
			
			if(null==hx_pub_remarks||"null"==hx_pub_remarks){
				hx_pub_remarks="";
			}
			$("#P_ADOPT_ORG_NAME").val(hx_adopt_org_name);
			$("#PUB_ORGID").val(hx_tmp_tmp_pub_orgid_name);
			$("#P_PUB_REMARKS").val(hx_pub_remarks);
			
			var count = $("#P_PUB_TYPE option").length;  
            for ( var i = 0; i < count; i++) {  
                if ($("#P_PUB_TYPE ").get(0).options[i].value == hx_pub_type) {  
                    $("#P_PUB_TYPE ").get(0).options[i].selected = true;  
                    break;  
                }  
            } 
            
            var count2 = $("#P_PUB_MODE option").length;  
            for ( var i = 0; i < count2; i++) {  
                if ($("#P_PUB_MODE ").get(0).options[i].value == hx_pub_mode) {  
                    $("#P_PUB_MODE ").get(0).options[i].selected = true;  
                    break;  
                }  
            }
            
            var count3 = $("#P_COUNTRY_CODE option").length;  
            for ( var i = 0; i < count3; i++) {  
                if ($("#P_COUNTRY_CODE ").get(0).options[i].value == hx_country_code) {  
                    $("#P_COUNTRY_CODE ").get(0).options[i].selected = true;  
                    break;  
                }  
            }
            
            $("#H_PUB_TYPE").val("");
			$("#H_PUB_MODE").val("");
			$("#H_COUNTRY_CODE").val("");
			$("#H_ADOPT_ORG_NAME").val("");
			$("#H_TMP_TMP_PUB_ORGID_NAME").val("")
			$("#H_PUB_REMARKS").val("")
			//**************处理回显end********************
			
			var optionValue = $("#P_PUB_TYPE").find("option:selected").val();
			if(optionValue=="1"){//点发
				$("#P_COUNTRY_CODE").attr("notnull","请输入国家");
				$("#P_ADOPT_ORG_NAME").attr("notnull","请输入发布组织");
				$("#P_PUB_MODE").attr("notnull","请输入点发类型");
				$("#PUB_ORGID").removeAttr("notnull");
				
				$("#dfzz").show();
				$("#dflx").show();
				$("#dfbz").show();
				$("#qfzz").hide();
				$("#qflx").hide();
			}else{//群发
				$("#PUB_ORGID").attr("notnull","请选择发布组织");
				$("#P_COUNTRY_CODE").removeAttr("notnull");
				$("#P_ADOPT_ORG_NAME").removeAttr("notnull");
				$("#P_PUB_MODE").removeAttr("notnull");
				
				$("#dfzz").hide();
				$("#dflx").hide();
				$("#dfbz").hide();
				$("#qfzz").show();
				$("#qflx").show();
			}
			
		}
	
		//获得安置期限
		function _getAzqxForFb(){
			var is_df = $("#P_PUB_TYPE").find("option:selected").val();//发布类型  1：点发  2：群发
			var pub_mode = $("#P_PUB_MODE").find("option:selected").val();//点发类型  
			
			if(""==pub_mode){
				pub_mode=null;
			}
			
			if("1"==is_df && (""==pub_mode||null==pub_mode)){
				return;
			}else{
				$.ajax({
					url: path+'AjaxExecute?className=com.dcfs.sce.publishManager.PublishManagerAjax&method=getAZQXInfo&IS_DF='+is_df+'&PUB_MODE='+pub_mode,
					type: 'POST',
					dataType: 'json',
					timeout: 1000,
					success: function(data){
						var two_type1 = data[0].TWO_TYPE;//是否特别关注  0:否  1：是
						var settle_months1 = data[0].SETTLE_MONTHS;
						var two_type2 = data[1].TWO_TYPE;//是否特别关注  0:否  1：是
						var settle_months2 = data[1].SETTLE_MONTHS;
						if("1"==is_df){//点发类型
							if("0"==two_type1){//非特别关注
								$("#P_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//特别关注
								$("#P_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#P_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}else {//群发类型
							if("0"==two_type1){//非特别关注
								$("#M_SETTLE_DATE_NORMAL").val(settle_months1);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months2);
							}else {//特别关注
								$("#M_SETTLE_DATE_NORMAL").val(settle_months2);
								$("#M_SETTLE_DATE_SPECIAL").val(settle_months1);
							}
						}
					}
				})
			}
		
		}
		
		
		//移除儿童
		function _removeET(){
			var num = 0;
			var ci_id ="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					if(num==0){
						ci_id=arrays[i].value;
					}else{
						ci_id += ","+arrays[i].value;
					}
					
					num++;
				}
				
			}
			if(num < 1){
				page.alert('请选择至少一条记录！');
				return;
			}else{
				document.getElementById("H_REMOVE_CIIDS").value=ci_id;
				document.srcForm.action=path+"sce/publishPlan/removeET.action";
				document.srcForm.submit();
			}
		
		}
		
		//选择待发布的儿童列表
		function _toChoseETForJH(){
			var TOTAL_CIIDS = $("#H_TOTAL_CIIDS").val();
			$.layer({
				type : 2,
				title : "选择待发布的儿童列表",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishPlan/toChoseETForJH.action?TOTAL_CIIDS='+TOTAL_CIIDS+'&METHOD=0'},
				area: ['1150px','990px'],
				offset: ['0px' , '0px']
			});
		}
		
		
		function _goback(){
			window.location.href=path+"sce/publishPlan/findListForFBJH.action";
		}
		
		//发布计划保存或提交  0：保存  1：提交
		function saveFBJHInfo(method){
			document.srcForm.action=path+"sce/publishPlan/saveFBJHInfo.action?method="+method;
			document.srcForm.submit();
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;SYZZ;" >
		<BZ:form name="srcForm" method="post">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<BZ:input type="hidden" field="PLAN_ID" prefix="H_"/>
		<BZ:input type="hidden" field="PUB_NUM" prefix="H_"/>
		<BZ:input type="hidden" field="TOTAL_CIIDS" prefix="H_" id="H_TOTAL_CIIDS"/><!-- 总儿童IDS -->
		<BZ:input type="hidden" field="ADD_CIIDS" prefix="H_" id="H_ADD_CIIDS"/><!-- 添加儿童IDS -->
		<BZ:input type="hidden" field="REMOVE_CIIDS" prefix="H_" id="H_REMOVE_CIIDS"/><!-- 移除儿童IDS -->
		<BZ:input type="hidden" field="PUB_TYPE" prefix="H_" id="H_PUB_TYPE" defaultValue="<%=pub_type %>"/><!-- 回显发布类型 -->
		<BZ:input type="hidden" field="PUB_MODE" prefix="H_" id="H_PUB_MODE" defaultValue="<%=pub_mode %>"/><!-- 回显点发类型 -->
		<BZ:input type="hidden" field="COUNTRY_CODE" prefix="H_" id="H_COUNTRY_CODE" defaultValue="<%=country_code %>"/><!-- 回显点发国家 -->
		<BZ:input type="hidden" field="ADOPT_ORG_NAME" prefix="H_" id="H_ADOPT_ORG_NAME" defaultValue="<%=adopt_org_name %>"/><!-- 回显点发组织名称 -->
		<BZ:input type="hidden" field="TMP_TMP_PUB_ORGID_NAME" prefix="H_" id="H_TMP_TMP_PUB_ORGID_NAME" defaultValue="<%=tmp_tmp_pub_orgid_name %>"/><!-- 回显群发组织名称 -->
		<BZ:input type="hidden" field="PUB_REMARKS" prefix="H_" id="H_PUB_REMARKS" defaultValue="<%=pub_remarks %>"/><!-- 回显点发备注 -->
		
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="添加儿童" class="btn btn-sm btn-primary" onclick="_toChoseETForJH()"/>&nbsp;
					<input type="button" value="移除儿童" class="btn btn-sm btn-primary" onclick="_removeET()"/>&nbsp;
					<input type="button" value="返&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>发布计划基本信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>预告日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="date" field="NOTE_DATE" prefix="J_"  formTitle="预告日期" notnull="请输入预告日期"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:input type="date" field="PUB_DATE" prefix="J_" formTitle="发布日期" notnull="请输入发布日期"/>
									</td>
									<td class="bz-edit-data-title" width="10%">制定人</td>
									<td class="bz-edit-data-value"   width="12%">
										<BZ:dataValue field="PLAN_USERNAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">制定日期</td>
									<td class="bz-edit-data-value"  width="12%">
										<BZ:dataValue field="PLAN_DATE" defaultValue="" onlyValue="true" type="Date"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">儿童总数</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">特别关注人数</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="PUB_NUM_TB" defaultValue=""  onlyValue="true" />
									</td>
									<td class="bz-edit-data-title" width="10%">非特别关注人数</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PUB_NUM_FTB" defaultValue="" onlyValue="true" />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- 编辑区域end -->
				<br/>
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>发布信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布类型</td>
									<td class="bz-edit-data-value">
										<BZ:select field="PUB_TYPE" id="P_PUB_TYPE" notnull="请输入发布类型" formTitle="" prefix="P_" onchange="_dynamicFblx();_getAzqxForFb()">
											<option value="1">点发</option>
											<option value="2">群发</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>发布组织</td>
									<td class="bz-edit-data-value" id="dfzz">
										<BZ:select field="COUNTRY_CODE" id="P_COUNTRY_CODE" notnull="请输入国家" formTitle="" prefix="P_" isCode="true" codeName="GJSY"  onchange="_findSyzzNameList()">
											<option value="">--请选择--</option>
										</BZ:select> —
										<BZ:input  prefix="P_" field="ADOPT_ORG_NAME" id="P_ADOPT_ORG_NAME" defaultValue="<%=adopt_org_name %>" className="inputOne" formTitle="发布组织" style="height:13px;width:50%" maxlength="300" notnull="请输入发布组织" />
										<BZ:input type="hidden" field="PUB_ORGID"  prefix="P_" id="P_PUB_ORGID"/>
									</td>
									<td class="bz-edit-data-value" id="qfzz" style="display:none">
										<BZ:input prefix="M_" field="PUB_ORGID"  type="helper" helperCode="SYS_ADOPT_ORG" helperTitle="选择发布组织" treeType="1" helperSync="true" showParent="false" defaultShowValue="" defaultValue="<%=pub_orgid %>" showFieldId="PUB_ORGID" notnull="请选择发布组织" style="height:13px;width:80%"  />
									</td>
								</tr>
								<tr id="dflx">
									<td class="bz-edit-data-title" width="10%"><font color="red">*</font>点发类型</td>
									<td class="bz-edit-data-value"  >
										<BZ:select field="PUB_MODE" id="P_PUB_MODE" notnull="请输入点发类型" formTitle="" prefix="P_" isCode="true" codeName="DFLX" onchange="_getAzqxForFb()">
											<option value="">--请选择--</option>
										</BZ:select>
									</td>
									<td class="bz-edit-data-title" width="10%">安置期限</td>
									<td class="bz-edit-data-value" >
										<BZ:input field="SETTLE_DATE_SPECIAL" id="P_SETTLE_DATE_SPECIAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
										<BZ:input field="SETTLE_DATE_NORMAL" id="P_SETTLE_DATE_NORMAL" prefix="P_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
									</td>
								</tr>
								<tr id="qflx" style="display:none">
									<td class="bz-edit-data-title" width="10%">安置期限</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="SETTLE_DATE_SPECIAL" id="M_SETTLE_DATE_SPECIAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（特别关注）
										<BZ:input field="SETTLE_DATE_NORMAL" id="M_SETTLE_DATE_NORMAL" prefix="M_" defaultValue="" readonly="true" style="height:13px;width:30px"/>个月（非特别关注）
									</td>
									
								</tr>
								<tr id="dfbz">
									<td class="bz-edit-data-title poptitle">点发备注</td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:input field="PUB_REMARKS" id="P_PUB_REMARKS" type="textarea" prefix="P_" formTitle="点发备注" defaultValue="" style="width:80%"  maxlength="900"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div> 
				<!-- 编辑区域end -->
				<br/>
				
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>已选择儿童列表</div>
						</div>
						<!-- 标题区域 end -->
						<!--查询结果列表区Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th class="center" style="width: 2%;">
											<div class="sorting_disabled">
												<input type="checkbox" class="ace">
											</div>
										</th>
										<th style="width: 3%;">
											<div class="sorting_disabled">序号</div>
										</th>
										<th style="width:5%;">
											<div class="sorting_disabled" id="PROVINCE_ID">省份</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="WELFARE_NAME_CN">福利院</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="NAME">姓名</div>
										</th>
										<th style="width: 3%;">
											<div class="sorting_disabled" id="SEX">性别</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="BIRTHDAY">出生日期</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="SN_TYPE">病残种类</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="SPECIAL_FOCUS">特别关注</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
									<BZ:for property="List">
										<tr class="emptyData">
											<td class="center">
												<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>,<BZ:data field="SPECIAL_FOCUS" onlyValue="true"/>" class="ace">
											</td>
											<td class="center">
												<BZ:i/>
											</td>
											<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
											<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""   onlyValue="true"/></td>
											<td><BZ:data field="NAME" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
											<td><BZ:data field="SEX" defaultValue="" checkValue="1=男;2=女;3=两性" length="20"/></td>
											<td><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
											<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
											<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是" onlyValue="true"/></td>
										</tr>
									</BZ:for>
								</tbody>
							</table>
						</div>
						<!--查询结果列表区End -->
					</div>
				</div>
			
				<!-- 按钮区 开始 -->
				<div class="bz-action-frame">
					<div class="bz-action-edit" desc="按钮区">
						<a href="reporter_files_list.html" >
							<input type="button" value="保存" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(0);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="提交" class="btn btn-sm btn-primary" onclick="saveFBJHInfo(1);"/>
						</a>
						<a href="reporter_files_list.html" >
							<input type="button" value="返回" class="btn btn-sm btn-primary" onclick="_goback()"/>
						</a>
					</div>
				</div>
				<!-- 按钮区 结束 -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>