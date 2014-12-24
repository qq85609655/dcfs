package com.dcfs.ncm;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.common.atttype.AttConstants;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;
/**
 * 
 * @Title: MatchAction.java
 * @Description: ƥ�乫������
 * @Company: 21softech
 * @Created on 2014-10-30 ����10:17:42
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(MatchAction.class);
    private Connection conn = null;
    private MatchHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public MatchAction() {
        this.handler=new MatchHandler();
    }
    
    String HEIFontPath = CommonConfig.getProjectPath() + "/Fonts/SIMHEI.TTF";
    String SONGFontPatn = CommonConfig.getProjectPath() + "/Fonts/SIMSUN.TTC,0";
    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: showCIsInfoInChildNo
     * @Description: ��ͯ��Ϣ�鿴
     * @author: xugy
     * @date: 2014-10-30����10:51:58
     * @return
     */
    public String showCIsInfoInChildNo(){
        String CHILD_NOs = getParameter("CHILD_NOs");//��ͯ��ţ���ͬ���Ķ����ͯ���
        String[] Arry = CHILD_NOs.split(",");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            String InChildNo = "";
            for(int i=0;i<Arry.length;i++){
                String CHILD_NO = Arry[i];
                if(i==0){
                    InChildNo = "'" + CHILD_NO + "'";
                }else{
                    InChildNo = InChildNo + ",'" + CHILD_NO + "'";
                }
            }
            //��ȡ����DataList
            DataList CIdls=handler.getCIInfoInChildNo(conn,InChildNo);
            //�������д��ҳ����ձ���
            setAttribute("CIdls",CIdls);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showCIInfoFirst
     * @Description: ����������ö�ͯ��Ϣ
     * @author: xugy
     * @date: 2014-10-30����1:00:34
     * @return
     */
    public String showCIInfoFirst(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            if(!"".equals(data.getString("BIRTHDAY", ""))){
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String nowYear = DateUtility.getCurrentYear();
                int old = Integer.parseInt(nowYear)-Integer.parseInt(birthdayYear)+1;
                data.add("AGE", old);
            }
            String TWINS_IDS = data.getString("TWINS_IDS","");
            String TWINS_NAMES = "";
            if(!"".equals(TWINS_IDS)){
                String[] array = TWINS_IDS.split(",");
                for(int i=0;i<array.length;i++){
                    Data d = handler.getCIInfoOfChildNo(conn, array[i]);
                    String NAME = d.getString("NAME", "");
                    if(i==0){
                        TWINS_NAMES = NAME;
                    }else{
                        TWINS_NAMES = TWINS_NAMES + ";" + NAME;
                    }
                }
            }
            data.add("TWINS_NAMES", TWINS_NAMES);
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: showCIInfoSign
     * @Description: ǩ��ҳ���ͯ�鿴
     * @author: xugy
     * @date: 2014-12-12����3:52:15
     * @return
     */
    public String showCIInfoSign(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: showCIInfoSecond
     * @Description: ��ͯ��Ϣ��ʾ
     * @author: xugy
     * @date: 2014-11-3����9:22:48
     * @return
     */
    public String showCIInfoSecond(){
        String CI_ID = getParameter("CI_ID");//
        String LANG = getParameter("LANG");//����
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("LANG",LANG);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showCIInfoThird
     * @Description: 
     * @author: xugy
     * @date: 2014-11-15����6:51:36
     * @return
     */
    public String showCIInfoThird(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoFirst
     * @Description: �������������������Ϣ
     * @author: xugy
     * @date: 2014-10-30����1:05:48
     * @return
     */
    public String showAFInfoFirst(){
        String AF_ID = getParameter("AF_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            String nowYear = DateUtility.getCurrentYear();
            //������������
            if(!"".equals(data.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = data.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                data.add("MALE_AGE", maleAge);
            }
            //Ů����������
            if(!"".equals(data.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = data.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                data.add("FEMALE_AGE", femaleAge);
            }
            //��ͥ���ʲ�
            int TOTAL_ASSET = data.getInt("TOTAL_ASSET");
            int TOTAL_DEBT = data.getInt("TOTAL_DEBT");
            data.add("TOTAL_NET_ASSETS", TOTAL_ASSET - TOTAL_DEBT);
            
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoSecond
     * @Description: ��������Ϣ
     * @author: xugy
     * @date: 2014-11-3����9:44:01
     * @return
     */
    public String showAFInfoSecond(){
        String AF_ID = getParameter("AF_ID");//
        String LANG = getParameter("LANG");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            String nowYear = DateUtility.getCurrentYear();
            //������������
            if(!"".equals(data.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = data.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                data.add("MALE_AGE", maleAge);
            }
            //Ů����������
            if(!"".equals(data.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = data.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                data.add("FEMALE_AGE", femaleAge);
            }
            //��ͥ���ʲ�
            int TOTAL_ASSET = data.getInt("TOTAL_ASSET");
            int TOTAL_DEBT = data.getInt("TOTAL_DEBT");
            data.add("TOTAL_NET_ASSETS", TOTAL_ASSET - TOTAL_DEBT);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("LANG",LANG);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoThird
     * @Description: 
     * @author: xugy
     * @date: 2014-11-15����6:54:52
     * @return
     */
    public String showAFInfoThird(){
        String AF_ID = getParameter("AF_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: AdoptionRegistrationApplication
     * @Description: �����Ǽ�������
     * @author: xugy
     * @date: 2014-12-2����3:55:58
     * @return
     */
    public String AdoptionRegistrationApplication(){
        String MI_ID = getParameter("MI_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data=getNcmMatchInfoForAdreg(conn,MI_ID);
            String FAMILY_TYPE = data.getString("FAMILY_TYPE");
            String ADOPTER_SEX = data.getString("ADOPTER_SEX");
            if("1".endsWith(FAMILY_TYPE)){//˫������
                data.put("MALE_MARRY_CONDITION", "�ѻ�");    //������_����״��
                data.put("FEMALE_MARRY_CONDITION", "�ѻ�");  //������_����״��
            }else{
                if("1".equals(ADOPTER_SEX)){//�������Ա�Ϊ��
                    data.put("MALE_MARRY_CONDITION", data.getString("MARRY_CONDITION_NAME")); //������_����״��
                    data.put("FEMALE_MARRY_CONDITION", "");    //������_����״��
                }else{
                    data.put("FEMALE_MARRY_CONDITION", data.getString("MARRY_CONDITION_NAME"));   //������_����״��
                    data.put("MALE_MARRY_CONDITION", "");  //������_����״��
                }           
            }
            Integer TOTAL_RESULT = data.getInt("TOTAL_ASSET") - data.getInt("TOTAL_DEBT");
            data.put("TOTAL_RESULT", TOTAL_RESULT.toString());  //������_���ʲ�
            
            if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(data.getString("CHILD_TYPE"))){//������ͯ
                data.put("SN_TYPE_NAME", "����");   //�� �� ״ ��
            }
            
            //�������д��ҳ����ձ���
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: AdoptionRegistration
     * @Description: �����Ǽ�֤
     * @author: xugy
     * @date: 2014-12-3����1:46:08
     * @return
     */
    public String AdoptionRegistration(){
        String MI_ID = getParameter("MI_ID");//
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data=getNcmMatchInfoForAdregCard(conn,MI_ID);
            Data data1=getIntercountryAdoptionInfo(conn,MI_ID);
            data.addData(data1);
            
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            
            String ADVICE_NOTICE_DATE = data.getDate("ADVICE_NOTICE_DATE");    //�������_֪ͨ����
            if(!"".equals(ADVICE_NOTICE_DATE) && ADVICE_NOTICE_DATE.length()>=10 ){
                data.add("ADVICE_NOTICE_DATE_YEAR", ADVICE_NOTICE_DATE.substring(0,4));
                data.add("ADVICE_NOTICE_DATE_MONTH", ADVICE_NOTICE_DATE.substring(5,7));
                data.add("ADVICE_NOTICE_DATE_DAY", ADVICE_NOTICE_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADVICE_NOTICE_DATE);
                data.put("ADVICE_NOTICE_DATE", sdfEN.format(date));
            }
            
            String ADVICE_FEEDBACK_DATE = data.getDate("ADVICE_FEEDBACK_DATE");  //����������ǩ������
            if(!"".equals(ADVICE_FEEDBACK_DATE) && ADVICE_FEEDBACK_DATE.length()>=10 ){
                data.add("ADVICE_FEEDBACK_DATE_YEAR", ADVICE_FEEDBACK_DATE.substring(0,4));
                data.add("ADVICE_FEEDBACK_DATE_MONTH", ADVICE_FEEDBACK_DATE.substring(5,7));
                data.add("ADVICE_FEEDBACK_DATE_DAY", ADVICE_FEEDBACK_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADVICE_FEEDBACK_DATE);
                data.put("ADVICE_FEEDBACK_DATE", sdfEN.format(date));
            }
            
            String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");    //ǩ������
            if(!"".equals(NOTICE_SIGN_DATE) && NOTICE_SIGN_DATE.length()>=10 ){
                data.add("NOTICE_SIGN_DATE_YEAR", NOTICE_SIGN_DATE.substring(0,4));
                data.add("NOTICE_SIGN_DATE_MONTH", NOTICE_SIGN_DATE.substring(5,7));
                data.add("NOTICE_SIGN_DATE_DAY", NOTICE_SIGN_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(NOTICE_SIGN_DATE);
                data.put("NOTICE_SIGN_DATE", sdfEN.format(date));
            }
            
            String ADREG_DATE = data.getDate("ADREG_DATE"); //�����Ǽ�����
            if(!"".equals(ADREG_DATE) && ADREG_DATE.length()>=10 ){
                data.add("ADREG_DATE_YEAR", ADREG_DATE.substring(0,4));
                data.add("ADREG_DATE_MONTH", ADREG_DATE.substring(5,7));
                data.add("ADREG_DATE_DAY", ADREG_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADREG_DATE);
                data.put("ADREG_DATE", sdfEN.format(date));
            }
            //�������д��ҳ����ձ���
            setAttribute("data",data);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            //�ر����ݿ�����
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
    /**
     * 
     * @Title: getNcmMatchInfoForAdreg
     * @Description: �����Ǽ�������
     * @author: xugy
     * @date: 2014-11-10����1:49:35
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmMatchInfoForAdreg(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getNcmMatchInfoForAdreg(conn,MI_ID);
        return data;
    }
    
    /**
     * 
     * @Title: getNcmMatchInfoForAdregCard
     * @Description: �����Ǽ�֤
     * @author: xugy
     * @date: 2014-11-10����1:48:44
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmMatchInfoForAdregCard(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getNcmMatchInfoForAdregCard(conn,MI_ID);
        return data;
    }
    
    /**
     * 
     * @Title: letterOfSeekingConfirmation
     * @Description: ���������
     * @author: xugy
     * @param MI_IDƥ����ϢID
     * @param isSY �Ƿ��ˮӡ0��no��1��yes
     * @throws Exception 
     * @throws FileNotFoundException 
     * @date: 2014-11-9����7:15:42
     */
    public void letterOfSeekingConfirmation(Connection conn, String MI_ID, String isSY) throws Exception{
        
        Data data = handler.getLetterInfo(conn, MI_ID);
        System.out.println(CommonConfig.getProjectPath());
        //ʵ�����ĵ�����  
        Document document = new Document(PageSize.A4, 84, 85, 92, 50);//A4ֽ���������¿հ�
        String path = CommonConfig.getProjectPath() + "/tempFile/";//��ʱ�������������·��
        String FILE_NO = data.getString("FILE_NO");
        String PDFpath = path+FILE_NO+".pdf";//����ļ�·��
        
        // PdfWriter����
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
        float width = document.getPageSize().getWidth() - 169;
        document.open();// ���ĵ�
        //pdf�ĵ���������������ã�ע��һ��Ҫ���iTextAsian.jar��
        //��������
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//��ͨ����
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
        
        //���� ����
        Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//���� 11 ����
        Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//���� 12 ����
        Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//���� 16 ����
        
        //���� ����
        
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//���� 9 ����
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//���� 9.5 ����
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//���� 10 ����
        Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//���� 10.5 ����
        Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//���� 11 ����
        Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
        Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//���� 12.5 ����
        
        //���� ����
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//���� 10.5 ����
        Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//���� 11 ����
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//���� 12 ����
        
        //���� б��
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//���� 10 б��
        
        
        //��������
        //times new Roman ����
        //Font FontEN_T9_5N = new Font(Font.TIMES_ROMAN, 9.5f, Font.NORMAL);//times new roman 9.5 ����
        Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 ����
        Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 ����
        Font FontEN_T11_5N = new Font(Font.TIMES_ROMAN, 11.5F, Font.NORMAL);//times new roman 11.5 ����
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 ����
        
        //times new Roman ����
        Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 ����
        Font FontEN_T10_5B = new Font(Font.TIMES_ROMAN, 10.5f, Font.BOLD);//times new roman 10.5 ����
        Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 ����
        Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 ����
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 ����
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 ����
        
        //times new Roman б��
        Font FontEN_T10I = new Font(Font.TIMES_ROMAN, 10, Font.ITALIC);//times new roman 10 б��
        Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 б��
        
        //���ı���
        Paragraph ParagraphTitleCN = new Paragraph("�� �� �� �� �� �� �� ��", FontCN_HEI16B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        //Ӣ�ı���
        Paragraph ParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation from Adopter", FontEN_T14B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleEN.setSpacingAfter(4);
        document.add(ParagraphTitleEN);
        //�ļ����
        Paragraph ParagraphFileCode = new Paragraph(FILE_NO+"   ", FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingAfter(5);
        document.add(ParagraphFileCode);
        //�����˳ƺ�
        String MALE_NAME = data.getString("MALE_NAME","");//��������
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//Ů������
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME, FontEN_T12N);
            document.add(ParagraphMaleName);
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            ParagraphFemaleName.setSpacingAfter(10);//���¶����
            document.add(ParagraphFemaleName);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME+":", FontEN_T12N);
            ParagraphMaleName.setSpacingAfter(10);//���¶����
            document.add(ParagraphMaleName);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            ParagraphFemaleName.setSpacingAfter(10);//���¶����
            document.add(ParagraphFemaleName);
        }
        //��������
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//��������
        Phrase PhraseContextCN1 = new Phrase("�������ǵ��������뼰���л����񹲺͹����������Ĺ涨���й���ͯ��������������Ϊ����ѡ����һ����ͯ���ֽ��й�����ת����������������뽫�Ƿ�ͬ�����������ǩ���������ʵ���λ�ã�����������齻����Ϊ���ǵݽ������ļ��Ļ���", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN1);
        String NAME_CN = data.getString("NAME_CN");//������֯
        Phrase PhraseContextCN2 = new Phrase(NAME_CN+"��", FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN2);
        ParagraphContextCN.setLeading(15f);
        ParagraphContextCN.setSpacingAfter(10);//���¶����
        document.add(ParagraphContextCN);
        //Ӣ������
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//��������
        Phrase PhraseContextEN1 = new Phrase("Based on your application and in accordance with the ", FontEN_T10N);
        ParagraphContextEN.add(PhraseContextEN1);
        Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China,", FontEN_T10I);
        ParagraphContextEN.add(PhraseContextEN2);
        Phrase PhraseContextEN3 = new Phrase("the China Center for Children's welfare and Adoption ", FontEN_T10B);
        ParagraphContextEN.add(PhraseContextEN3);
        Phrase PhraseContextEN4 = new Phrase("matched a child with you��Herein.we send the information about the child to you.You are kindly requested to make you decision.sign in the proper place below.and deliver this letter as soon as possible to the adoption organization which submitted your application file,", FontEN_T10N);
        ParagraphContextEN.add(PhraseContextEN4);
        String NAME_EN = data.getString("NAME_EN");//������֯
        Phrase PhraseContextEN5 = new Phrase(NAME_EN+".", FontEN_T10B);
        ParagraphContextEN.add(PhraseContextEN5);
        ParagraphContextEN.setLeading(14f);
        ParagraphContextEN.setSpacingAfter(25);//���¶����
        document.add(ParagraphContextEN);
        
        //���Ķ�ͯ��Ϣ
        //��һ����Ϣ
        float[] widths1 = {0.13f,0.30f,0.25f,0.32f};//��������ͱ���
        PdfPTable Table1 = new PdfPTable(widths1);//�������
        Table1.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table1_cell1 = new PdfPCell(new Paragraph("�������ˣ�", FontCN_SONG10N));
        Table1_cell1.setBorderWidth(0);//cell��borderΪ0
        Table1_cell1.setLeading(2f, 1f);
        Table1.addCell(Table1_cell1);
        //�ڶ���cell
        String NAME = data.getString("NAME");//��ͯ����
        PdfPCell Table1_cell2 = new PdfPCell(new Paragraph("������"+NAME, FontCN_SONG10N));
        Table1_cell2.setBorderWidth(0);//cell��borderΪ0
        Table1_cell2.setLeading(2f, 1f);
        Table1.addCell(Table1_cell2);
        //������cell
        String SEX_CN = data.getString("SEX_CN");//�Ա�
        PdfPCell Table1_cell3 = new PdfPCell(new Paragraph("�Ա�"+SEX_CN, FontCN_SONG10N));
        Table1_cell3.setBorderWidth(0);
        Table1_cell3.setLeading(2f, 1f);
        Table1.addCell(Table1_cell3);
        //���ĸ�cell
        String BIRTHDAY = data.getDate("BIRTHDAY");//��ͯ��������
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(BIRTHDAY);
        SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy��MM��dd��");
        String BIRTHDAY_CN = sdfCN.format(date);
        PdfPCell Table1_cell4 = new PdfPCell(new Paragraph("�������ڣ�"+BIRTHDAY_CN, FontCN_SONG10N));
        Table1_cell4.setBorderWidth(0);
        Table1_cell4.setLeading(2f, 1f);
        Table1.addCell(Table1_cell4);
        document.add(Table1);
        //�ڶ�����Ϣ
        float[] widths2 = {0.13f,0.13f,0.74f};//��������ͱ���
        PdfPTable Table2 = new PdfPTable(widths2);//�������
        Table2.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table2_cell1 = new PdfPCell();
        Table2_cell1.setBorderWidth(0);//cell��borderΪ0
        Table2_cell1.setLeading(2f, 1f);
        Table2.addCell(Table2_cell1);
        //�ڶ���cell
        PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("����״����", FontCN_SONG10N));
        Table2_cell2.setBorderWidth(0);//cell��borderΪ0
        Table2_cell2.setLeading(2f, 1f);
        Table2.addCell(Table2_cell2);
        //������cell
        String CHILD_TYPE = data.getString("CHILD_TYPE");//��ͯ����
        String HEALTH_STATUS_CN = "";
        if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)){
            HEALTH_STATUS_CN = data.getString("CHILD_TYPE_CN");
        }else{
            HEALTH_STATUS_CN = data.getString("SN_TYPE_CN");
        }
        PdfPCell Table2_cell3 = new PdfPCell(new Paragraph(HEALTH_STATUS_CN, FontCN_SONG10N));
        Table2_cell3.setBorderWidth(0);
        Table2_cell3.setLeading(2f, 1f);
        Table2.addCell(Table2_cell3);
        document.add(Table2);
        //��������Ϣ
        float[] widths3 = {0.13f,0.08f,0.79f};//��������ͱ���
        PdfPTable Table3 = new PdfPTable(widths3);//�������
        Table3.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table3_cell1 = new PdfPCell();
        Table3_cell1.setBorderWidth(0);//cell��borderΪ0
        Table3_cell1.setLeading(2f, 1f);
        Table3.addCell(Table3_cell1);
        //�ڶ���cell
        PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("��ݣ�", FontCN_SONG10N));
        Table3_cell2.setBorderWidth(0);//cell��borderΪ0
        Table3_cell2.setLeading(2f, 1f);
        Table3.addCell(Table3_cell2);
        //������cell
        String CHILD_IDENTITY_CN = data.getString("CHILD_IDENTITY_CN");//��ͯ���
        PdfPCell Table3_cell3 = new PdfPCell(new Paragraph(CHILD_IDENTITY_CN, FontCN_SONG10N));
        Table3_cell3.setBorderWidth(0);
        Table3_cell3.setLeading(2f, 1f);
        Table3.addCell(Table3_cell3);
        document.add(Table3);
        
        //Ӣ�Ķ�ͯ��Ϣ
        //��һ����Ϣ
        PdfPTable Table4 = new PdfPTable(widths1);//�������
        Table4.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table4_cell1 = new PdfPCell(new Paragraph("Adoptee:", FontEN_T10B));
        Table4_cell1.setBorderWidth(0);//cell��borderΪ0
        Table4_cell1.setLeading(2f, 1f);
        Table4.addCell(Table4_cell1);
        //�ڶ���cell
        Paragraph Paragraph_name = new Paragraph();
        Phrase Phrase_N = new Phrase("Name:", FontEN_T10B);
        Paragraph_name.add(Phrase_N);
        String NAME_PINYIN = data.getString("NAME_PINYIN");//��ͯ����ƴ��
        Phrase Phrase_Name = new Phrase(NAME_PINYIN, FontEN_T10N);
        Paragraph_name.add(Phrase_Name);
        PdfPCell Table4_cell2 = new PdfPCell(Paragraph_name);
        Table4_cell2.setBorderWidth(0);//cell��borderΪ0
        Table4_cell2.setLeading(2f, 1f);
        Table4.addCell(Table4_cell2);
        //������cell
        Paragraph Paragraph_sex = new Paragraph();
        Phrase Phrase_S = new Phrase("Sex:", FontEN_T10B);
        Paragraph_sex.add(Phrase_S);
        String SEX_EN = data.getString("SEX_EN");//�Ա�
        Phrase Phrase_Sex = new Phrase(SEX_EN, FontEN_T10N);
        Paragraph_sex.add(Phrase_Sex);
        PdfPCell Table4_cell3 = new PdfPCell(Paragraph_sex);
        Table4_cell3.setBorderWidth(0);//cell��borderΪ0
        Table4_cell3.setLeading(2f, 1f);
        Table4.addCell(Table4_cell3);
        //���ĸ�cell
        Paragraph Paragraph_birthday = new Paragraph();
        Phrase Phrase_B = new Phrase("Date of birth:", FontEN_T10B);
        Paragraph_birthday.add(Phrase_B);
        SimpleDateFormat sdfEN = new SimpleDateFormat("yyyy/MM/dd");
        //SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
        String BIRTHDAY_EN = sdfEN.format(date);
        
        
        
        Phrase Phrase_birthday = new Phrase(BIRTHDAY_EN, FontEN_T10N);
        Paragraph_birthday.add(Phrase_birthday);
        PdfPCell Table4_cell4 = new PdfPCell(Paragraph_birthday);
        Table4_cell4.setBorderWidth(0);//cell��borderΪ0
        Table4_cell4.setLeading(2f, 1f);
        Table4.addCell(Table4_cell4);
        document.add(Table4);
        //�ڶ�����Ϣ
        float[] widths5 = {0.13f,0.18f,0.69f};//��������ͱ���
        PdfPTable Table5 = new PdfPTable(widths5);//�������
        Table5.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table5_cell1 = new PdfPCell();
        Table5_cell1.setBorderWidth(0);//cell��borderΪ0
        Table5_cell1.setLeading(2f, 1f);
        Table5.addCell(Table5_cell1);
        //�ڶ���cell
        PdfPCell Table5_cell2 = new PdfPCell(new Paragraph("Health Status:", FontEN_T10B));
        Table5_cell2.setBorderWidth(0);//cell��borderΪ0
        Table5_cell2.setLeading(2f, 1f);
        Table5.addCell(Table5_cell2);
        //������cell
        String HEALTH_STATUS_EN = "";
        if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)){
            HEALTH_STATUS_EN = data.getString("CHILD_TYPE_EN");
        }else{
            HEALTH_STATUS_EN = data.getString("SN_TYPE_EN");
        }
        PdfPCell Table5_cell3 = new PdfPCell(new Paragraph(HEALTH_STATUS_EN, FontEN_T10N));
        Table5_cell3.setBorderWidth(0);
        Table5_cell3.setLeading(2f, 1f);
        Table5.addCell(Table5_cell3);
        document.add(Table5);
        //��������Ϣ
        float[] widths6 = {0.13f,0.12f,0.75f};//��������ͱ���
        PdfPTable Table6 = new PdfPTable(widths6);//�������
        Table6.setWidthPercentage(100);//��񳤶�100%
        //��һ��cell
        PdfPCell Table6_cell1 = new PdfPCell();
        Table6_cell1.setBorderWidth(0);//cell��borderΪ0
        Table6_cell1.setLeading(2f, 1f);
        Table6.addCell(Table6_cell1);
        //�ڶ���cell
        PdfPCell Table6_cell2 = new PdfPCell(new Paragraph("Identity:", FontEN_T10B));
        Table6_cell2.setBorderWidth(0);//cell��borderΪ0
        Table6_cell2.setLeading(2f, 1f);
        Table6.addCell(Table6_cell2);
        //������cell
        String CHILD_IDENTITY_EN = data.getString("CHILD_IDENTITY_EN");//��ͯ���
        Paragraph Paragraph_identityEN = new Paragraph(CHILD_IDENTITY_EN, FontEN_T10N);
        PdfPCell Table6_cell3 = new PdfPCell(Paragraph_identityEN);
        Table6_cell3.setBorderWidth(0);
        Table6_cell3.setLeading(2f, 1f);
        Table6.addCell(Table6_cell3);
        document.add(Table6);
        
        //����������
        PdfPTable Table7 = new PdfPTable(1);//�������
        Table7.setWidthPercentage(100);//��񳤶�100%
        String SENDER = data.getString("SENDER","");//������
        PdfPCell Table7_cell1 = new PdfPCell(new Paragraph("���������������ƣ���"+SENDER, FontCN_SONG10N));
        Table7_cell1.setBorderWidth(0);
        Table7_cell1.setLeading(2f, 1f);
        Table7.addCell(Table7_cell1);
        document.add(Table7);
        //������Ӣ��
        float[] widths8 = {0.08f,0.92f};//��������ͱ���
        PdfPTable Table8 = new PdfPTable(widths8);//�������
        Table8.setWidthPercentage(100);//��񳤶�100%
        PdfPCell Table8_cell1 = new PdfPCell(new Paragraph("From:", FontEN_T10B));
        Table8_cell1.setBorderWidth(0);
        Table8_cell1.setLeading(2f, 1f);
        Table8.addCell(Table8_cell1);
        ChildCommonManager ccm = new ChildCommonManager();
        String SENDER_EN = "";
        if(!"".equals(SENDER)){
            SENDER_EN = ccm.getPinyin(SENDER);
        }
        PdfPCell Table8_cell2 = new PdfPCell(new Paragraph(SENDER_EN, FontEN_T10N));
        Table8_cell2.setBorderWidth(0);
        Table8_cell2.setLeading(2f, 1f);
        Table8.addCell(Table8_cell2);
        document.add(Table8);
        
        //���
        float[] widths9 = {0.42f,0.58f};//��������ͱ���
        PdfPTable Table9 = new PdfPTable(widths9);//�������
        Table9.setTotalWidth(width);
        Table9.setLockedWidth(true);
        //��һ��cell
        PdfPCell Table9_cell1 = new PdfPCell(new Paragraph());
        Table9_cell1.setFixedHeight(22f);
        Table9_cell1.setBorder(0);
        Table9.addCell(Table9_cell1);
        //�ڶ���cell
        PdfPCell Table9_cell2 = new PdfPCell(new Paragraph("      �й���ͯ��������������", FontCN_SONG12_5N));
        Table9_cell2.setBorder(0);
        Table9_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell2);
        //������cell
        PdfPCell Table9_cell3 = new PdfPCell(new Paragraph());
        Table9_cell3.setFixedHeight(20f);
        Table9_cell3.setBorder(0);
        Table9.addCell(Table9_cell3);
        //���ĸ�cell
        PdfPCell Table9_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontEN_T11_5N));
        Table9_cell4.setBorder(0);
        Table9_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell4);
        //�����cell
        PdfPCell Table9_cell5 = new PdfPCell(new Paragraph("�����������", FontCN_SONG11B));
        Table9_cell5.setBorder(0);
        Table9.addCell(Table9_cell5);
        //������cell
        String ADVICE_SIGN_DATE = data.getDate("ADVICE_SIGN_DATE");//�������Ĭ������Ϊ�����������ͨ��������MATCH_PASSDATE
        Date adviceSignDate = sdf.parse(ADVICE_SIGN_DATE);
        String inscribeDate = sdfEN.format(adviceSignDate);
        PdfPCell Table9_cell6 = new PdfPCell(new Paragraph("    "+inscribeDate, FontCN_SONG12N));
        Table9_cell6.setBorder(0);
        Table9_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell6);
        Table8.setSpacingAfter(40);
        Table9.writeSelectedRows(0, -1, 84, 290, writer.getDirectContent());
        
        //���������
        float[] widths10 = {0.04f,0.96f};
        PdfPTable Table10 = new PdfPTable(widths10);
        Table10.setTotalWidth(width);
        Table10.setLockedWidth(true);
        //��һ��cell
        PdfPCell Table10_cell1 = new PdfPCell(new Paragraph("Decision of Adopter:", FontEN_T10_5B));
        Table10_cell1.setFixedHeight(16f);
        Table10_cell1.setBorderWidth(0);
        Table10_cell1.setColspan(2);
        Table10.addCell(Table10_cell1);
        //�ڶ���cell
        PdfPCell Table10_cell2 = new PdfPCell(new Paragraph("��", FontCN_SONG10_5N));
        Table10_cell2.setBorderWidth(0);
        Table10.addCell(Table10_cell2);
        //������cell
        PdfPCell Table10_cell3 = new PdfPCell(new Paragraph("����ͬ������������ͯ��", FontCN_SONG10_5N));
        Table10_cell3.setBorderWidth(0);
        Table10.addCell(Table10_cell3);
        //���ĸ�cell
        PdfPCell Table10_cell5 = new PdfPCell(new Paragraph("   We accept the adoptee mentiioned above.", FontEN_T10N));
        Table10_cell5.setColspan(2);
        Table10_cell5.setBorderWidth(0);
        Table10.addCell(Table10_cell5);
        //�����cell
        PdfPCell Table10_cell6 = new PdfPCell(new Paragraph("��", FontCN_SONG10_5N));
        Table10_cell6.setBorderWidth(0);
        Table10.addCell(Table10_cell6);
        //������cell
        PdfPCell Table10_cell7 = new PdfPCell(new Paragraph("���ǲ�ͬ������������ͯ�������ǣ�", FontCN_SONG10_5N));
        Table10_cell7.setBorderWidth(0);
        Table10.addCell(Table10_cell7);
        //���߸�cell
        PdfPCell Table10_cell9 = new PdfPCell(new Paragraph("   We cannot accept the adoptee mentiioned above��the reason is:", FontEN_T10N));
        Table10_cell9.setColspan(2);
        Table10_cell9.setBorderWidth(0);
        Table10.addCell(Table10_cell9);
        Table10.writeSelectedRows(0, -1, 84, 218, writer.getDirectContent());
        
        //������ǩ��
        float[] widths11 = {0.72f,0.28f};
        PdfPTable Table11 = new PdfPTable(widths11);
        Table11.setTotalWidth(width);
        Table11.setLockedWidth(true);
        
        PdfPCell Table11_cell1 = new PdfPCell(new Paragraph("�����˸���ǩ�֣�", FontCN_SONG10B));
        Table11_cell1.setBorderWidth(0);
        Table11_cell1.setColspan(2);
        Table11.addCell(Table11_cell1);
        
        PdfPCell Table11_cell2 = new PdfPCell(new Paragraph("Signature of Adoptive Father:", FontEN_T10B));
        Table11_cell2.setBorderWidth(0);
        Table11.addCell(Table11_cell2);
        
        PdfPCell Table11_cell3 = new PdfPCell(new Paragraph("���ڣ�", FontCN_SONG10B));
        Table11_cell3.setBorderWidth(0);
        Table11.addCell(Table11_cell3);
        
        PdfPCell Table11_cell4 = new PdfPCell(new Paragraph("������ĸ��ǩ�֣�", FontCN_SONG10B));
        Table11_cell4.setBorderWidth(0);
        Table11_cell4.setColspan(2);
        Table11.addCell(Table11_cell4);
        
        PdfPCell Table11_cell5 = new PdfPCell(new Paragraph("Signature of Adoptive Mother:", FontEN_T10B));
        Table11_cell5.setBorderWidth(0);
        Table11.addCell(Table11_cell5);
        
        PdfPCell Table11_cell6 = new PdfPCell(new Paragraph("Date:year/month/date", FontEN_T10B));
        Table11_cell6.setBorderWidth(0);
        Table11.addCell(Table11_cell6);
        Table11.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");
        if("1".equals(IS_CONVENTION_ADOPT)){//��Լ����
            document.newPage();
            //���ı���
            Paragraph SParagraphTitleCN = new Paragraph("�� �� �� �� �� �� ��", FontCN_HEI16B);
            SParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
            document.add(SParagraphTitleCN);
            //Ӣ�ı���
            Paragraph SParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation", FontEN_T14B);
            SParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
            SParagraphTitleEN.setSpacingAfter(4);
            document.add(SParagraphTitleEN);
            //�ļ����
            Paragraph SParagraphFileCode = new Paragraph(FILE_NO+"      ", FontEN_T14B);
            SParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
            SParagraphFileCode.setSpacingAfter(4);
            document.add(SParagraphFileCode);
            //�������������
            Paragraph SParagraphMaleName = new Paragraph("������������أ�", FontCN_HEI12B);
            document.add(SParagraphMaleName);
            Paragraph SParagraphFemaleName = new Paragraph("Central Authority of Receiving State:", FontEN_T12B);
            SParagraphFemaleName.setSpacingAfter(20);//���¶����
            document.add(SParagraphFemaleName);
            //��������
            Paragraph SParagraphContextCN = new Paragraph();
            SParagraphContextCN.setFirstLineIndent(20);//��������
            Phrase SPhraseContextCN1 = new Phrase("���ݡ��л����񹲺͹�����������������������汣����ͯ��������Լ����ʮ�����Ĺ涨���й�����ͯ��������������Ϊ������", FontCN_SONG11N);
            SParagraphContextCN.add(SPhraseContextCN1);
            Phrase SPhraseContextCN2 = new Phrase();
            if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MR. "+MALE_NAME+" & MRS. "+FEMALE_NAME, FontEN_T11B);
            }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MR. "+MALE_NAME, FontEN_T11B);
            }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MRS. "+FEMALE_NAME, FontEN_T11B);
            }
            SParagraphContextCN.add(SPhraseContextCN2);
            Phrase SPhraseContextCN3 = new Phrase("ѡ����һ����ͯ�� "+NAME+"��"+SEX_CN+"��"+BIRTHDAY_CN+"���������溯���ϸö�ͯ����Ƭ�������ɳ����档�뽫���ǵ����ǩ���������ʵ���λ�á�", FontCN_SONG11N);
            SParagraphContextCN.add(SPhraseContextCN3);
            SParagraphContextCN.setSpacingAfter(50);//���¶����
            document.add(SParagraphContextCN);
            //Ӣ������
            Paragraph SParagraphContextEN = new Paragraph();
            SParagraphContextEN.setFirstLineIndent(20);//��������
            Phrase SPhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN1);
            Phrase SPhraseContextEN2 = new Phrase("Adoption law of the People's Republic of China ", FontEN_T11I);
            SParagraphContextEN.add(SPhraseContextEN2);
            Phrase SPhraseContextEN3 = new Phrase("And the Article 17 of the ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN3);
            Phrase SPhraseContextEN4 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption,", FontEN_T11I);
            SParagraphContextEN.add(SPhraseContextEN4);
            Phrase SPhraseContextEN5 = new Phrase("the China Center for Children's welfare and Adoption matched a child(Name:"+NAME_PINYIN+",Sex:"+SEX_EN+",D.O.B:"+BIRTHDAY_EN+")with the adoption applicants ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN5);
            Phrase SPhraseContextEN6 = new Phrase();
            if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MR. "+MALE_NAME+" & MRS. "+FEMALE_NAME, FontEN_T11B);
            }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MR. "+MALE_NAME, FontEN_T11B);
            }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MRS. "+FEMALE_NAME, FontEN_T11B);
            }
            SParagraphContextEN.add(SPhraseContextEN6);
            Phrase SPhraseContextEN7 = new Phrase(".Enclosed please find the pictures,medical examination from,and growth report of the child,Please sign in the proper place underneath to present your opinion.", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN7);
            SParagraphContextEN.setLeading(14f);
            //ParagraphContextEN.setSpacingAfter(25);//���¶����
            document.add(SParagraphContextEN);
            
            //���
            float[] Swidths1 = {0.42f,0.58f};//��������ͱ���
            PdfPTable STable1 = new PdfPTable(Swidths1);//�������
            STable1.setTotalWidth(width);
            STable1.setLockedWidth(true);
            //��һ��cell
            PdfPCell STable1_cell1 = new PdfPCell(new Paragraph());
            STable1_cell1.setFixedHeight(20f);
            STable1_cell1.setBorder(0);
            STable1.addCell(STable1_cell1);
            //�ڶ���cell
            PdfPCell STable1_cell2 = new PdfPCell(new Paragraph("      �й���ͯ��������������", FontCN_SONG12_5N));
            STable1_cell2.setBorder(0);
            STable1_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell2);
            //������cell
            PdfPCell STable1_cell3 = new PdfPCell(new Paragraph());
            STable1_cell3.setFixedHeight(18f);
            STable1_cell3.setBorder(0);
            STable1.addCell(STable1_cell3);
            //���ĸ�cell
            PdfPCell STable1_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontEN_T11_5N));
            STable1_cell4.setBorder(0);
            STable1_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell4);
            //�����cell
            PdfPCell STable1_cell5 = new PdfPCell(new Paragraph());
            STable1_cell5.setBorder(0);
            STable1.addCell(STable1_cell5);
            //������cell
            PdfPCell STable1_cell6 = new PdfPCell(new Paragraph("    "+inscribeDate, FontCN_SONG12N));
            STable1_cell6.setBorder(0);
            STable1_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell6);
            STable1.writeSelectedRows(0, -1, 84, 285, writer.getDirectContent());
            
            //���������
            PdfPTable STable2 = new PdfPTable(1);
            STable2.setTotalWidth(width);
            STable2.setLockedWidth(true);
            //��һ��cell
            PdfPCell STable2_cell1 = new PdfPCell(new Paragraph("������������������", FontCN_HEI10B));
            STable2_cell1.setBorderWidth(0);
            STable2_cell1.setColspan(2);
            STable2.addCell(STable2_cell1);
            //�ڶ���cell
            PdfPCell STable2_cell2 = new PdfPCell(new Paragraph("Opinion of the Central Authority of Receiving State:", FontEN_T10B));
            STable2_cell2.setBorderWidth(0);
            STable2.addCell(STable2_cell2);
            //������cell
            PdfPCell STable2_cell3 = new PdfPCell(new Paragraph("�� ����ͬ���й���ͯ�������������ĸ����ͯ���þ�����", FontCN_SONG10N));
            STable2_cell3.setBorderWidth(0);
            STable2.addCell(STable2_cell3);
            //���ĸ�cell
            PdfPCell STable2_cell5 = new PdfPCell(new Paragraph("   We agree with the decision made by CCCWA.", FontCN_SONG10N));
            STable2_cell5.setColspan(2);
            STable2_cell5.setBorderWidth(0);
            STable2.addCell(STable2_cell5);
            //�����cell
            PdfPCell STable2_cell6 = new PdfPCell(new Paragraph("�� ���ǲ�ͬ���й���ͯ�������������ĸ����ͯ���þ����������ǣ�", FontCN_SONG10N));
            STable2_cell6.setBorderWidth(0);
            STable2.addCell(STable2_cell6);
            //������cell
            PdfPCell STable2_cell7 = new PdfPCell(new Paragraph("   We don't agree with the decision made by CCCWA,the reason is��", FontCN_SONG10_5N));
            STable2_cell7.setBorderWidth(0);
            STable2.addCell(STable2_cell7);
            STable2.writeSelectedRows(0, -1, 84, 230, writer.getDirectContent());
            
            //������ǩ��
            float[] Swidths3 = {0.72f,0.28f};
            PdfPTable STable3 = new PdfPTable(Swidths3);
            STable3.setTotalWidth(width);
            STable3.setLockedWidth(true);
            
            PdfPCell STable3_cell1 = new PdfPCell(new Paragraph("ǩ���ˣ�", FontCN_SONG10B));
            STable3_cell1.setBorderWidth(0);
            STable3_cell1.setColspan(2);
            STable3.addCell(STable3_cell1);
            
            PdfPCell STable3_cell2 = new PdfPCell(new Paragraph("Signature:", FontEN_T10B));
            STable3_cell2.setBorderWidth(0);
            STable3_cell2.setColspan(2);
            STable3.addCell(STable3_cell2);
            
            PdfPCell STable3_cell3 = new PdfPCell(new Paragraph("������������أ�", FontCN_SONG10B));
            STable3_cell3.setBorderWidth(0);
            STable3.addCell(STable3_cell3);
            
            PdfPCell STable3_cell4 = new PdfPCell(new Paragraph("���ڣ�", FontCN_SONG10B));
            STable3_cell4.setBorderWidth(0);
            STable3.addCell(STable3_cell4);
            
            PdfPCell STable3_cell5 = new PdfPCell(new Paragraph("Central Authority of Receiving State:", FontEN_T10B));
            STable3_cell5.setBorderWidth(0);
            STable3.addCell(STable3_cell5);
            
            PdfPCell STable3_cell6 = new PdfPCell(new Paragraph(" Date:year/month/date", FontEN_T10B));
            STable3_cell6.setBorderWidth(0);
            STable3.addCell(STable3_cell6);
            STable3.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
        }
        document.close();
        
        String Outpath = path+FILE_NO+"_SYZZ.pdf";//����ļ�·��
        if("1".equals(isSY)){
            String imagePath = CommonConfig.getProjectPath()+"/resource/images/watermark-grap.png";
            waterMark(PDFpath, Outpath, imagePath);
        }
        File file = new File(PDFpath);//�������֪ͨ��
        if("1".equals(isSY)){
            File file_syzz = new File(Outpath);//�������֪ͨ��
            if (file_syzz.exists()) {
                AttHelper.delAttsOfPackageId(MI_ID, AttConstants.ZQYJSSY, "AF");
                
                AttHelper.manualUploadAtt(file_syzz, "AF", MI_ID, FILE_NO+"_SYZZ.pdf", AttConstants.ZQYJSSY, "AF", AttConstants.ZQYJSSY, MI_ID);
                
                file_syzz.delete();//ɾ��ԭ�����ɵ��������֪ͨ��
            }
        }
        if (file.exists()) {
            AttHelper.delAttsOfPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, FILE_NO+".pdf", AttConstants.ZQYJS, "AF", AttConstants.ZQYJS, MI_ID);
            
            file.delete();//ɾ��ԭ�����ɵ��������֪ͨ��
        }
    }
    
    /**
     * 
     * @Title: getIntercountryAdoptionInfo
     * @Description: ��������ϸ�֤
     * @author: xugy
     * @date: 2014-11-10����1:50:28
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getIntercountryAdoptionInfo(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getIntercountryAdoptionInfo(conn,MI_ID);
        return data;
    }
    
    
    /**
     * 
     * @Title: noticeOfTravellingToChinaForAdoption
     * @Description: ����������Ů֪ͨ��
     * @author: xugy
     * @date: 2014-11-10����9:05:49
     * @param conn
     * @param MI_ID ƥ����ϢID
     * @param isFB ֵ0ʱ֪ͨ�����ɣ�ֵ1ʱ��������
     * @throws Exception
     */
    public void noticeOfTravellingToChinaForAdoption(Connection conn, String MI_ID, String isFB, String isSY) throws Exception{
        
        Data data = handler.getNoticeInfo(conn, MI_ID);
        
        //ʵ�����ĵ�����  
        Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4ֽ���������¿հ�
        String PDFpath = CommonConfig.getProjectPath() + "/tempFile/����������Ů֪ͨ��.pdf";//��ʱ�������������Ů֪ͨ���·��
        
        // PdfWriter����
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
        float width = document.getPageSize().getWidth() - 160;
        document.open();// ���ĵ�
        //pdf�ĵ���������������ã�ע��һ��Ҫ���iTextAsian.jar��
        //��������
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//��ͨ����
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
        //���� ����
        Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//���� 11 ����
        //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//���� 12 ����
        //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//���� 16 ����
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//���� 20 ����
        //���� ����
        //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//���� 7 ����
        
        //���� ����
        //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//���� 8 ����
        Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//���� 8.5 ����
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//���� 9 ����
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//���� 9.5 ����
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//���� 10 ����
        //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//���� 10.5 ����
        //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//���� 11 ����
        //Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
        //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//���� 12.5 ����
        
        //���� ����
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//���� 10.5 ����
        //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//���� 11 ����
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//���� 12 ����
        Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//���� 15 ����
        
        //���� б��
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//���� 10 б��
        
        
        //��������
        //times new Roman ����
        //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 ����
        Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 ����
        //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 ����
        //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 ����
        Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 ����
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 ����
        
        //times new Roman ����
        Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 ����
        Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 ����
        Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 ����
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 ����
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 ����
        
        //times new Roman б��
        Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 б��
        
        //HELVETICA ����
        Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 ����
        //HELVETICA ����
        Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 ����
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");//�Ƿ�Լ
        
        //���ı���
        Paragraph ParagraphTitleCN = new Paragraph("�� �� �� �� �� Ů ͨ ֪ ��", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        //Ӣ�ı���
        Paragraph ParagraphTitleEN = new Paragraph("Notice of Travelling to China for Adoption", FontEN_T12B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        if("0".equals(isFB)){
            ParagraphTitleEN.setSpacingAfter(20);
        }
        document.add(ParagraphTitleEN);
        if("1".equals(isFB)){
            //��������
            Paragraph ParagraphTitleFB = new Paragraph("����    ����", FontCN_SONG15B);
            ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleFB);
        }
        //�ļ����
        String SIGN_NO = data.getString("SIGN_NO");//
        Paragraph ParagraphFileCode = new Paragraph(SIGN_NO, FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingAfter(5);
        document.add(ParagraphFileCode);
        //�����˳ƺ�
        String MALE_NAME = data.getString("MALE_NAME","");//��������
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//Ů������
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME, FontEN_T12N);
            document.add(ParagraphMaleName);
            Paragraph ParagraphFemaleName = new Paragraph("& MRS. "+FEMALE_NAME+":", FontEN_T12N);
            document.add(ParagraphFemaleName);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME+":", FontEN_T12N);
            document.add(ParagraphMaleName);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            document.add(ParagraphFemaleName);
        }
        //��������
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//��������
        Phrase PhraseContextCN1 = new Phrase();
        if("1".equals(IS_CONVENTION_ADOPT)){//��Լ
            PhraseContextCN1 = new Phrase("���ݡ��л����񹲺͹����������͡�����������汣����ͯ��������Լ��������飬ͬ����������", FontCN_SONG10N);
        }else{
            PhraseContextCN1 = new Phrase("���ݡ��л����񹲺͹���������������飬ͬ����������", FontCN_SONG10N);
        }
        ParagraphContextCN.add(PhraseContextCN1);
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN");//����Ժ
        Phrase PhraseContextCN2 = new Phrase(WELFARE_NAME_CN, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN2);
        Phrase PhraseContextCN3 = new Phrase("������", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN3);
        String NAME = data.getString("NAME");//��ͯ����
        Phrase PhraseContextCN4 = new Phrase(NAME, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN4);
        Phrase PhraseContextCN5 = new Phrase("�������ǳֱ�֪ͨ���Ե��й�", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN5);
        String PROVINCE_CN = data.getString("PROVINCE_CN");//ʡ��
        Phrase PhraseContextCN6 = new Phrase(PROVINCE_CN, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN6);
        Phrase PhraseContextCN7 = new Phrase("�����������Ǽǻ��ذ��������Ǽ�������", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN7);
        ParagraphContextCN.setLeading(20f);
        document.add(ParagraphContextCN);
        //Ӣ������
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//��������
        Phrase PhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN1);
        Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China", FontEN_T11I);
        ParagraphContextEN.add(PhraseContextEN2);
        if("1".equals(IS_CONVENTION_ADOPT)){//��Լ
            Phrase PhraseContextEN2GY1 = new Phrase(" and the ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN2GY1);
            
            Phrase PhraseContextEN2GY2 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption", FontEN_T11I);
            ParagraphContextEN.add(PhraseContextEN2GY2);
        }
        Phrase PhraseContextEN3 = new Phrase(",we agreed that the child,", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN3);
        String NAME_PINYIN = data.getString("NAME_PINYIN");//��ͯ����
        Phrase PhraseContextEN4 = new Phrase(NAME_PINYIN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN4);
        Phrase PhraseContextEN5 = new Phrase(",who is in the care of ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN5);
        String WELFARE_NAME_EN = data.getString("WELFARE_NAME_EN");//����Ժ
        Phrase PhraseContextEN6 = new Phrase(WELFARE_NAME_EN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN6);
        Phrase PhraseContextEN7 = new Phrase(",be place with you for adoption.Please travel in person with this notice to the adoption registry office within the Civil Affairs Department of ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN7);
        String PROVINCE_EN = data.getString("PROVINCE_EN");//ʡ��
        Phrase PhraseContextEN8 = new Phrase(PROVINCE_EN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN8);
        Phrase PhraseContextEN9 = new Phrase("in China to proceed the registration formalities.", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN9);
        ParagraphContextEN.setLeading(20f);
        ParagraphContextEN.setSpacingAfter(25);//���¶����
        document.add(ParagraphContextEN);
        
        PdfPTable Table1 = new PdfPTable(2);
        Table1.setTotalWidth(width);
        Table1.setLockedWidth(true);
        
        PdfPCell Table1_cell1 = new PdfPCell();
        Paragraph Paragraph_Adopted = new Paragraph();
        Phrase Phrase_Adopted1 = new Phrase("������������ ", FontCN_SONG10N);
        Paragraph_Adopted.add(Phrase_Adopted1);
        Phrase Phrase_Adopted2 = new Phrase("Name of Adopted Child:", FontEN_H7N);
        Paragraph_Adopted.add(Phrase_Adopted2);
        Table1_cell1.addElement(Paragraph_Adopted);
        //Table1_cell1.setFixedHeight(1f);
        Table1_cell1.setBorder(0);
        Table1.addCell(Table1_cell1);
        
        PdfPCell Table1_cell2 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Father = new Paragraph();
        Phrase Phrase_Adoptive_Father1 = new Phrase("Ԥ������������ ", FontCN_SONG10N);
        Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father1);
        Phrase Phrase_Adoptive_Father2 = new Phrase("Name of Prospective Adoptive Father:", FontEN_H7N);
        Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father2);
        Table1_cell2.addElement(Paragraph_Adoptive_Father);
        Table1_cell2.setBorder(0);
        Table1.addCell(Table1_cell2);
        
        PdfPCell Table1_cell3 = new PdfPCell();
        Table1_cell3.addElement(new Paragraph(NAME, FontCN_SONG10B));
        Table1_cell3.setBorder(0);
        Table1.addCell(Table1_cell3);
        
        PdfPCell Table1_cell4 = new PdfPCell();
        Table1_cell4.addElement(new Paragraph(MALE_NAME, FontEN_H10B));
        Table1_cell4.setBorder(0);
        Table1.addCell(Table1_cell4);
        
        
        PdfPCell Table1_cell5 = new PdfPCell();
        Paragraph Paragraph_Adopted_Sex = new Paragraph();
        Phrase Phrase_Adopted_Sex1 = new Phrase("�Ա� ", FontCN_SONG10N);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex1);
        Phrase Phrase_Adopted_Sex2 = new Phrase("Sex: ", FontEN_H7N);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex2);
        String SEX_CN = data.getString("SEX_CN");//��ͯ�Ա�
        Phrase Phrase_Adopted_Sex3 = new Phrase(SEX_CN, FontCN_SONG10B);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex3);
        Table1_cell5.addElement(Paragraph_Adopted_Sex);
        Table1_cell5.setBorder(0);
        Table1.addCell(Table1_cell5);
        
        
        PdfPCell Table1_cell6 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Father_DOB = new Paragraph();
        Phrase Phrase_Adoptive_Father_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB1);
        Phrase Phrase_Adoptive_Father_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB2);
        String MALE_BIRTHDAY = data.getDate("MALE_BIRTHDAY");//��������
        Phrase Phrase_Adoptive_Father_DOB3 = new Phrase(MALE_BIRTHDAY, FontEN_H10B);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB3);
        Table1_cell6.addElement(Paragraph_Adoptive_Father_DOB);
        Table1_cell6.setBorder(0);
        Table1.addCell(Table1_cell6);
        
        PdfPCell Table1_cell7 = new PdfPCell();
        Paragraph Paragraph_Adopted_DOB = new Paragraph();
        Phrase Phrase_Adoped_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
        Paragraph_Adopted_DOB.add(Phrase_Adoped_DOB1);
        Phrase Phrase_Adopted_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB2);
        String BIRTHDAY = data.getDate("BIRTHDAY");//��ͯ����
        Phrase Phrase_Adopted_DOB3 = new Phrase(BIRTHDAY, FontEN_H10B);
        Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB3);
        Table1_cell7.addElement(Paragraph_Adopted_DOB);
        Table1_cell7.setBorder(0);
        Table1.addCell(Table1_cell7);
        
        PdfPCell Table1_cell8 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Mother = new Paragraph();
        Phrase Phrase_Adoptive_Mother1 = new Phrase("Ԥ����ĸ������ ", FontCN_SONG10N);
        Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother1);
        Phrase Phrase_Adoptive_Mother2 = new Phrase("Name of Prospective Adoptive Mother:", FontEN_H7N);
        Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother2);
        Table1_cell8.addElement(Paragraph_Adoptive_Mother);
        Table1_cell8.setBorder(0);
        Table1.addCell(Table1_cell8);
        
        PdfPCell Table1_cell9 = new PdfPCell();
        Paragraph Paragraph_Adopted_Add = new Paragraph();
        Phrase Phrase_Adopted_Add1 = new Phrase("���ڵ� ", FontCN_SONG10N);
        Paragraph_Adopted_Add.add(Phrase_Adopted_Add1);
        Phrase Phrase_Adopted_Add2 = new Phrase("Residential information(SWI/Address):", FontEN_H7N);
        Paragraph_Adopted_Add.add(Phrase_Adopted_Add2);
        Table1_cell9.addElement(Paragraph_Adopted_Add);
        Table1_cell9.setBorder(0);
        Table1.addCell(Table1_cell9);
        
        PdfPCell Table1_cell10 = new PdfPCell();
        Table1_cell10.addElement(new Paragraph(FEMALE_NAME, FontEN_H10B));
        Table1_cell10.setBorder(0);
        Table1.addCell(Table1_cell10);
        
        PdfPCell Table1_cell11 = new PdfPCell();
        Table1_cell11.addElement(new Paragraph(WELFARE_NAME_CN, FontCN_SONG10B));
        Table1_cell11.setBorder(0);
        Table1.addCell(Table1_cell11);
        
        PdfPCell Table1_cell12 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Mother_DOB = new Paragraph();
        Phrase Phrase_Adoptive_Mother_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB1);
        Phrase Phrase_Adoptive_Mother_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB2);
        String FEMALE_BIRTHDAY = data.getDate("FEMALE_BIRTHDAY");//ĸ������
        Phrase Phrase_Adoptive_Mother_DOB3 = new Phrase(FEMALE_BIRTHDAY, FontEN_H10B);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB3);
        Table1_cell12.addElement(Paragraph_Adoptive_Mother_DOB);
        Table1_cell12.setBorder(0);
        Table1.addCell(Table1_cell12);
        Table1.writeSelectedRows(0, -1, 80, 420, writer.getDirectContent());
        
        String CI_ID = data.getString("CI_ID");
        String photoPath = handler.getPhotoPath(conn, CI_ID);
        if(!"".equals(photoPath)){
            File file = new File(photoPath);//
            if (file.exists()) {
                Image photograph = Image.getInstance(photoPath);
                photograph.setAbsolutePosition(95, 160);
                photograph.scaleAbsolute(72f, 100f);
                document.add(photograph);
            }
        }
        
        PdfPTable Table2 = new PdfPTable(1);
        Table2.setTotalWidth(width-190);
        Table2.setLockedWidth(true);
        
        PdfPCell Table2_cell1 = new PdfPCell(new Paragraph("  �й���ͯ��������������", FontCN_SONG15B));
        Table2_cell1.setBorder(0);
        Table2_cell1.setFixedHeight(25f);
        Table2_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell1);
        
        PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("China Center for Children's Welfare and Adoption", FontEN_T10B));
        Table2_cell2.setBorder(0);
        Table2_cell2.setFixedHeight(18f);
        Table2_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell2);
        String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!"".equals(NOTICE_SIGN_DATE)){
            Date date = sdf.parse(NOTICE_SIGN_DATE);
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy��MM��dd��");
            NOTICE_SIGN_DATE = sdfCN.format(date);
        }
        PdfPCell Table2_cell3 = new PdfPCell(new Paragraph(NOTICE_SIGN_DATE, FontCN_SONG10N));
        Table2_cell3.setBorder(0);
        Table2_cell3.setFixedHeight(18f);
        Table2_cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell3);
        
        PdfPCell Table2_cell4 = new PdfPCell(new Paragraph("��ַ���й������ж���������԰��ͬ16��", FontCN_SONG8_5N));
        Table2_cell4.setBorder(0);
        Table2_cell4.setFixedHeight(18f);
        Table2_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell4);
        
        PdfPCell Table2_cell5 = new PdfPCell(new Paragraph("Address: No.16,Wangjiayuan Lane,Dongcheng District,Beijing,China", FontEN_T8_5N));
        Table2_cell5.setBorder(0);
        Table2_cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell5);
        
        Table2.writeSelectedRows(0, -1, 275, 250, writer.getDirectContent());
        
        PdfPTable Table3 = new PdfPTable(1);
        Table3.setTotalWidth(width);
        Table3.setLockedWidth(true);
        
        PdfPCell Table3_cell1 = new PdfPCell(new Paragraph("ע����֪ͨ����ǩ��֮��������������Ч��", FontCN_HEI10B));
        Table3_cell1.setFixedHeight(18f);
        Table3_cell1.setBorder(0);
        Table3.addCell(Table3_cell1);
        
        PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("Note:This Notice is valid within three months from the date of issuance.", FontEN_H10B));
        Table3_cell2.setBorder(0);
        Table3.addCell(Table3_cell2);
        if("1".equals(isFB)){
            String ARCHIVE_NO = data.getString("ARCHIVE_NO");//������
            PdfPCell Table3_cell3 = new PdfPCell(new Paragraph(ARCHIVE_NO, FontEN_H10B));
            Table3_cell3.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Table3_cell3.setBorder(0);
            Table3.addCell(Table3_cell3);
        }
        Table3.writeSelectedRows(0, -1, 80, 130, writer.getDirectContent());
        document.close();
        
        File file = new File(PDFpath);//����������Ů֪ͨ��
        if (file.exists()) {
            String smallType = "";
            if("0".equals(isFB)){
                String Outpath = CommonConfig.getProjectPath() + "/tempFile/����������Ů֪ͨ��_SYZZ.pdf";//����ļ�·��
                if("1".equals(isSY)){
                    String imagePath = CommonConfig.getProjectPath()+"/resource/images/watermark-grap.png";
                    waterMark(PDFpath, Outpath, imagePath);
                }
                File file_syzz = new File(Outpath);
                if(file_syzz.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.LHSYZNTZSSY, "AF");//ɾ��ԭ����
                    AttHelper.manualUploadAtt(file_syzz, "AF", MI_ID, "����������Ů֪ͨ��_SYZZ.pdf", AttConstants.LHSYZNTZSSY, "AF", AttConstants.LHSYZNTZSSY, MI_ID);
                    file_syzz.delete();//ɾ��ԭ�����ɵ�����������Ů֪ͨ��
                }
                
                smallType = AttConstants.LHSYZNTZS;//����������Ů֪ͨ��
            }else{
                smallType = AttConstants.LHSYZNTZSFB;//����������Ů֪ͨ�鸱��
            }
            AttHelper.delAttsOfPackageId(MI_ID, smallType, "AF");//ɾ��ԭ����
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, "����������Ů֪ͨ��.pdf", smallType, "AF", smallType, MI_ID);
            file.delete();//ɾ��ԭ�����ɵ�����������Ů֪ͨ��
        }
    }
    /**
     * 
     * @Title: noticeForAdoption
     * @Description: ��������֪ͨ
     * @author: xugy
     * @date: 2014-11-10����8:56:10
     * @param conn
     * @param MI_ID ƥ����ϢID
     * @param isFB ֵ0ʱ֪ͨ�����ɣ�ֵ1ʱ��������
     * @throws Exception
     */
    public void noticeForAdoption(Connection conn, String MI_ID, String isFB) throws Exception{

        Data data = handler.getNoticeInfo(conn, MI_ID);
        
        //ʵ�����ĵ�����  
        Document document = new Document(PageSize.A4, 140, 140, 100, 50);//A4ֽ���������¿հ�
        String PDFpath = CommonConfig.getProjectPath() + "/tempFile/��������֪ͨ.pdf";//��ʱ�����������֪ͨ��·��
        
        // PdfWriter����
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
        float width = document.getPageSize().getWidth() - 280;
        document.open();// ���ĵ�
        //pdf�ĵ���������������ã�ע��һ��Ҫ���iTextAsian.jar��
        //��������
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//��ͨ����
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
        
        //���� ����
        //Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//���� 11 ����
        //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//���� 12 ����
        //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//���� 16 ����
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//���� 20 ����
        //���� ����
        //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//���� 7 ����
        
        //���� ����
        //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//���� 8 ����
        //Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//���� 8.5 ����
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//���� 9 ����
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//���� 9.5 ����
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//���� 10 ����
        //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//���� 10.5 ����
        //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//���� 11 ����
        //Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
        //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//���� 12.5 ����
        
        //���� ����
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//���� 10 ����
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//���� 10.5 ����
        //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//���� 11 ����
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//���� 12 ����
        Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//���� 15 ����
        
        //���� б��
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//���� 10 б��
        
        
        //��������
        //times new Roman ����
        //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 ����
        //Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 ����
        //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 ����
        //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 ����
        //Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 ����
        //Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 ����
        
        //times new Roman ����
        //Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 ����
        //Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 ����
        //Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 ����
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 ����
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 ����
        
        //times new Roman б��
        //Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 б��
        
        //HELVETICA ����
        //Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 ����
        //HELVETICA ����
        Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 ����
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");//�Ƿ�Լ
        
        //���ı���
        Paragraph ParagraphTitleCN = new Paragraph("�� �� �� �� ͨ ֪", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        if("1".equals(isFB)){
            //��������
            Paragraph ParagraphTitleFB = new Paragraph("����    ����", FontCN_SONG15B);
            ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleFB);
        }
        //�ļ����
        String SIGN_NO = data.getString("SIGN_NO");
        Paragraph ParagraphFileCode = new Paragraph(SIGN_NO, FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingBefore(40);
        ParagraphFileCode.setSpacingAfter(40);
        document.add(ParagraphFileCode);
        //������
        String ADREG_ORG_CN = data.getString("ADREG_ORG_CN");
        Paragraph ParagraphMZT = new Paragraph(ADREG_ORG_CN+":", FontCN_SONG10B);
        document.add(ParagraphMZT);
        //��������
        Paragraph ParagraphContext = new Paragraph();
        ParagraphContext.setFirstLineIndent(20);//��������
        ParagraphContext.setLeading(22f);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy��MM��dd��");
        String MALE_NAME = data.getString("MALE_NAME","");//
        String MALE_NATION_NAME = data.getString("MALE_NATION_NAME");//
        String MALE_BIRTHDAY = data.getString("MALE_BIRTHDAY","");//
        if(!"".equals(MALE_BIRTHDAY)){
            Date date1 = sdf.parse(MALE_BIRTHDAY);
            MALE_BIRTHDAY = sdfCN.format(date1);
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//
        String FEMALE_NATION_NAME = data.getString("FEMALE_NATION_NAME");//
        String FEMALE_BIRTHDAY = data.getString("FEMALE_BIRTHDAY","");//
        if(!"".equals(FEMALE_BIRTHDAY)){
            Date date2 = sdf.parse(FEMALE_BIRTHDAY);
            FEMALE_BIRTHDAY = sdfCN.format(date2);
        }
        Phrase PhraseContext1 = new Phrase();
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("����飬������MR."+MALE_NAME+"��"+MALE_NATION_NAME+"������"+MALE_BIRTHDAY+"��������MRS."+FEMALE_NAME+"��"+FEMALE_NATION_NAME+"������"+FEMALE_BIRTHDAY+"���������ϡ��л����񹲺͹���������", FontCN_SONG10N);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("����飬������MR."+MALE_NAME+"��"+MALE_NATION_NAME+"������"+MALE_BIRTHDAY+"���������ϡ��л����񹲺͹���������", FontCN_SONG10N);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("����飬������MRS."+FEMALE_NAME+"��"+FEMALE_NATION_NAME+"������"+FEMALE_BIRTHDAY+"���������ϡ��л����񹲺͹���������", FontCN_SONG10N);
        }
        ParagraphContext.add(PhraseContext1);
        if("1".equals(IS_CONVENTION_ADOPT)){//��Լ
            Phrase PhraseContext2 = new Phrase("�͡�����������汣����ͯ��������Լ��", FontCN_SONG10N);
            ParagraphContext.add(PhraseContext2);
        }
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN");
        String NAME = data.getString("NAME");
        String SEX_CN = data.getString("SEX_CN");
        String BIRTHDAY = data.getString("BIRTHDAY");
        Date date3 = sdf.parse(BIRTHDAY);
        BIRTHDAY = sdfCN.format(date3);
        Phrase PhraseContext3 = new Phrase("���йط��ɹ涨�����������������������������ͬ������"+WELFARE_NAME_CN+"������"+NAME+"��"+SEX_CN+"��"+BIRTHDAY+"���������й���ͯ����Ժ��������������������ǩ������������Ů֪ͨ�飬��֪ͨ���������ð��������Ǽ�������׼��������", FontCN_SONG10N);
        ParagraphContext.add(PhraseContext3);
        ParagraphContext.setSpacingAfter(20);
        document.add(ParagraphContext);
        
        //�ش�֪ͨ
        Paragraph ParagraphTCTZ = new Paragraph("�ش�֪ͨ", FontCN_SONG10N);
        ParagraphTCTZ.setFirstLineIndent(20);//��������
        ParagraphTCTZ.setSpacingAfter(60);
        document.add(ParagraphTCTZ);
        
        
        PdfPTable Table1 = new PdfPTable(1);
        Table1.setTotalWidth(width);
        
        PdfPCell Table1_cell1 = new PdfPCell(new Paragraph("�й���ͯ��������������", FontCN_SONG10B));
        Table1_cell1.setBorder(0);
        Table1_cell1.setFixedHeight(25f);
        Table1_cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Table1.addCell(Table1_cell1);
        String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");
        if(!"".equals(NOTICE_SIGN_DATE)){
            Date date4 = sdf.parse(NOTICE_SIGN_DATE);
            NOTICE_SIGN_DATE = sdfCN.format(date4);
        }
        PdfPCell Table1_cell2 = new PdfPCell(new Paragraph(NOTICE_SIGN_DATE, FontCN_SONG10N));
        Table1_cell2.setBorder(0);
        Table1_cell2.setFixedHeight(18f);
        Table1_cell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Table1.addCell(Table1_cell2);
        Table1.setSpacingAfter(30);
        document.add(Table1);
        
        if("1".equals(isFB)){//�������ɵ�����
            PdfPTable Table2 = new PdfPTable(1);
            Table2.setTotalWidth(width);
            String ARCHIVE_NO = data.getString("ARCHIVE_NO");//������
            PdfPCell Table2_cell1 = new PdfPCell(new Paragraph(ARCHIVE_NO, FontEN_H10B));
            Table2_cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Table2_cell1.setBorder(0);
            Table2.addCell(Table2_cell1);
            document.add(Table2);
        }
        document.close();
        
        File file = new File(PDFpath);//��������֪ͨ
        if (file.exists()) {
            String smallType = "";
            if("0".equals(isFB)){
                smallType = AttConstants.SWSYTZ;//��������֪ͨ
            }else{
                smallType = AttConstants.SWSYTZFB;//��������֪ͨ����
            }
            AttHelper.delAttsOfPackageId(MI_ID, smallType, "AF");//ɾ��ԭ����
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, "��������֪ͨ.pdf", smallType, "AF", smallType, MI_ID);
            file.delete();//ɾ��ԭ�����ɵ��������֪ͨ��
        }
    }
    /**
     * 
     * @Title: plusPrintNum
     * @Description: ���Ӵ�ӡ����
     * @author: xugy
     * @date: 2014-11-12����9:47:52
     * @param MI_ID
     * @param BIZ_TYPE
     * @return
     */
    public String plusPrintNum(String MI_ID, String BIZ_TYPE){
        String rValue = "0";
        String[] arry = MI_ID.split(",");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=0;i<arry.length;i++){
                Data PNdata = handler.getPrintNum(conn, arry[i]);
                Data MIdata = new Data();
                MIdata.add("MI_ID", arry[i]);
                Data PRdata = new Data();
                PRdata.add("PR_ID", "");//��ӡ��¼ID
                PRdata.add("BIZ_TYPE", BIZ_TYPE);//ҵ������
                PRdata.add("MI_ID", arry[i]);//ƥ����ϢID
                PRdata.add("PRINTER_NAME", SessionInfo.getCurUser().getPerson().getCName());//��ӡ��
                PRdata.add("PRINT_DATE", DateUtility.getCurrentDate());//��ӡ����
                if("1".equals(BIZ_TYPE)){//���������
                    int NUM = PNdata.getInt("ADVICE_PRINT_NUM");//�������_��ӡ����
                    int ADVICE_PRINT_NUM = NUM + 1;
                    MIdata.add("ADVICE_PRINT_NUM", ADVICE_PRINT_NUM);//�������_��ӡ����
                    MIdata.add("ADVICE_PRINT_DATE", DateUtility.getCurrentDate());//�������_����ӡ����
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("ADVICE_SIGN_DATE"));//�������
                }
                if("2".equals(BIZ_TYPE)){//֪ͨ��
                    int NUM = PNdata.getInt("NOTICE_PRINT_NUM");//֪ͨ��_��ӡ����
                    int NOTICE_PRINT_NUM = NUM + 1;
                    MIdata.add("NOTICE_PRINT_NUM", NOTICE_PRINT_NUM);//֪ͨ��_��ӡ����
                    MIdata.add("NOTICE_PRINT_DATE", DateUtility.getCurrentDate());//NOTICE_PRINT_DATE
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("NOTICE_SIGN_DATE"));//�������
                }
                if("3".equals(BIZ_TYPE)){//֪ͨ�鸱��
                    int NUM = PNdata.getInt("NOTICECOPY_PRINT_NUM");//֪ͨ�鸱��_��ӡ����
                    int NOTICECOPY_PRINT_NUM = NUM + 1;
                    MIdata.add("NOTICECOPY_PRINT_NUM", NOTICECOPY_PRINT_NUM);//֪ͨ�鸱��_��ӡ����
                    MIdata.add("NOTICECOPY_PRINT_DATE", DateUtility.getCurrentDate());//NOTICECOPY_PRINT_DATE
                    String NOTICECOPY_REPRINT = PNdata.getString("NOTICECOPY_REPRINT");
                    if("1".equals(NOTICECOPY_REPRINT)){
                        MIdata.add("NOTICECOPY_REPRINT", "9");//֪ͨ�鸱��_�Ƿ��ش�
                    }
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("NOTICECOPY_SIGN_DATE"));//�������
                    
                }
                handler.saveNcmMatchInfo(conn, MIdata);
                handler.saveNcmPrintRecord(conn, PRdata);
            }
            
            dt.commit();
            rValue = "1";
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
            
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
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
        return rValue;
        
    }
    
    /**
     * 
     * @Title: waterMark
     * @Description: pdf ���ˮӡ
     * @author: xugy
     * @date: 2014-11-17����6:38:24
     * @param inputPath
     * @param outputPath
     * @param imagePath
     */
    public void waterMark(String inputPath, String outputPath, String imagePath){
        try {
            PdfReader reader = new PdfReader(inputPath);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(outputPath));
            int total = reader.getNumberOfPages() + 1;
            PdfContentByte under;
            Image img = Image.getInstance(imagePath);// ����ˮӡ
            img.setAbsolutePosition(60, 300);
            for (int i = 1; i < total; i++) {
                under = stamper.getUnderContent(i);
                under.addImage(img);
            }
            stamper.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
