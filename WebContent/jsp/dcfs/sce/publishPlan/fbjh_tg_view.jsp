<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="base.task.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data data = (Data)request.getAttribute("data");
	String plan_id =data.getString("PLAN_ID");//�����ƻ�ID
	String note_date = data.getString("NOTE_DATE");//Ԥ������
	String pub_date = data.getString("PUB_DATE");//��������
	Date noteDate = new Date();
	Date pubDate = new Date();
	
	String note_date_zw ="";
	String pub_date_zw ="";
	String note_date_yw ="";
	String pub_date_yw_hour ="";
	String pub_date_yw ="";
	if(!"".equals(plan_id)&&null!=plan_id){
		noteDate = DateUtil.stringToDate(note_date);
		pubDate = DateUtil.stringToDate(pub_date);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy��MM��dd��");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy��MM��dd�� HHʱ");
		SimpleDateFormat sdf3 = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat sdf4 = new SimpleDateFormat("HH:mm");
		
		note_date_zw = sdf.format(noteDate);
		pub_date_zw = sdf2.format(pubDate);
		note_date_yw = sdf3.format(noteDate);
		pub_date_yw_hour = sdf4.format(pubDate);
		pub_date_yw = sdf3.format(pubDate);
	}
	

 %>
<BZ:html>
	<BZ:head>
		<title>�����ƻ�ͨ��ҳ��</title>
		<BZ:webScript list="true" edit="true" tree="true"/>
		<script type="text/javascript" src="/dcfs/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
		
	</script>
	<BZ:body property="data">
		<BZ:form name="srcForm" method="post">
		<!-- ���ڱ������ݽ����ʾ -->
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<div>
			<table style="margin-top: 2cm;width: 21cm;" align="center">
			<% if(!"".equals(plan_id)&&null!=plan_id){%>
				<tr>
					<td style="font-size: 24pt;text-align: center;">
						�����ͯ����ͨ��
					</td>
				</tr>
				<tr>
					<td style="font-size: 16pt;padding-top: 0.2cm;line-height: 40px;">
						���й��������������ź�������֯��<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;�ȶ���
						<span style="text-decoration: underline;">&nbsp;&nbsp;<%=pub_date_zw %>&nbsp;&nbsp;</span>�����ϡ�Ⱥ����һ�������ͯ, �����ע��
					</td>
				</tr>
				<tr>
					<td style="font-size: 16pt;padding-top: 0.2cm;line-height: 40px;">
						&nbsp;&nbsp;&nbsp;&nbsp;�ش�ͨ�档
					</td>
				</tr>
				<tr>
					<td style="font-size: 16pt;padding-top: 0.5cm;text-align: right;line-height: 40px;">
						�й���ͯ��������������<br/>
					</td>
				</tr>
				<tr>
					<td style="font-size: 16pt;padding-top: 0.2cm;text-align: right;line-height: 40px;">
							<%=note_date_zw %>
					</td>
				</tr>
				<tr>
					<td style="font-size: 18pt;padding-top: 2cm;text-align: center;">
						Announcement<br/>
					</td>
				</tr>
				<tr>
					<td style="font-size: 12pt;padding-top: 0.5cm;">
						<%=note_date_yw %>
					</td>
				</tr>
				<tr>
					<td style="font-size: 12pt;padding-top: 0.2cm;line-height: 40px;">
						Government departments and adoption agencies in receiving countries,
					</td>
				</tr>
				<tr>
					<td style="font-size: 12pt;padding-top: 0.2cm;line-height: 40px;">
						Please be aware of that CCCWA will post a batch of files for special needs children on 
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 12pt;padding-top: 0.2cm;line-height: 40px;">
						the multiple list (i.e. shared list) from <span style="text-decoration: underline; font-size:14pt">&nbsp;&nbsp;<%=pub_date_yw_hour %>&nbsp;&nbsp;</span>Beijing time on <span style="text-decoration: underline;font-size:14pt">&nbsp;&nbsp;<%=pub_date_yw %>&nbsp;&nbsp;</span>
					</td>
				</tr>
				<tr>
					<td style="font-size: 14pt;padding-top: 0.5cm;text-align: left;line-height: 40px;">
						China Center for Children��s Welfare and Adoption
					</td>
				</tr>
				<%}else{ %>
				<tr>
					<td style="font-size: 24pt;text-align: center;">
						����ͨ����Ϣ��
					</td>
				</tr>
				<%} %>
			</table>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>