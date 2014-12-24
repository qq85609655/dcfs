<%
/**   
 * @Title: DAB_PP_feedback_reminder_list.jsp
 * @Description: 档案部安置后报告反馈催交列表
 * @author xugy
 * @date 2014-10-23下午3:40:34
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
		<title>安置后报告反馈催交列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/scroll.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="/dcfs/resource/js/dcfs/countryOrg.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			_scroll(1900,1900);
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
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
				area: ['1050px','260px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"feedback/DABPPFeedbackReminderList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_ARCHIVE_NO").value = "";
			document.getElementById("S_FILE_NO").value = "";
			document.getElementById("S_SIGN_NO").value = "";
			document.getElementById("S_COUNTRY_CODE").value = "";
			document.getElementById("S_ADOPT_ORG_ID").value = "";
			document.getElementById("S_MALE_NAME").value = "";
			document.getElementById("S_FEMALE_NAME").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_NAME_CN").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_NUM").value = "";
			document.getElementById("S_SIGN_DATE_START").value = "";
			document.getElementById("S_SIGN_DATE_END").value = "";
			document.getElementById("S_ADREG_DATE_START").value = "";
			document.getElementById("S_ADREG_DATE_END").value = "";
			document.getElementById("S_LIMIT_DATE_START").value = "";
			document.getElementById("S_LIMIT_DATE_END").value = "";
			document.getElementById("S_REMINDERS_DATE_START").value = "";
			document.getElementById("S_REMINDERS_DATE_END").value = "";
			
			_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID');
		}
		//
		function _detail(){
			var num = 0;
			var ids="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					ids = document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			
			if(num != 1){
				page.alert('请选择一条数据 ');
				return;
			}else{
				document.getElementById("ids").value = ids;
				document.srcForm.action=path+"feedback/DABPPFeedbackReminderDetail.action";
				document.srcForm.submit();
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;GJSY;SYS_GJSY_CN;">
		<BZ:form name="srcForm" method="post" action="feedback/DABPPFeedbackReminderList.action">
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
								<td class="bz-search-title" style="width: 8%;">档案号</td>
								<td style="width: 18%;">
									<BZ:input prefix="S_" field="ARCHIVE_NO" id="S_ARCHIVE_NO" defaultValue="" formTitle="档案号" maxlength=""/>
								</td>
								
								<td class="bz-search-title" style="width: 9%;">收文编号</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="FILE_NO" id="S_FILE_NO" defaultValue="" formTitle="收文编号" maxlength="" />
								</td>
								
								<td class="bz-search-title" style="width: 9%;">签批号</td>
								<td style="width: 28%">
									<BZ:input prefix="S_" field="SIGN_NO" id="S_SIGN_NO" defaultValue="" formTitle="签批号" maxlength="" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">国家</td>
								<td>
									<BZ:select prefix="S_" field="COUNTRY_CODE" id="S_COUNTRY_CODE" defaultValue="" isCode="true" codeName="SYS_GJSY_CN" width="148px" formTitle="国家" onchange="_findSyzzNameListForNew('S_COUNTRY_CODE','S_ADOPT_ORG_ID','S_PUB_ORGID')">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">收养组织</td>
								<td>
									<BZ:select prefix="S_" field="ADOPT_ORG_ID" id="S_ADOPT_ORG_ID" formTitle="收养组织" width="148px" onchange="_setOrgID('S_PUB_ORGID',this.value)">
										<option value="">--请选择收养组织--</option>
									</BZ:select>
									<input type="hidden" id="S_PUB_ORGID" value='<BZ:dataValue field="ADOPT_ORG_ID" defaultValue="" onlyValue="true"/>'/>
								</td>
								<td class="bz-search-title">男方</td>
								<td>
									<BZ:input prefix="S_" field="MALE_NAME" id="S_MALE_NAME" defaultValue="" formTitle="男收养人" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">女方</td>
								<td>
									<BZ:input prefix="S_" field="FEMALE_NAME" id="S_FEMALE_NAME" defaultValue="" formTitle="女收养人" maxlength="" />
								</td>
								
								<td class="bz-search-title">省份</td>
								<td>
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">福利院</td>
								<td>
									<BZ:input prefix="S_" field="WELFARE_NAME_CN" id="S_WELFARE_NAME_CN" defaultValue="" formTitle="福利院" maxlength="" />
								</td>
							
							</tr>
							<tr>
								<td class="bz-search-title">儿童姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								
								<td class="bz-search-title">次第数</td>
								<td>
									<BZ:input prefix="S_" field="NUM" id="S_NUM" defaultValue="" formTitle="次第数" maxlength="" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">签批日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="SIGN_DATE_START" id="S_SIGN_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SIGN_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始签批日期" />~
									<BZ:input prefix="S_" field="SIGN_DATE_END" id="S_SIGN_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SIGN_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止签批日期" />
								</td>
								
								<td class="bz-search-title">登记日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="ADREG_DATE_START" id="S_ADREG_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_ADREG_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始登记日期" />~
									<BZ:input prefix="S_" field="ADREG_DATE_END" id="S_ADREG_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_ADREG_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止登记日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">递交期限</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="LIMIT_DATE_START" id="S_LIMIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_LIMIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始递交期限" />~
									<BZ:input prefix="S_" field="LIMIT_DATE_END" id="S_LIMIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_LIMIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止递交期限" />
								</td>
								
								<td class="bz-search-title">催交日期</td>
								<td colspan="2">
									<BZ:input prefix="S_" field="REMINDERS_DATE_START" id="S_REMINDERS_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_REMINDERS_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始催交日期" />~
									<BZ:input prefix="S_" field="REMINDERS_DATE_END" id="S_REMINDERS_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_REMINDERS_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止催交日期" />
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
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_detail()"/>&nbsp;
					<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportFile(document.srcForm,'xls')"/>
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
								<th style="width: 5%;">
									<div class="sorting" id="ARCHIVE_NO">档案号</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="FILE_NO">收文编号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="SIGN_NO">签批号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="COUNTRY_CN">国家</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="NAME_CN">收养组织</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="MALE_NAME">男方</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="FEMALE_NAME">女方</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 11%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">儿童姓名</div>
								</th>
								<th style="width: 3%;">
									<div class="sorting" id="NUM">次第数</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SIGN_DATE">签批日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="ADREG_DATE">登记日期</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="LIMIT_DATE">递交期限</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="REMINDERS_DATE">催交日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="FB_REC_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ARCHIVE_NO" defaultValue="" /></td>
								<td><BZ:data field="FILE_NO" defaultValue="" /></td>
								<td><BZ:data field="SIGN_NO" defaultValue="" /></td>
								<td><BZ:data field="COUNTRY_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" /></td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" /></td>
								<td><BZ:data field="NAME" defaultValue="" /></td>
								<td><BZ:data field="NUM" defaultValue="" /></td>
								<td><BZ:data field="SIGN_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="ADREG_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="LIMIT_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="REMINDERS_DATE" defaultValue="" type="date"/></td>
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
							<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="安置后反馈报告催交数据" exportCode="PROVINCE_ID=CODE,PROVINCE;SIGN_DATE=DATE;ADREG_DATE=DATE;LIMIT_DATE=DATE;REMINDERS_DATE=DATE,yyyy/MM/dd" exportField="ARCHIVE_NO=档案号,15,20;FILE_NO=收文编号,15;SIGN_NO=签批号,15;COUNTRY_CN=国家,15;NAME_CN=收养组织,15;MALE_NAME=男方,15;FEMALE_NAME=女方,15;PROVINCE_ID=省份,15;WELFARE_NAME_CN=福利院,15;NAME=儿童姓名,15;NUM=次第数,15;SIGN_DATE=签批日期,15;ADREG_DATE=登记日期,15;LIMIT_DATE=递交期限,15;REMINDERS_DATE=催交日期,15;"/></td>
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