<%
/**   
 * @Title: normalMatchCI_list.jsp
 * @Description: 选择儿童匹配列表
 * @author xugy
 * @date 2014-9-4下午2:40:35
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String AFid=(String)request.getAttribute("AFid");//收养人文件的ID
	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head>
		<title>选择儿童匹配列表</title>
		<BZ:webScript list="true" isAjax="true" edit="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//dyniframesize(['mainFrame']);
			var str = document.getElementById("S_PROVINCE_ID");
			selectWelfare(str);
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
				area: ['1050px','150px'],
				offset: ['110px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"mormalMatch/normalMatchCIList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
		}
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=data.getString("WELFARE_ID") %>';
			
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择--",""));
			}
		}
		//关闭弹出页
		function _close(){
			//var index = parent.layer.getFrameIndex(window.name);
			//parent.layer.close(index);
			
			window.close();
		}
		//查看儿童信息
		function _viewEtcl(CHILD_NOs){
			$.layer({
				type : 2,
				title : "儿童材料查看",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				//page : {dom : '#planList'},
				iframe: {src: '<BZ:url/>/mormalMatch/showCIs.action?CHILD_NOs='+CHILD_NOs},
				area: ['1050px','540px'],
				offset: ['0px' , '10px']
			});
		}
		//匹配
		function _match(){
			var num = 0;
			var CIid="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CIid=document.getElementsByName('xuanze')[i].value;
					num += 1;
				}
			}
			if(num != 1){
				page.alert('请选择一条数据匹配 ');
				return;
			}else{
				//if (confirm('确定匹配该儿童?')) {
				var AFid = document.getElementById("AFid").value;
				document.srcForm.action=path+"mormalMatch/matchPreview.action?CIid="+CIid+"&AFid="+AFid;
				document.srcForm.submit();
				//}
			}
		}
	</script>
	<BZ:body property="data" codeNames="PROVINCE;ETXB;">
		<BZ:form name="srcForm" method="post" action="mormalMatch/normalMatchCIList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" id="deleteuuid" name="deleteuuid" value=""/>
		<input type="hidden" id="subuuid" name="subuuid" value=""/>
		<input type="hidden" id="printuuid" name="printuuid" value=""/>
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<input type="hidden" id="AFid" name="AFid" value="<%=AFid%>"/>
		<!-- 收养人信息Start -->
		<table class="bz-edit-data-table" border="0">
			<tr>
				<td class="bz-edit-data-title">国家</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="COUNTRY_CN" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">收养组织</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="NAME_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title" width="15%">男收养人</td>
				<td class="bz-edit-data-value" width="35%">
					<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title" width="15%">年龄</td>
				<td class="bz-edit-data-value" width="35%">
					<BZ:dataValue field="MALE_AGE" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">女收养人</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">年龄</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="FEMALE_AGE" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">批准书日期</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="GOVERN_DATE" defaultValue="" onlyValue="true" type="date"/>
				</td>
				<td class="bz-edit-data-title">到期日期</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="EXPIRE_DATE" defaultValue="" onlyValue="true" type="date"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">收养要求</td>
				<td class="bz-edit-data-value" colspan="3">
					<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
				</td>
			</tr>
			<tr>
				<td class="bz-edit-data-title">子女数量</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>
				</td>
				<td class="bz-edit-data-title">匹配次数</td>
				<td class="bz-edit-data-value">
					<BZ:dataValue field="MATCH_NUM" defaultValue="0" onlyValue="true"/>
				</td>
			</tr>
		</table>
		<!-- 收养人信息End -->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 8%;">省份</td>
								<td style="width: 24%;">
									<BZ:select prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" isCode="true" codeName="PROVINCE" width="148px" onchange="selectWelfare(this)" formTitle="省份" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 8%;">福利院</td>
								<td style="width: 24%">
									<BZ:select prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" width="148px;" formTitle="福利院">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title" style="width: 8%;">体检日期</td>
								<td style="width: 28%;">
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始体检日期" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止体检日期" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">姓名</td>
								<td>
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="" />
								</td>
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" width="148px" formTitle="性别" defaultValue="">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
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
					<input type="button" value="匹&nbsp;&nbsp;配" class="btn btn-sm btn-primary" onclick="_match()"/>&nbsp;
					<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
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
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 25%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 19%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="CHECKUP_DATE">体检日期</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="CIdl" fordata="CIdata">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue=""/></td>
								<td>
									<%
									String IS_TWINS = ((Data) pageContext.getAttribute("CIdata")).getString("IS_TWINS");
									if("1".equals(IS_TWINS)){
									%>
									<a href="javascript:void(0);" onclick="_viewEtcl('<BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/>,<BZ:data field="TWINS_IDS" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="NAME" defaultValue=""/>
										（同胞）
									</a>
									<%
									}else{
									%>
									<a href="javascript:void(0);" onclick="_viewEtcl('<BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/>')">
										<BZ:data field="NAME" defaultValue=""/>
									</a>
									<%} %>
								</td>
								<td><BZ:data field="SEX" defaultValue="" codeName="ETXB"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHECKUP_DATE" defaultValue="" type="date"/></td>
								<td><BZ:data field="CHILD_TYPE" defaultValue="" checkValue="1=正常儿童;2=特需儿童;"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="CIdl"/></td>
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