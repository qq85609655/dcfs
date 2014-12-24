<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_fbhistory_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
 Data data= (Data)request.getAttribute("data");
 String IS_TWINS = data.getString("IS_TWINS");
%>
<BZ:html>
	<BZ:head>
		<title>儿童历次发布信息</title>
		<BZ:webScript list="true" edit="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		//查看该发布记录发布组织列表
		function _showFbOrgList(pub_id){
			$.layer({
				type : 2,
				title : "本次发布组织列表",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				iframe: {src: '<BZ:url/>/sce/publishManager/findListForFBORG.action?pub_id='+pub_id},
				area: ['1150px','800px'],
				offset: ['0px' , '0px']
			});
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG;PROVINCE;BCZL;DFLX;">
		<BZ:form name="srcForm" method="post">
		<!-- 用于保存数据结果提示 -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value=""/>
		<input type="hidden" name="ordertype" value=""/>
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) End-->
		
		
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="关&nbsp;&nbsp;闭" class="btn btn-sm btn-primary" onclick="_close()"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!-- 编辑区域begin -->
				<div class="bz-edit clearfix" desc="编辑区域">
					<div class="ui-widget-content ui-corner-all bz-edit-warper">
						<!-- 标题区域 begin -->
						<div class="ui-state-default bz-edit-title" desc="标题">
							<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
							<div>儿童基本信息</div>
						</div>
						<!-- 标题区域 end -->
						<!-- 内容区域 begin -->
						<div class="bz-edit-data-content clearfix" desc="内容体">
							<table class="bz-edit-data-table" border="0">
								<tr>
									<td class="bz-edit-data-title" width="10%">省份</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="PROVINCE_ID" codeName="PROVINCE"  defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">福利院</td>
									<td class="bz-edit-data-value" colspan="5">
										<BZ:dataValue field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/>
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">姓名</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="NAME" defaultValue="" onlyValue="true"/>
									</td>
									<td class="bz-edit-data-title" width="10%">性别</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SEX" defaultValue="" onlyValue="true" checkValue="1=男;2=女;3=两性"/>
									</td>
									<td class="bz-edit-data-title" width="10%">出生日期</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="BIRTHDAY" defaultValue="" onlyValue="true" type="Date" />
									</td>
									
									<td class="bz-edit-data-title" width="10%">病残种类</td>
									<td class="bz-edit-data-value" width="15%">
										<BZ:dataValue field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true" />
									</td>
								</tr>
								<tr>
									<td class="bz-edit-data-title" width="10%">特别关注</td>
									<td class="bz-edit-data-value">
										<BZ:dataValue field="SPECIAL_FOCUS" defaultValue="" onlyValue="true" checkValue="0=否;1=是;"/>
									</td>
									<td class="bz-edit-data-title" width="10%">是否多胞胎</td>
									<td class="bz-edit-data-value" >
										<BZ:dataValue field="IS_TWINS" defaultValue="" onlyValue="true" checkValue="0=否;1=是"/>
									</td>
									<td class="bz-edit-data-title" width="10%"><%if("1".equals(IS_TWINS)||"1"==IS_TWINS){ %>同胞姓名<%} %></td>
									<td class="bz-edit-data-value" colspan="3">
										<BZ:dataValue field="TB_NAME" defaultValue="" onlyValue="true"/>
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
							<div>历次发布记录列表</div>
						</div>
						<!-- 标题区域 end -->
						<!--查询结果列表区Start -->
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
								<thead>
									<tr>
										<th style="width: 4%;">
											<div class="sorting_disabled">序号</div>
										</th>
										<th style="width:9%;">
											<div class="sorting_disabled" id="PUB_DATE">发布日期</div>
										</th>
										<th style="width: 4%;">
											<div class="sorting_disabled" id="PUB_TYPE">发布类型</div>
										</th>
										<th style="width: 7%;">
											<div class="sorting_disabled" id="PUB_MODE">点发类型</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_ORGID">发布组织</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="PUB_REMARKS">点发备注</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="PUBLISHER_NAME">发布人</div>
										</th>
										<th style="width: 9%;">
											<div class="sorting_disabled" id="REVOKE_DATE">撤销发布日期</div>
										</th>
										<th style="width: 5%;">
											<div class="sorting_disabled" id="REVOKE_USERNAME">撤销发布人</div>
										</th>
										<th style="width: 15%;">
											<div class="sorting_disabled" id="REVOKE_REASON">撤销发布原因</div>
										</th>
										
									</tr>
								</thead>
								<tbody>
								<BZ:for property="List" fordata="resultData">
									<tr class="emptyData">
										<td class="center">
											<BZ:i/>
										</td>
										<td><BZ:data field="PUB_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
										<td><BZ:data field="PUB_TYPE" defaultValue=""  checkValue="1=点发;2=群发" onlyValue="true"/></td>
										<td><BZ:data field="PUB_MODE" defaultValue=""  codeName="DFLX" onlyValue="true"/></td>
										<td>
											<%
											   Data resultData=(Data)pageContext.getAttribute("resultData");
											   String pubOrgId = resultData.getString("PUB_ORGID","");
												if(null!=pubOrgId&&!"".equals(pubOrgId)){
											     if(pubOrgId.indexOf(",")>0){
											 %>
											 <a href="javascript:_showFbOrgList('<BZ:data field="PUB_ID" defaultValue="" onlyValue="true" />')" title="点击查看发布组织信息">
											 	群发
											 </a>
											 <%
											   }else{
											 %>
											 	<BZ:data field="PUB_ORGID" defaultValue=""  codeName="SYS_ADOPT_ORG" length="20"/>
											 <% 
											   }
											}
											 %>
											
										</td>
										<td><BZ:data field="PUB_REMARKS" defaultValue="" length="20"/></td>
										<td><BZ:data field="PUBLISHER_NAME" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_USERNAME" defaultValue="" onlyValue="true"/></td>
										<td><BZ:data field="REVOKE_REASON" defaultValue="" length="20"/></td>
									</tr>
								</BZ:for>
								</tbody>
							</table>
						</div>
						<!--查询结果列表区End -->
					</div>
				</div>
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>