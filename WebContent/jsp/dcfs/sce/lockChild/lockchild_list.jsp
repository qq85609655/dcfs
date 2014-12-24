<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: lockchild_list.jsp
 * @Description: 查看与锁定儿童列表
 * @author yangrt   
 * @date 2014-9-21
 * @version V1.0  
 */
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
	<BZ:head language="EN">
		<title>预批申请列表</title>
		<BZ:webScript list="true" isAjax="true" tree="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件(Query condition)",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['950px','240px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"sce/lockchild/LockChildList.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_SPECIAL_FOCUS").value = "";
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("PROVINCE_ID_showid").value = "";
			document.getElementById("S_PUB_LASTDATE_START").value = "";
			document.getElementById("S_PUB_LASTDATE_END").value = "";
			document.getElementById("S_NAME_PINYIN").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("R_DISEASE_EN").value = "";
			document.getElementById("S_SETTLE_DATE_START").value = "";
			document.getElementById("S_SETTLE_DATE_END").value = "";
			document.getElementById("S_PUB_TYPE").value = "";
			document.getElementById("S_HAVE_VIDEO").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_START").value = "";
			document.getElementById("S_LAST_UPDATE_DATE_END").value = "";
		}
		
		//儿童信息查看
		function _showChild(ci_id,pub_id){
			document.srcForm.action =  path+"sce/lockchild/ChildInfoShow.action?CI_ID=" + ci_id + "&PUB_ID=" + pub_id;
			document.srcForm.submit();
		}
		
		function _lockChild(){
			var num = 0;
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					$("#R_CI_ID").val(arrays[i].value);
					$("#R_PUB_ID").val(arrays[i].getAttribute("PUB_ID"));
					//判断该组织在15天之内有过锁定该儿童的记录
					var flag = getStr('com.dcfs.sce.lockChild.LockRecordsAjax','CI_ID=' + arrays[i].value);
					if(flag == "true"){
						//如果有，则该组织不能锁定该儿童
						alert("Your agency has locked this child within 7 days, and you are not allowed to lock this child again for the moment!");
						return;
					}else{
						num += 1;
					}
					
				}
			}
			if(num != "1"){
				alert('Please select one data!');
				return;
			}else{
				document.srcForm.action=path+"sce/lockchild/LockTypeSelect.action";
				document.srcForm.submit();
			}
		}
		
		//委托退回
		function _consignReturn(){
			var num = 0;
			var pub_id = [];
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					var type = arrays[i].getAttribute("PUB_TYPE");		//发布类型
					if(type == "1"){
						pub_id[num++] = arrays[i].getAttribute("PUB_ID");
					}else{
						alert("please select one child file with post type as 'posted on the agency Agency-specific list'!");
						return;
					}
				}
			}
			if(num == "0"){
				alert('Please select one data!');
				return;
			}else{
				var url = path + "sce/lockchild/ConsignReturn.action?PUB_ID="+pub_id.join(";");
				_open(url,"window",920,360);
			}
		}

		//列表导出
		function _exportExcel(){
			if(confirm('Are you sure you want to export to an Excel document?')){
				_exportFile(document.srcForm,'xls');
			}else{
				return;
			}
		}
		
	</script>
	<BZ:body property="data" codeNames="PROVINCE;BCZL;ETXB;">
		<BZ:form name="srcForm" method="post" action="sce/lockchild/LockChildList.action">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" defaultValue=""/>
		<BZ:input type="hidden" field="RETURN_REASON" prefix="R_" id="R_RETURN_REASON" defaultValue=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
								<td class="bz-search-title" style="width: 12%">特别关注<br>Special focus</td>
								<td style="width: 16%">
									<BZ:select prefix="S_" field="SPECIAL_FOCUS" id="S_SPECIAL_FOCUS" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--Please Select--</BZ:option>
										<BZ:option value="0">No</BZ:option>
										<BZ:option value="1">Yes</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title" style="width: 12%">省份<br>Province</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="PROVINCE_ID" id="S_PROVINCE_ID" type="helper" helperCode="PROVINCE" treeType="0" defaultValue=""/>
								</td>
								
								<td class="bz-search-title" style="width: 12%">发布日期<br>Released date</td>
								<td style="width: 32%">
									<BZ:input prefix="S_" field="PUB_LASTDATE_START" id="S_PUB_LASTDATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="PUB_LASTDATE_END" id="S_PUB_LASTDATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_PUB_LASTDATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">儿童姓名<br>Name(EN)</td>
								<td class="bz-search-value">
									<BZ:input prefix="S_" field="NAME_PINYIN" id="S_NAME_PINYIN" defaultValue="" formTitle="" maxlength="150"/>
								</td>
								
								<td class="bz-search-title">性别<br>Sex</td>
								<td>
									<BZ:select prefix="S_" field="SEX" id="S_SEX" formTitle="性别" defaultValue="" codeName="ETXB" isCode="true" isShowEN="true" width="95%">
										<BZ:option value="">--Please Select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">出生日期<br>D.O.B</td>
								<td>
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
								<td class="bz-search-title">病残种类<br>SN type</td>
								<td>
									<BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" isShowEN="true" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--Please Select--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">病残诊断<br>Diagnosis(EN)</td>
								<td>
									<BZ:input prefix="S_" field="DISEASE_EN" id="R_DISEASE_EN" formTitle="" defaultValue="" maxlength="2000"/>
								</td>
								
								<td class="bz-search-title">安置期限<br>Deadline of placement</td>
								<td>
									<BZ:input prefix="S_" field="SETTLE_DATE_START" id="S_SETTLE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_SETTLE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="SETTLE_DATE_END" id="S_SETTLE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_SETTLE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
								
							</tr>
							<tr>
								<td class="bz-search-title">发布类型<br>Release type</td>
								<td>
									<BZ:select prefix="S_" field="PUB_TYPE" id="S_PUB_TYPE" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--Please Select--</BZ:option>
										<BZ:option value="1">Agency-specific</BZ:option>
										<BZ:option value="2">Shared</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">视频有无<br>Videos</td>
								<td>
									<BZ:select prefix="S_" field="HAVE_VIDEO" id="S_HAVE_VIDEO" formTitle="" defaultValue="" width="95%">
										<BZ:option value="">--Please Select--</BZ:option>
										<BZ:option value="0">No</BZ:option>
										<BZ:option value="1">Yes</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">最后更新日期<br>Last updated</td>
								<td colspan="3">
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_START" id="S_LAST_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_END\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />~
									<BZ:input prefix="S_" field="LAST_UPDATE_DATE_END" id="S_LAST_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_LAST_UPDATE_DATE_START\\')}',readonly:true,lang:'en'" defaultValue="" formTitle="" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="Search" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="Reset" onclick="_reset();" class="btn btn-sm btn-primary">
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
					<input type="button" value="Search" class="btn btn-sm btn-primary" onclick="_showSearch()"/>&nbsp;
					<input type="button" value="Lock" class="btn btn-sm btn-primary" onclick="_lockChild()"/>&nbsp;
					<input type="button" value="Return child file" class="btn btn-sm btn-primary" onclick="_consignReturn()"/>&nbsp;
					<!-- <input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_exportExcel();"/> -->
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
									<div class="sorting_disabled">序号<br>No.</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SPECIAL_FOCUS">特别关注<br>Special focus</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PROVINCE_ID">省份<br>Province</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME_PINYIN">姓名<br>Name(EN)</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="SEX">性别<br>Sex</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="BIRTHDAY">出生日期<br>D.O.B</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SN_TYPE">病残种类<br>SN type</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="DISEASE_EN">病残诊断<br>Diagnosis(EN)</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="PUB_LASTDATE">发布日期<br>Released date</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="PUB_TYPE">发布类型<br>Release type</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="HAVE_VIDEO">视频<br>Videos</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="SETTLE_DATE">安置期限<br>Deadline of placement</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="LAST_UPDATE_DATE">最后更新日期<br>Last updated</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" 
										value="<BZ:data field="CI_ID" defaultValue="" onlyValue="true"/>" 
										PUB_ID="<BZ:data field="PUB_ID" defaultValue="" onlyValue="true"/>" 
										PUB_TYPE="<BZ:data field="PUB_TYPE" defaultValue="" onlyValue="true"/>"
										class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td>
									<a href="#" onclick="_showChild('<BZ:data field="CI_ID" onlyValue="true"/>','<BZ:data field="PUB_ID" onlyValue="true"/>');return false;">
										<BZ:data field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
									</a>
								</td>
								<td><BZ:data field="SEX" defaultValue="" onlyValue="true" codeName="ETXB" isShowEN="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="SN_TYPE" codeName="BCZL" isShowEN="true" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="DISEASE_EN" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="PUB_LASTDATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="PUB_TYPE" checkValue="1=Agency-specific;2=Shared;" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="HAVE_VIDEO" defaultValue="No" onlyValue="true" checkValue="0=No;1=Yes;"/></td>
								<td class="center"><BZ:data field="SETTLE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="LAST_UPDATE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
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
							<td><BZ:page
								form="srcForm" 
								property="List" 
								type="EN" 
								exportXls="true" 
								exportTitle="预批申请记录"
								exportCode="SPECIAL_FOCUS=FLAG,0:No&1:Yes;PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;BIRTHDAY=DATE;SN_TYPE=CODE,BCZL;PUB_LASTDATE=DATE;PUB_TYPE=FLAG,1:Agency-specific&2:Shared;HAVE_VIDEO=FLAG,0:No&1:Yes;SETTLE_DATE=DATE;LAST_UPDATE_DATE=DATE;"
								exportField="SPECIAL_FOCUS=特别关注(Special focus),15,20;PROVINCE_ID=省份(Province),15;NAME_PINYIN=儿童姓名(Name(EN)),15;SEX=性别(Sex),15;BIRTHDAY=出生日期(D.O.B),15;SN_TYPE=病残种类(SN type),15;DISEASE_EN=病残诊断(Diagnosis(EN)),25;PUB_LASTDATE=当前发布日期(Released date),15;PUB_TYPE=发布类型(Release type),15;HAVE_VIDEO=视频有无(Videos),15;SETTLE_DATE=安置期限(Deadline of placement),15;LAST_UPDATE_DATE=最后更新日期(Last updated),15;"/>
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