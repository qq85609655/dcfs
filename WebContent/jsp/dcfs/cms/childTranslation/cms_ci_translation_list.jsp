<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
  /**   
 * @Description: 描述
 * @author wangzheng 
 * @date 2014-10-16 16:23:23
 * @version V1.0   
 */
  String compositor=(String)request.getAttribute("compositor");
  if(compositor==null){
      compositor="";
  }
  String ordertype=(String)request.getAttribute("ordertype");
  if(ordertype==null){
      ordertype="";
  }
  Data da = (Data)request.getAttribute("data");
  String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>材料翻译查询列表</title>
        <BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	</BZ:head>
  <script type="text/javascript">
  
  //iFrame高度自动调整
  $(document).ready(function() {
  			dyniframesize(['mainFrame']);
  			initProvOrg();
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
 //查询
  function _search(){
     document.srcForm.action=path+"cms/childTranslation/findList.action";
	 document.srcForm.submit();
  }
  

//材料翻译
  function _translation(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	var state="";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			state = document.getElementsByName('abc')[i].getAttribute("TRANSLATION_STATE");
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要翻译的材料!');
		return;
	}else if(state != "0" && state!="1"){
		page.alert('请选择一条待翻译或翻译中的材料进行翻译!');
		return;
	}else{
	 document.srcForm.action=path+"cms/childTranslation/translation.action?UUID="+showuuid;
	 document.srcForm.submit();
	 }
  }
  
  //查看
  function _view(){
	var arrays = document.getElementsByName("abc");
	var num = 0;
	var showuuid="";
	for(var i=0; i<arrays.length; i++){
		if(arrays[i].checked){
			showuuid=document.getElementsByName('abc')[i].value;
			num += 1;
		}
	}
	if(num != "1"){
		page.alert('请选择一条要查看的数据');
		return;
	}else{
		url = path+"cms/childTranslation/show.action?UUID="+showuuid;
		 _open(url, "材料信息", 1000, 600);
    }
  }


  //重置查询条件
  function _reset(){
	  document.getElementById("S_PROVINCE_ID").value = "";
	  document.getElementById("S_WELFARE_ID").value = "";
	  document.getElementById("S_CHILD_NO").value = "";
	  document.getElementById("S_NAME").value = "";
	  document.getElementById("S_SEX").value = "";
	  document.getElementById("S_CHILD_TYPE").value = "";
	  document.getElementById("S_SPECIAL_FOCUS").value = "";
	  document.getElementById("S_TRANSLATION_STATE").value = "";
	  document.getElementById("S_NOTICE_DATE_START").value = "";
	  document.getElementById("S_NOTICE_DATE_END").value = "";
	  document.getElementById("S_COMPLETE_DATE_START").value = "";
	  document.getElementById("S_COMPLETE_DATE_END").value = "";
  }
  
  //导出
	function _export(){
		if(confirm('确认要导出为Excel文件吗?')){
			_exportFile(document.srcForm,'xls');
		}else{
			return;
		}
	}
	//省厅福利院查询条件联动所需方法
	function selectWelfare(node){
		var provinceId = node.value;
		//用于回显得福利机构ID
		var selectedId = '<%=WELFARE_ID%>';
		var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
		if(dataList != null && dataList.size() > 0){
			//清空
			document.getElementById("S_WELFARE_ID").options.length=0;
			document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
			for(var i=0;i<dataList.size();i++){
				var data = dataList.getData(i);
				if(selectedId==data.getString("ORG_CODE")){
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					var option = document.getElementById("S_WELFARE_ID");
					document.getElementById("S_WELFARE_ID").value = selectedId;
				}else{					
					document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
				}
			}
		}else{
			//清空
			document.getElementById("S_WELFARE_ID").options.length=0;
			document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
		}
	}
	//省厅福利院查询条件联动所需方法
	function initProvOrg(){
		var str = document.getElementById("S_PROVINCE_ID");
	     selectWelfare(str);
	}
  </script>
<BZ:body property="data" codeNames="PROVINCE;ETXB;CHILD_TYPE;FYZT">
     <BZ:form name="srcForm" method="post" action="cms/childTranslation/findList.action">
     <BZ:frameDiv property="clueTo" className="kuangjia">
     <input type="hidden" name="deleteuuid" id="deleteuuid" value="" />
     <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
	 <input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
	 <input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
	 
	<!-- 功能按钮操作区End -->
	<!-- 查询条件区Start -->
	<div class="table-row" id="searchDiv" style="display: none">
		<table cellspacing="0" cellpadding="0">
			<tr>				
				<td style="width: 100%;">
					<table>
						<tr>							
							<td class="bz-search-title" style="width: 8%"><span title="省份">省份</span></td>
							<td style="width: 15%">
								<BZ:select prefix="S_"  field="PROVINCE_ID" isCode="true" codeName="PROVINCE" formTitle="省份" onchange="selectWelfare(this)">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>
							<td class="bz-search-title" style="width: 8%"><span title="福利院">福利院</span></td>
							<td style="width: 21%">
							<BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" width="95%" formTitle="福利院" defaultValue="">
						        <BZ:option value="">--请选择福利院--</BZ:option>
					        </BZ:select>
							</td>
							<td class="bz-search-title"  style="width: 8%"><span title="儿童编号">儿童编号</span></td>
							<td style="width: 15%">
							<BZ:input prefix="S_" field="CHILD_NO" id="S_CHILD_NO" defaultValue=""/>	
							</td>
							<td class="bz-search-title"  style="width: 8%"><span title="姓名">姓名</span></td>
							<td style="width: 17%">
							<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue=""/>	
							</td>
						</tr>
						<tr>
							<td class="bz-search-title"><span title="性别">性别</span></td>
							<td style="width: 15%">
								<BZ:select prefix="S_"  field="SEX" isCode="true" codeName="ETXB" formTitle="性别">
									<option value="">--请选择--</option>
								</BZ:select>
							</td>													
							<td class="bz-search-title"><span title="儿童类型">儿童类型</span></td>
							<td>
								<BZ:select prefix="S_" field="CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-search-title"><span title="特别关注">特别关注</span></td>
							<td>
								<BZ:select prefix="S_" field="SPECIAL_FOCUS" isCode="false" defaultValue="" formTitle="特别关注">
									<BZ:option value="">--请选择--</BZ:option>
									<BZ:option value="0">否</BZ:option>
									<BZ:option value="1">是</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-search-title"><span title="翻译状态">翻译状态</span></td>
							<td>
								<BZ:select prefix="S_" field="TRANSLATION_STATE" isCode="true" codeName="FYZT" formTitle="翻译状态" defaultValue="">
									<BZ:option value="">--请选择--</BZ:option>
								</BZ:select>																	
							</td>
						</tr>
						<tr>
							<td class="bz-search-title"><span title="通知日期">通知日期</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="NOTICE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_NOTICE_DATE_END\\')}',readonly:true"/>~
								<BZ:input prefix="S_" field="NOTICE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_NOTICE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_NOTICE_DATE_START\\')}',readonly:true"/>
							</td>
							<td class="bz-search-title"><span title="完成日期">完成日期</span></td>
							<td colspan="3">
								<BZ:input prefix="S_" field="COMPLETE_DATE_START" type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_START" dateExtend="maxDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_END\\')}',readonly:true"/>~
								<BZ:input prefix="S_" field="COMPLETE_DATE_END"   type="Date" dateFormat="yyyy-MM-dd" defaultValue=""  id="S_COMPLETE_DATE_END" dateExtend="minDate:'#F{$dp.$D(\\'S_COMPLETE_DATE_START\\')}',readonly:true"/>
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
		<input type="button" value="材料翻译" class="btn btn-sm btn-primary" onclick="_translation()"/>&nbsp;
		<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_view()"/>&nbsp;
		<input type="button" value="导&nbsp;&nbsp;出" class="btn btn-sm btn-primary" onclick="_export()"/>&nbsp;
	</div>	
	<!--查询结果列表区Start -->
	<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
			<thead>
				<tr class="emptyData">
					<th class="center" style="width:2%;">
						<div class="sorting_disabled"><input name="abcd" type="checkbox" class="ace"></div>
					</th>
					<th style="width:3%;">
						<div class="sorting_disabled">序号</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="PROVINCE_ID">省份</div>
					</th>
					<th style="width:15%;">
						<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="CHILD_NO">儿童编号</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="NAME">姓名</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SEX">性别</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="CHILD_TYPE">儿童类型</div>
					</th>
					<th style="width:5%;">
						<div class="sorting" id="SPECIAL_FOCUS">特别关注</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="NOTICE_DATE">通知日期</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="COMPLETE_DATE">完成日期</div>
					</th>
					<th style="width:10%;">
						<div class="sorting" id="TRANSLATION_STATE">翻译状态</div>
					</th>						
				</tr>
				</thead>
				<tbody>	
					<BZ:for property="List">
						<tr class="emptyData">
							<td class="center">
								<input name="abc" type="checkbox" value="<BZ:data field="CT_ID" onlyValue="true"/>" TRANSLATION_STATE="<BZ:data field="TRANSLATION_STATE" onlyValue="true"/>" class="ace">
							</td>
							<td class="center">
								<BZ:i/>
							</td>
							<td><BZ:data field="PROVINCE_ID" codeName="PROVINCE" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="CHILD_NO" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="SEX" codeName="ETXB" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="CHILD_TYPE" codeName="CHILD_TYPE" onlyValue="true"/></td>
							<td><BZ:data field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/></td>
							<td><BZ:data field="NOTICE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td><BZ:data field="COMPLETE_DATE" type="Date" defaultValue="" onlyValue="true"/></td>
							<td align="center"><BZ:data field="TRANSLATION_STATE" codeName="FYZT" defaultValue="" onlyValue="true"/></td>
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
					<td><BZ:page form="srcForm" property="List" exportXls="true" exportTitle="儿童材料翻译数据" 
					exportCode="PROVINCE_ID=CODE,PROVINCE;SEX=CODE,ETXB;NOTICE_DATE=DATE;COMPLETE_DATE=DATE;CHILD_TYPE=CODE,CHILD_TYPE;TRANSLATION_STATE=CODE,FYZT;SPECIAL_FOCUS=FLAG,0: &1:是;" 
					exportField="PROVINCE_ID=省份,15,20;WELFARE_NAME_CN=福利院,30;CHILD_NO=儿童编号,15;NAME=姓名,15;SEX=性别,10;CHILD_TYPE=儿童类型,15;SPECIAL_FOCUS=特别关注,15;NOTICE_DATE=通知日期,15;COMPLETE_DATE=完成日期,15;TRANSLATION_STATE=翻译状态,15"/></td>				
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
