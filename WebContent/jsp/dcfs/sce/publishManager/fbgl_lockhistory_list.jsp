<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
/**   
 * @Title: fbgl_lockhistory_list.jsp
 * @Description:  
 * @author mayun   
 * @date 2014-9-11
 * @version V1.0   
 */
%>
<BZ:html>
	<BZ:head>
		<title>历次锁定信息</title>
		<BZ:webScript list="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resources/resource1/js/page.js"></script>
	</BZ:head>
	<script>
		function _close(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		}
		
		function _showYPInfo(ypid){
			var url = path+"sce/preapproveapply/PreApproveApplyShowForFBGL.action?type=show&RI_ID="+ypid;
			window.open(url,"预批基本信息","");
		}
	</script>
	<BZ:body property="data" codeNames="GJSY;SYS_ADOPT_ORG">
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
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 4%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width:5%;">
									<div class="sorting_disabled" id="COUNTRY_CODE">锁定国家</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting_disabled" id="ADOPT_ORG_NAME_CN">锁定组织</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting_disabled" id="LOCK_DATE">锁定时间</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="UNLOCKER_DATE">解除锁定日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="UNLOCKER_TYPE">解除锁定类型</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting_disabled" id="UNLOCKER_REASON">解除锁定原因</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled" id="UNLOCKER_NAME">解除人</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="REQ_NO">预批编号</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting_disabled" id="RI_STATE">预批状态</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="MALE_NAME">男收养人</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting_disabled" id="FEMALE_NAME">女收养人</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="COUNTRY_CODE" defaultValue="" onlyValue="true" codeName="GJSY" /></td>
								<td><BZ:data field="ADOPT_ORG_ID" defaultValue="" codeName="SYS_ADOPT_ORG" onlyValue="true"/></td>
								<td><BZ:data field="LOCK_DATE" defaultValue="" type="DateTime" onlyValue="true"/></td>
								<td><BZ:data field="UNLOCKER_DATE" defaultValue=""  type="DateTime"  onlyValue="true" /></td>
								<td><BZ:data field="UNLOCKER_TYPE" defaultValue="" checkValue="0=超期解锁;1=组织接收;2=中心解锁" onlyValue="true"/></td>
								<td><BZ:data field="UNLOCKER_REASON" defaultValue="" length="20" /></td>
								<td><BZ:data field="UNLOCKER_NAME" defaultValue="" onlyValue="true"/></td>
								<td><a href="#" onclick="_showYPInfo('<BZ:data field="RI_ID" defaultValue="" onlyValue="true"/>');return false;" > <BZ:data field="REQ_NO" defaultValue=""  onlyValue="true"/></a></td>
								<td><BZ:data field="RI_STATE" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="MALE_NAME" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="FEMALE_NAME" defaultValue="" onlyValue="true"  /></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>