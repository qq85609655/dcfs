<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbjh_et_chose_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-16
 * @version V1.0   
 */
String method=(String)request.getAttribute("method");//0:添加  1：修改
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
		<title>待发布儿童列表</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','210px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/publishPlan/toChoseETForJH.action";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_PUB_NUM").value = "";
			document.getElementById("S_PUB_FIRSTDATE_START").value = "";
			document.getElementById("S_PUB_FIRSTDATE_END").value = "";
			document.getElementById("S_PUB_LASTDATE_START").value = "";
			document.getElementById("S_PUB_LASTDATE_END").value = "";
		}
	
		//业务自定义功能操作JS
		
		//添加儿童
		function _chose(){
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
				var total_ciids = parent.document.getElementById("H_TOTAL_CIIDS").value;
				if(""==total_ciids||null==total_ciids||"null"==total_ciids){
					parent.document.getElementById("H_TOTAL_CIIDS").value=ci_id;
				}else {
					parent.document.getElementById("H_TOTAL_CIIDS").value=total_ciids+","+ci_id;
				}
				
				parent.document.getElementById("H_ADD_CIIDS").value=ci_id;
				parent.srcForm.action=path+"sce/publishPlan/addET.action";
				parent.srcForm.submit();
				_close();
			}
		
		}
		
		//添加儿童(修改页面)
		function _choseForRevise(){
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
				var total_ciids = parent.document.getElementById("H_TOTAL_CIIDS").value;
				if(""==total_ciids||null==total_ciids||"null"==total_ciids){
					parent.document.getElementById("H_TOTAL_CIIDS").value=ci_id;
				}else {
					parent.document.getElementById("H_TOTAL_CIIDS").value=total_ciids+","+ci_id;
				}
				
				parent.document.getElementById("H_ADD_CIIDS").value=ci_id;
				parent.srcForm.action=path+"sce/publishPlan/addETForRevise.action";
				parent.srcForm.submit();
				_close();
			}
		}
		
		
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}

	</script>
	<BZ:body property="data" codeNames="BCZL;DFLX;FBZT">
		<BZ:form name="srcForm" method="post" action="sce/publishPlan/toChoseETForJH.action?METHOD=<%=method %>">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<BZ:input type="hidden" field="DATA" id="H_DATA" defaultValue="" prefix="H_" />
		<BZ:input type="hidden" field="CIIDS" id="H_CIIDS" defaultValue="" prefix="H_" />
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 10%">省份</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" defaultValue="" formTitle="省份" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">福利院</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="WELFARE_ID" id="S_WELFARE_ID" defaultValue="" formTitle="福利院" maxlength="50"/>
								</td>
								
								<td class="bz-search-title" style="width: 10%">姓名</td>
								<td style="width: 18%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" />
								</td>
							</tr>
							<tr>	
								<td class="bz-search-title">性别</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="性别" defaultValue="" width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="1">男</BZ:option>
										<BZ:option value="2">女</BZ:option>
										<BZ:option value="3">两性</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">病残种类</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								<td class="bz-search-title">特别关注</td>
								<td>
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="特别关注" defaultValue=""  width="77%;">
										<BZ:option value="">--请选择--</BZ:option>
										<BZ:option value="0">否</BZ:option>
										<BZ:option value="1">是</BZ:option>
									</BZ:select>
								</td>
								
							</tr>
							<tr>
								
								<td class="bz-search-title">出生日期</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
								<td>
								</td>
								<td class="bz-search-title">发布次数</td>
								<td>
									<BZ:input prefix="S_" field="PUB_NUM" id="S_PUB_NUM" formTitle="发布次数" defaultValue=""/>
								</td>
							</tr>
							<tr>
								
								<td class="bz-search-title">首次发布日期</td>
								<td>
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_START" id="S_PUB_FIRSTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_END\\')}',readonly:true" defaultValue="" formTitle="首次发布日期" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="PUB_FIRSTDATE_END" id="S_PUB_FIRSTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_FIRSTDATE_START\\')}',readonly:true" defaultValue="" formTitle="首次发布日期" />
								</td>
							
								<td class="bz-search-title">末次发布日期</td>
								<td>
									<BZ:input prefix="S_" field="PUB_LASTDATE_START" id="S_PUB_LASTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_END\\')}',readonly:true" defaultValue="" formTitle="末次发布日期" />~
								</td>
								<td>
									<BZ:input prefix="S_" field="PUB_LASTDATE_END" id="S_PUB_LASTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_START\\')}',readonly:true" defaultValue="" formTitle="末次发布日期" />
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
					<%if("0".equals(method)||"0"==method){ %>
						<input type="button" value="选&nbsp;&nbsp;择" class="btn btn-sm btn-primary" onclick="_chose()"/>&nbsp;
					<%}else{ %>
						<input type="button" value="选&nbsp;&nbsp;择" class="btn btn-sm btn-primary" onclick="_choseForRevise()"/>&nbsp;
					<%} %>
					<input type="button" value="取&nbsp;&nbsp;消" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
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
								<th style="width: 2%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 4%;">
									<div class="sorting" id="PUB_NUM">发布次数</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_FIRSTDATE">首次发布日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_LASTDATE">末次发布日期</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="PROVINCE_ID" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SEX" defaultValue=""  onlyValue="true" checkValue="1=男;2=女;3=两性"/></td>
								<td><BZ:data field="BIRTHDAY" defaultValue=""  onlyValue="true" type="Date"/></td>
								<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" checkValue="0=否;1=是" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td><BZ:data field="PUB_NUM" defaultValue=""  onlyValue="true"/></td>
								<td><BZ:data field="PUB_FIRSTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="PUB_LASTDATE" defaultValue="" type="Date" onlyValue="true"/></td>
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
							<td><BZ:page form="srcForm" property="List"/></td>
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