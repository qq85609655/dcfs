<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	/**   
	 * @Title: setsettle_list.jsp
	 * @Description:  
	 * @author    
	 * @date 2014-9-16 上午10:02:12 
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
	<BZ:head>
		<title>期限参数列表</title>
		<BZ:webScript list="true"/>
	</BZ:head>
	<script>
	
		
		//安置、交文期限参数设置
		function update_row(id){
			window.open(path + "sce/setSettle/showSettleMonth.action?showuuid=" + id,"window","width=280,height=210,top=220,left=550");
		}
		
		function open_tijiao(){
			document.srcForm.action = path + "sce/setSettle/settleParaList.action";
			document.srcForm.submit();
		}
		
		
	</script>
	<BZ:body>
		<BZ:form name="srcForm" method="post" action="sce/setSettle/settleParaList.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		<div class="page-content">
			<div class="wrapper">
				<!--列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th style="width: 10%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 12%;">
									<div class="sorting" id="ONE_TYPE">发布类型</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="THREE_TYPE">点发类型</div>
								</th>
								<th style="width: 13%;">
									<div class="sorting" id="TWO_TYPE">是否特别关注</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="SETTLE_MONTHS">安置期限（单位：日）</div>
								</th>
								<th style="width: 15%;">
									<div class="sorting" id="SETTLE_MONTHS">交文期限（单位：日）</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="IS_VALID">是否有效</div>
								</th>
								<th style="width: 17%;">
									<div class="sorting_disabled">操作</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List" fordata="fordata">
							<tr class="emptyData">
								<td class="center">
									<BZ:i/>
								</td>
								<td><BZ:data field="ONE_TYPE" defaultValue="" onlyValue="true" checkValue="1=点发;2=群发;"/></td>
								<td><BZ:data field="THREE_TYPE" defaultValue="" onlyValue="true" checkValue="10=对口帮扶;20=特别关注;30=希望之旅;40=领导特批;50=奖励;60=夏令营冬令营;"/></td>
								<td><BZ:data field="TWO_TYPE" defaultValue="" onlyValue="true" checkValue="0=非特别关注;1=特别关注;"/></td>
								<td><BZ:data field="SETTLE_MONTHS" defaultValue="0" onlyValue="true" checkValue="0=未定;"/></td>
								<td><BZ:data field="DEADLINE" defaultValue="未定" onlyValue="true"/></td>
								<td><BZ:data field="IS_VALID" defaultValue="" onlyValue="true" checkValue="0=无效;1=有效;"/></td>
								<td><a href="#" onclick="update_row('<BZ:data field="SETTLE_ID" defaultValue="" onlyValue="true"/>');return false;">期限参数设置</a></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--列表区End -->
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
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>