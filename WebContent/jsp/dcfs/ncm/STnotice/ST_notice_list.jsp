<%
/**   
 * @Title: ST_notice_list.jsp
 * @Description: 省厅送养通知书列表
 * @author xugy
 * @date 2014-11-8下午5:10:32
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%

	 //1 获取排序字段、排序类型(ASC DESC)
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
	<BZ:head>
		<title>省厅送养通知书列表</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
		<script src="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.js"></script>
		<link rel="stylesheet" href="<BZ:resourcePath/>/jquery-autocomplete/jquery.autocomplete.css"/>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_findSyzzNameListForNew('N_COUNTRY_CODE','N_ADOPT_ORG_ID','N_PUB_ORGID');
			_scroll(1700,1700);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				moveOut : true,
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['1050px','250px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"notice/STNoticeList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("N_SIGN_NO").value = "";
			document.getElementById("N_SIGN_DATE_START").value = "";
			document.getElementById("N_SIGN_DATE_END").value = "";
			document.getElementById("N_NOTICE_DATE_START").value = "";
			document.getElementById("N_NOTICE_DATE_END").value = "";
			document.getElementById("N_COUNTRY_CODE").value = "";
			document.getElementById("N_ADOPT_ORG_ID").value = "";
			document.getElementById("N_MALE_NAME").value = "";
			document.getElementById("N_FEMALE_NAME").value = "";
			document.getElementById("N_CHILD_TYPE").value = "";
			document.getElementById("N_WELFARE_NAME_CN").value = "";
			document.getElementById("N_NAME").value = "";
			document.getElementById("N_SEX").value = "";
			document.getElementById("N_BIRTHDAY_START").value = "";
			document.getElementById("N_BIRTHDAY_END").value = "";
			document.getElementById("N_ADOPT_ORG_ID").value = "";
			
			_findSyzzNameListForNew('N_COUNTRY_CODE','N_ADOPT_ORG_ID','N_PUB_ORGID');
		}
		
		
		//
		function _print(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				//window.open(path+"appointment/toApplicationPrint.action?MI_ID="+ids);
				window.open(path+"match/AdoptionRegistrationApplication.action?MI_ID="+ids);
				
			}
		}
		
		
		//查看
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"notice/STNoticeAttDetail.action";
				document.srcForm.submit();
				
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="notice/STNoticeList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="ids" name="ids" value=""/>
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">通知书号</td>
								<td>
									<BZ:input prefix="N_" field="SIGN_NO" id="N_SIGN_NO" defaultValue=""  maxlength=""/>
								</td>
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select prefix="N_" field="COUNTRY_CODE" id="N_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('N_COUNTRY_CODE','N_ADOPT_ORG_ID','N_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="N_" field="ADOPT_ORG_ID" id="N_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('N_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="N_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">男收养人</td>
								<td>
									<BZ:input prefix="N_" field="MALE_NAME" id="N_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
								<td class="bz-search-title">女收养人</td>
								<td>
									<BZ:input prefix="N_" field="FEMALE_NAME" id="N_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								<td class="bz-search-title">福利院</td>
								<td>
									<BZ:input prefix="N_" field="WELFARE_NAME_CN" id="N_WELFARE_NAME_CN" defaultValue="" formTitle="福利院" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">儿童类型</td>
								<td>
									<BZ:select prefix="N_" field="CHILD_TYPE" id="N_CHILD_TYPE" formTitle="儿童类型" width="148px" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">正常</BZ:option>
										<BZ:option value="2">特需</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">姓名</td>
								<td>
									<BZ:input prefix="N_" field="NAME" id="N_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="N_" field="SEX" id="N_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="N_" field="BIRTHDAY_START" id="N_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'N_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="N_" field="BIRTHDAY_END" id="N_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'N_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td class="bz-search-title">签批日期</td>
								<td>
									<BZ:input prefix="N_" field="SIGN_DATE_START" id="N_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'N_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始签批日期" />~
									<BZ:input prefix="N_" field="SIGN_DATE_END" id="N_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'N_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止签批日期" />
								</td>
								<td class="bz-search-title">通知日期</td>
								<td>
									<BZ:input prefix="N_" field="NOTICE_DATE_START" id="N_NOTICE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'N_NOTICE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始通知日期" />~
									<BZ:input prefix="N_" field="NOTICE_DATE_END" id="N_NOTICE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'N_NOTICE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止通知日期" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="申请书打印" class="btn btn-sm btn-primary" onclick="_print()"/>
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive" style="overflow-x:scroll;">
				<div id="scrollDiv">
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
								<th style="width: 11%;">
									<div class="sorting" id="SIGN_NO">通知书号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CODE">国家</div>
								</th>
								<th style="width: 14%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="FEMALE_NAME">女收养人</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SIGN_DATE">签批日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NOTICE_DATE">通知日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="MI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="COUNTRY_CODE" codeName="GJSY" defaultValue="" /></td>
								<td><BZ:data field="NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="CHILD_TYPE" defaultValue="" checkValue="1=正常儿童;2=特需儿童;9=其他;"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" /></td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date" /></td>
								<td><BZ:data field="NOTICE_DATE" defaultValue="" type="date"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td>
								<BZ:page form="srcForm" property="List" exportXls="true" />
							</td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>