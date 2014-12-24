package com.dcfs.ncm.normal;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.hx.framework.authenticate.SessionInfo;
/**
 * @Title: NormalMatchAction.java
 * @Description: ������ͯƥ��
 * @Company: 21softech
 * @Created on 2014-9-2 ����3:44:53
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class NormalMatchAction extends BaseAction{

    private static Log log=UtilLog.getLog(NormalMatchAction.class);
    private Connection conn = null;
    private NormalMatchHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
	public NormalMatchAction() {
	    this.handler=new NormalMatchHandler();
	    this.Mhandler=new MatchHandler();
	    this.AFhandler=new FileCommonManager();
	    this.CIhandler=new ChildManagerHandler();
	}

	@Override
	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * 
	 * @Title: normalMatchAFList
	 * @Description: ƥ���б�--�������б�
	 * @author: xugy
	 * @date: 2014-9-2����4:43:58
	 * @return
	 */
	public String normalMatchAFList(){
	    // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        String result = getParameter("result","");
        if("0".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(0, "ƥ��ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);//set�����������
        }
        if("2".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(2, "ƥ��ʧ�ܻ��������ƥ�䣬������ƥ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);//set�����������
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","MATCH_RECEIVEDATE_START","MATCH_RECEIVEDATE_END","FILE_TYPE","ADOPT_REQUEST_CN","UNDERAGE_NUM","MATCH_NUM","MATCH_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "������ͯƥ���б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction��matchList.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * 
	 * @Title: matchPlanCount
	 * @Description: ������ͯԤ����ƻ�ͳ��ҳ��
	 * @author: xugy
	 * @date: 2014-9-2����7:23:43
	 * @return
	 */
	public String toMatchPlanCount(){
	    Data Data = new Data();
	    DataList CIdl = new DataList();
	    setAttribute("CIdl",CIdl);
	    setAttribute("Data",Data);
        return retValue;
	}
	
	/**
	 * 
	 * @Title: planCount
	 * @Description: ������ͯԤ����ƻ�ͳ��
	 * @author: xugy
	 * @date: 2014-9-3����3:19:27
	 * @return
	 */
	public String planCount(){
	    Data Data = getRequestEntityData("C_","COUNT_DATE","FILE_TYPE","DATE_START","DATE_END");
	    try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            /***************��ѯ��ͯ��������****************/
            DataList CIdl = new DataList();
            Data CIdata = new Data();//��ͯ��������
            //String FILE_STATE = Data.getString("FILE_STATE");
            CIdl = handler.CIplanCount(conn);
            CIdata = handler.CIplanCountSum(conn);
            Data.addData(CIdata);
            /***************��ѯ��ͯ��������****************/
            /***************��ѯ�����ļ�����****************/
            Data AFdata = new Data();//�����ļ�����
            String FILE_TYPE = Data.getString("FILE_TYPE");
            String DATE_START = Data.getString("DATE_START");
            String DATE_END = Data.getString("DATE_END");
            //�ж�ͳ�ƻ�׼�Ĳ�ͬ�����ĵǼ����ڣ�REG_DATE�����ļ��������ڣ�RECEIVER_DATE���� ��ͬ�Ĳ�ѯ������
            String COUNT_DATE = Data.getString("COUNT_DATE");
            if("REG_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼�����ĵǼ����ڣ���ѯREG_DATE�ֶ�
                AFdata=handler.AFplanCountSum1(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼���ļ��������ڣ���ѯRECEIVER_DATE�ֶΣ��������ѯ
                AFdata=handler.AFplanCountSum2(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            Data.addData(AFdata);
            /***************��ѯ�����ļ�����****************/
            //ʣ�����
            int CI_COUNT = CIdata.getInt("CI_COUNT");
            int AF_COUNT = AFdata.getInt("AF_COUNT");
            int surplus = CI_COUNT-AF_COUNT;
            Data.add("SURPLUS", surplus);
            //�������д��ҳ����ձ���
            setAttribute("CIdl",CIdl);
            setAttribute("Data",Data);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	public String AFPlanList(){
	    Data Data = new Data();
	    String COUNT_DATE = getParameter("COUNT_DATE");
	    String FILE_TYPE = getParameter("FILE_TYPE");
	    String DATE_START = getParameter("DATE_START");
	    String DATE_END = getParameter("DATE_END");
	    Data.add("COUNT_DATE", COUNT_DATE);
	    Data.add("FILE_TYPE", FILE_TYPE);
	    Data.add("DATE_START", DATE_START);
	    Data.add("DATE_END", DATE_END);
	    try {
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            DataList AFdl = new DataList();
            //�ж�ͳ�ƻ�׼�Ĳ�ͬ�����ĵǼ����ڣ�REG_DATE�����ļ��������ڣ�RECEIVER_DATE���� ��ͬ�Ĳ�ѯ������
            if("REG_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼�����ĵǼ����ڣ���ѯREG_DATE�ֶ�
                AFdl=handler.findAFPlanList1(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼���ļ��������ڣ���ѯRECEIVER_DATE�ֶΣ��������ѯ
                AFdl=handler.findAFPlanList2(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            
            
	        setAttribute("AFdl",AFdl);
	        setAttribute("Data",Data);
	    } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	public String exportExcel() throws Exception{
	    Data Data = getRequestEntityData("E_","COUNT_DATE","FILE_TYPE","DATE_START","DATE_END");
	    HttpServletResponse response = getResponse();
        OutputStream os = response.getOutputStream();// ȡ�������
        response.reset();// ��������
	    try {
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            DataList AFdl = new DataList();
            String FILE_TYPE = Data.getString("FILE_TYPE");
            String DATE_START = Data.getString("DATE_START");
            String DATE_END = Data.getString("DATE_END");
            //�ж�ͳ�ƻ�׼�Ĳ�ͬ�����ĵǼ����ڣ�REG_DATE�����ļ��������ڣ�RECEIVER_DATE���� ��ͬ�Ĳ�ѯ������
            String COUNT_DATE = Data.getString("COUNT_DATE");
            String tab_benchmark = "";//�Ʊ��׼
            if("REG_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼�����ĵǼ����ڣ���ѯREG_DATE�ֶ�
                AFdl=handler.findAFPlanList1(conn,FILE_TYPE,DATE_START,DATE_END);
                tab_benchmark = "���ĵǼ�����";
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//���ͳ�ƻ�׼���ļ��������ڣ���ѯRECEIVER_DATE�ֶΣ��������ѯ
                AFdl=handler.findAFPlanList2(conn,FILE_TYPE,DATE_START,DATE_END);
                tab_benchmark = "�ļ���������";
            }
            // ����excel�ļ�
            WritableWorkbook wbook = Workbook.createWorkbook(os);
            // sheet����
            WritableSheet sheetOne = wbook.createSheet("����ƻ���", 0);
            sheetOne.setColumnView(0, 5);//�����п�
            sheetOne.setColumnView(11, 30);//�����п�
            sheetOne.setColumnView(12, 30);//�����п�
            sheetOne.getSettings().setDefaultColumnWidth(15); // ����������Ĭ�Ͽ��
            sheetOne.setRowView(0, 700);//�����и�
            sheetOne.setRowView(1, 500);//�����и�
            sheetOne.setRowView(2, 500);//�����и�
            sheetOne.setRowView(3, 500);//�����и�
            
            // ������ʽ
            WritableFont wfont1 = new WritableFont(WritableFont.ARIAL, 12,WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK); // �����ʽ ���� �»��� б�� ���� ��ɫ
            WritableFont wfont2 = new WritableFont(WritableFont.ARIAL, 16,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK); // �����ʽ ���� �»��� б�� ���� ��ɫ
            // ������Ԫ����ʽ
            WritableCellFormat cfont1 = new WritableCellFormat(wfont1);
            cfont1.setBackground(Colour.WHITE); // ���õ�Ԫ��ı�����ɫ
            cfont1.setAlignment(Alignment.CENTRE); // ����ˮƽ���뷽ʽ
            cfont1.setVerticalAlignment(VerticalAlignment.CENTRE);// ���ô�ֱ���䷽ʽ;
            cfont1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // ���ñ߿�
            cfont1.setWrap(true);// �Զ�����
            WritableCellFormat cfont2 = new WritableCellFormat(wfont2);
            cfont2.setBackground(Colour.WHITE); // ���õ�Ԫ��ı�����ɫ
            cfont2.setAlignment(Alignment.CENTRE); // ����ˮƽ���뷽ʽ
            cfont2.setVerticalAlignment(VerticalAlignment.CENTRE);// ���ô�ֱ���䷽ʽ;
            cfont2.setBorder(jxl.format.Border.NONE,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // ���ñ߿�
            cfont2.setWrap(true);// �Զ�����
            WritableCellFormat cfont3 = new WritableCellFormat(wfont1);
            cfont3.setBackground(Colour.WHITE); // ���õ�Ԫ��ı�����ɫ
            cfont3.setAlignment(Alignment.LEFT); // ����ˮƽ���뷽ʽ
            cfont3.setVerticalAlignment(VerticalAlignment.CENTRE);// ���ô�ֱ���䷽ʽ;
            cfont3.setBorder(jxl.format.Border.NONE,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // ���ñ߿�
            cfont3.setWrap(true);// �Զ�����
            
            // ���ñ�ͷ
            Label t00 = new Label(0, 0, "������ͯԤ����ƻ���", cfont2);
            sheetOne.mergeCells(0, 0, 12, 0);
            Label t01 = new Label(0, 1, "�Ʊ��׼��"+tab_benchmark, cfont3);
            sheetOne.mergeCells(0, 1, 8, 1);
            Label t02 = new Label(0, 2, "�Ʊ����䣺"+DATE_START+"~"+DATE_END, cfont3);
            sheetOne.mergeCells(0, 2, 8, 2);
            String tab_interval = "";//�Ʊ�����
            if("10".equals(FILE_TYPE)){
                tab_interval = "����";
            }
            if("30".equals(FILE_TYPE)){
                tab_interval = "�쵼����";
            }
            if("31".equals(FILE_TYPE)){
                tab_interval = "�ڻ�";
            }
            if("32".equals(FILE_TYPE)){
                tab_interval = "����";
            }
            if("33".equals(FILE_TYPE)){
                tab_interval = "����Ů����";
            }
            if("34".equals(FILE_TYPE)){
                tab_interval = "��������";
            }
            if("35".equals(FILE_TYPE)){
                tab_interval = "����";
            }
            Label t03 = new Label(0, 3, "�Ʊ����"+tab_interval+"�ļ�", cfont3);
            sheetOne.mergeCells(0, 3, 8, 3);
            
            Label t81 = new Label(9, 1, "", cfont3);
            sheetOne.mergeCells(9, 1, 12, 1);
            Label t82 = new Label(9, 2, "", cfont3);
            sheetOne.mergeCells(9, 2, 12, 2);
            Label t83 = new Label(9, 3, "�Ʊ����ڣ�"+DateUtility.getCurrentDate(), cfont3);
            sheetOne.mergeCells(9, 3, 12, 3);
            Label t04 = new Label(0, 4, "���", cfont1);
            Label t14 = new Label(1, 4, "�ļ����", cfont1);
            Label t24 = new Label(2, 4, "�Ǽ�����", cfont1);
            Label t34 = new Label(3, 4, "����", cfont1);
            Label t44 = new Label(4, 4, "��������", cfont1);
            Label t54 = new Label(5, 4, "��������", cfont1);
            Label t64 = new Label(6, 4, "�з���������", cfont1);
            Label t74 = new Label(7, 4, "Ů������", cfont1);
            Label t84 = new Label(8, 4, "Ů����������", cfont1);
            Label t94 = new Label(9, 4, "������׼������", cfont1);
            Label t104 = new Label(10, 4, "��������", cfont1);
            Label t114 = new Label(11, 4, "��Ů���", cfont1);
            Label t124 = new Label(12, 4, "����Ҫ��", cfont1);
            // ����ͷ����sheet��
            sheetOne.addCell(t00);
            sheetOne.addCell(t01);
            sheetOne.addCell(t02);
            sheetOne.addCell(t03);
            sheetOne.addCell(t81);
            sheetOne.addCell(t82);
            sheetOne.addCell(t83);
            sheetOne.addCell(t04);
            sheetOne.addCell(t14);
            sheetOne.addCell(t24);
            sheetOne.addCell(t34);
            sheetOne.addCell(t44);
            sheetOne.addCell(t54);
            sheetOne.addCell(t64);
            sheetOne.addCell(t74);
            sheetOne.addCell(t84);
            sheetOne.addCell(t94);
            sheetOne.addCell(t104);
            sheetOne.addCell(t114);
            sheetOne.addCell(t124);
            if(AFdl.size()>0){
                for(int i=0;i<AFdl.size();i++){
                    //���
                    int k = i+1;
                    String num = String.valueOf(k);
                    Label xuhao = new Label(0, i + 5, num, cfont1);
                    sheetOne.addCell(xuhao);
                    //�ļ����
                    String FILE_NO = AFdl.getData(i).getString("FILE_NO", "");
                    Label fileNo = new Label(1, i + 5, FILE_NO, cfont1);
                    sheetOne.addCell(fileNo);
                    //�Ǽ�����
                    String REG_DATE = AFdl.getData(i).getDate("REG_DATE");
                    Label regDate = new Label(2, i + 5, REG_DATE, cfont1);
                    sheetOne.addCell(regDate);
                    //����
                    String COUNTRY_CN = AFdl.getData(i).getString("COUNTRY_CN", "");
                    Label countryCn = new Label(3, i + 5, COUNTRY_CN, cfont1);
                    sheetOne.addCell(countryCn);
                    //��������
                    String NAME_CN = AFdl.getData(i).getString("NAME_CN", "");
                    Label nameCn = new Label(4, i + 5, NAME_CN, cfont1);
                    sheetOne.addCell(nameCn);
                    //��������
                    String MALE_NAME = AFdl.getData(i).getString("MALE_NAME", "");
                    Label maleName = new Label(5, i + 5, MALE_NAME, cfont1);
                    sheetOne.addCell(maleName);
                    //�з���������
                    String MALE_BIRTHDAY = AFdl.getData(i).getDate("MALE_BIRTHDAY");
                    Label maleBirthday = new Label(6, i + 5, MALE_BIRTHDAY, cfont1);
                    sheetOne.addCell(maleBirthday);
                    //Ů������
                    String FEMALE_NAME = AFdl.getData(i).getString("FEMALE_NAME", "");
                    Label femaleName = new Label(7, i + 5, FEMALE_NAME, cfont1);
                    sheetOne.addCell(femaleName);
                    //Ů����������
                    String FEMALE_BIRTHDAY = AFdl.getData(i).getDate("FEMALE_BIRTHDAY");
                    Label femaleBirthday = new Label(8, i + 5, FEMALE_BIRTHDAY, cfont1);
                    sheetOne.addCell(femaleBirthday);
                    //������׼������
                    String GOVERN_DATE = AFdl.getData(i).getDate("GOVERN_DATE");
                    Label governDate = new Label(9, i + 5, GOVERN_DATE, cfont1);
                    sheetOne.addCell(governDate);
                    //��������
                    String EXPIRE_DATE = AFdl.getData(i).getDate("EXPIRE_DATE");
                    Label expireDate = new Label(10, i + 5, EXPIRE_DATE, cfont1);
                    sheetOne.addCell(expireDate);
                    //��Ů���
                    String CHILD_CONDITION_CN = AFdl.getData(i).getString("CHILD_CONDITION_CN", "");
                    Label childConditionCn = new Label(11, i + 5, CHILD_CONDITION_CN, cfont1);
                    sheetOne.addCell(childConditionCn);
                    //����Ҫ��
                    String ADOPT_REQUEST_CN = AFdl.getData(i).getString("ADOPT_REQUEST_CN", "");
                    Label adoptRequestCn = new Label(12, i + 5, ADOPT_REQUEST_CN, cfont1);
                    sheetOne.addCell(adoptRequestCn);
                }
                //�ϼ�
                int index = AFdl.size();
                String countSum = String.valueOf(index);
                Label heji = new Label(0, index + 5, "�ϼƣ�����"+countSum+"��", cfont3);
                sheetOne.mergeCells(0, index + 5, 12, index + 5);
                sheetOne.addCell(heji);
            }
            
            response.setHeader("Content-disposition", "attachment; filename="+ java.net.URLEncoder.encode("������ͯԤ����ƻ���.xls", "UTF-8"));// �趨����ļ�ͷ
            response.setContentType("application/msexcel");// �����������
            
            wbook.write();
            wbook.close();
	    }catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return null;
	}
	/**
	 * 
	 * @Title: normalMatchCIList
	 * @Description: ѡ��ƥ���ͯ�б�
	 * @author: xugy
	 * @date: 2014-9-4����2:30:11
	 * @return
	 */
	public String normalMatchCIList(){
	    // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 ��ȡ��������
        InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
        setAttribute("clueTo", clueTo);//set�����������
        String AFid = getParameter("AFid");//ѡ����������ļ���ID
        
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","CHECKUP_DATE_START","CHECKUP_DATE_END","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END");//��ѯ����
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data AFdata=Mhandler.getAFInfoOfAfId(conn, AFid);//��ȡѡ����������ļ���Ϣ
            String nowYear = DateUtility.getCurrentYear();
            //������������
            if(!"".equals(AFdata.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = AFdata.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                AFdata.add("MALE_AGE", maleAge);
            }
            //Ů����������
            if(!"".equals(AFdata.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = AFdata.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                AFdata.add("FEMALE_AGE", femaleAge);
            }
            data.addData(AFdata);
            //5 ��ȡ����DataList
            DataList CIdl=handler.findCIMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("CIdl",CIdl);
            setAttribute("AFid",AFid);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction��CIMatchList.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: showCIs
	 * @Description: ��ʾ��ͯ��Ϣ
	 * @author: xugy
	 * @date: 2014-9-4����5:01:14
	 * @return
	 */
	public String showCIs(){
	    String CHILD_NOs = getParameter("CHILD_NOs");//��ͯ��ţ���ͬ���Ķ����ͯ���
	    try {
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            //DataList CIdls=Mhandler.getCIInfoInChildNo(conn,InChildNo);
            //�������д��ҳ����ձ���
            setAttribute("CHILD_NOs",CHILD_NOs);
	    }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction��showCIs.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: matchPreview
	 * @Description: ƥ��Ԥ��
	 * @author: xugy
	 * @date: 2014-9-4����7:51:06
	 * @return
	 */
	public String matchPreview(){
	    String CIid = getParameter("CIid");//ƥ���ͯID
	    String AFid = getParameter("AFid");//ƥ��������ID
	    try {
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ѯ��������Ϣ
            Data data = Mhandler.getAFInfoOfAfId(conn, AFid);
            //�������д��ҳ����ձ���
            setAttribute("CIid",CIid);
            setAttribute("AFid",AFid);
            setAttribute("data",data);
	    }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction��matchPreview.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: showTwinsCI
	 * @Description: �鿴��ͯͬ����Ϣ
	 * @author: xugy
	 * @date: 2014-9-5����5:05:19
	 * @return
	 */
	public String showTwinsCI(){
	    String CHILD_NOs = getParameter("CHILD_NOs");//��ͯͬ��ID������ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            //DataList CIdls=Mhandler.getCIInfoInChildNo(conn,ids);
            //�������д��ҳ����ձ���
            setAttribute("CHILD_NOs",CHILD_NOs);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction��showCIs.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
	/**
	 * 
	 * @Title: saveMatchResult
	 * @Description: ����ƥ����
	 * @author: xugy
	 * @date: 2014-9-5����10:06:48
	 * @return
	 */
	public String saveMatchResult(){
	    String AFid = getParameter("AFid");//�������ļ�ID
	    String Ins_ADOPT_ORG_ID = getParameter("Ins_ADOPT_ORG_ID");//������֯ID
	    String CIid = getParameter("CIid");//��ͯ����ID
	    String CIids = CIid;
	    try{
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data FUdata = Mhandler.selectMatchStateForUpdate(conn, AFid, CIid);
            String AF_MATCH_STATE = FUdata.getString("AF_MATCH_STATE", "");
            String CI_MATCH_STATE = FUdata.getString("CI_MATCH_STATE", "");
            if(!"1".equals(AF_MATCH_STATE) && !"1".equals(CI_MATCH_STATE)){
                //ͬ����ͯ����
                String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CIid).getString("TWINS_IDS", "");
                if(!"".equals(TWINS_IDS)){
                    String[] childNoArry = TWINS_IDS.split(",");
                    for(int i=0;i<childNoArry.length;i++){
                        String childNo = childNoArry[i];
                        String CI_ID = Mhandler.getCiIdOfChildNo(conn, childNo);
                        CIids = CIids + "," + CI_ID;
                    }
                }
                String[] ciIdArry = CIids.split(",");
                
                for(int i=0;i<ciIdArry.length;i++){
                    Data data = new Data();
                    data.add("MI_ID", "");//ƥ����ϢID
                    data.add("ADOPT_ORG_ID", Ins_ADOPT_ORG_ID);//������֯ID
                    data.add("AF_ID", AFid);//�����ļ�ID
                    data.add("CI_ID", ciIdArry[i]);//��ͯ����ID
                    data.add("CHILD_TYPE", "1");//��ͯ����
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//ƥ����ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//ƥ��������
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//ƥ������
                    data.add("MATCH_STATE", "0");//ƥ��״̬
                    //����ƥ����
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                    //����һ��ƥ����˼�¼��Ϣ
                    Data MAdata = new Data();//ƥ����˼�¼����
                    MAdata.add("MAU_ID", "");//ƥ����˼�¼ID
                    MAdata.add("MI_ID", MI_ID);//ƥ����ϢID
                    MAdata.add("AUDIT_LEVEL", "0");//��˼��𣺾��������
                    MAdata.add("OPERATION_STATE", "0");//����״̬��������
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //��ѯ��ͯ��Ϣ���Ա���ƥ��������޸Ķ�ͯ��ƥ����Ϣ
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[i]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//��ͯƥ�������һ
                    Data CIStateData = new Data();//��ͯƥ������
                    CIStateData.add("CI_ID", ciIdArry[i]);//��ͯ����ID
                    CIStateData.add("MATCH_NUM", ci_num);//��ͯ����ƥ�����
                    CIStateData.add("MATCH_STATE", "1");//��ͯ����ƥ��״̬
                    //����ȫ��״̬��λ��
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //��ѯ��������Ϣ���Ա���ƥ��������޸������˵�ƥ����Ϣ
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//������ƥ�������һ
                Data AFStateData = new Data();//������ƥ������
                AFStateData.add("AF_ID", AFid);//�������ļ�ID
                AFStateData.add("MATCH_NUM", af_num);//������ƥ�����
                AFStateData.add("MATCH_STATE", "1");//������ƥ��״̬
                AFStateData.add("CI_ID", CIid);//��ͯ����ID
                
                if(ciIdArry.length>1){//���ƥ���ͯ���ˣ��޸��������ļ���Ӧ�ɽ������״̬
                    int num = ciIdArry.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "ZCWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//������Ӧ�ɽ��
                        AFStateData.add("AF_COST_CLEAR", "0");//���������״̬
                    }
                    
                }
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_ZCYW_PP_SUBMIT);
                AFStateData.addData(data);
                
                AFhandler.modifyFileInfo(conn, AFStateData);//�޸��ļ���Ϣ
                
                String result = "0";
                setAttribute("result", result);
            }else{
                String result = "2";
                setAttribute("result", result);
            }
            
            dt.commit();
	    }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            //InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
            String result = "2";
            setAttribute("result", result);
            //retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            //InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            //setAttribute("clueTo", clueTo);
            String result = "2";
            setAttribute("result", result);
            //retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
	}
}
