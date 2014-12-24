package com.dcfs.pfr;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.upload.UploadManagerHandler;
import hx.util.DateUtility;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
/**
 * 
 * @Title: PPFeebbackAttAction.java
 * @Description: ���ú󱨸渽��
 * @Company: 21softech
 * @Created on 2014-10-17 ����3:54:58
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeebbackAttAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PPFeebbackAttAction.class);
    private Connection conn = null;
    private PPFeebbackAttHandler handler;
    private BatchAttManager bm;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public PPFeebbackAttAction() {
        this.handler=new PPFeebbackAttHandler();
        this.bm=new BatchAttManager();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: findPPFdeedbackAtt
     * @Description: ��ȡ����
     * @author: xugy
     * @date: 2014-10-17����3:58:40
     * @return
     */
    public String findPPFdeedbackAtt() throws ParseException{
        String FB_REC_ID = getParameter("FB_REC_ID");//����ID
        String BIRTHDAY = getParameter("BIRTHDAY");//��ͯ����
        String NUM = getParameter("NUM");//�������
        String ACCIDENT_FLAG = getParameter("ACCIDENT_FLAG");//������ϵ�����ش��ʣ�1=һ�㣻2=������ͥ��3=����
        String isCN = getParameter("isCN");//�Ƿ���ʾ����
        String isEdit = getParameter("isEdit");//isEdit=1 �Ƿ�༭״̬
        String LANG = getParameter("LANG");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            DataList dl = new DataList();
            if("1".equals(ACCIDENT_FLAG)){
                String birthdayYear = BIRTHDAY.substring(0, 4);
                dl = attTypeNormal(conn, birthdayYear, NUM);
            }
            if("2".equals(ACCIDENT_FLAG)){
                dl = attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                dl = attTypeDead(conn);
            }
            
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                DataList Attdl = handler.findPPFdeedbackAtt(conn, FB_REC_ID, CODE);
                dl.getData(i).add("ATTDL", Attdl);
            }
            
            Data photoData = new Data();
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    photoData = dl.getData(i);
                    dl.remove(photoData);
                }
            }
            
            if("1".equals(isCN)){
                for(int i=0;i<dl.size();i++){
                    String CODE = dl.getData(i).getString("CODE");
                    String F_FB_REC_ID = "F_" + FB_REC_ID;
                    DataList AttCNdl = handler.findPPFdeedbackAtt(conn, F_FB_REC_ID, CODE);
                    dl.getData(i).add("ATTCNDL", AttCNdl);
                }
            }
            setAttribute("dl",dl);
            setAttribute("photoData",photoData);
            setAttribute("isCN",isCN);
            setAttribute("isEdit",isEdit);
            setAttribute("LANG",LANG);
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
    /**
     * 
     * @Title: showPicture
     * @Description: 
     * @author: xugy
     * @date: 2014-10-22����10:55:38
     * @throws Exception
     */
    public void showPicture() throws Exception{
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            HttpServletResponse response = getResponse();
            HttpServletRequest request = getRequest();
            String ATT_TABLE = request.getParameter("ATT_TABLE");
            String ID = request.getParameter("ID");
            
            Data pathData = handler.getPhotoPath(conn, ATT_TABLE, ID);
            String FILESYSTEM_PATH = pathData.getString("FILESYSTEM_PATH");
            String RANDOM_NAME = pathData.getString("RANDOM_NAME");
            String path = FILESYSTEM_PATH + RANDOM_NAME;
            
            FileInputStream is = new FileInputStream(path);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("image/*"); // ���÷��ص��ļ�����
            //��Ŀ¼�б���
            BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            BufferedInputStream inputStream = new BufferedInputStream(is);
            //��д
            byte[] b = new byte[1024];
            int len = 0;
            while((len = inputStream.read(b)) != -1){
                outputStream.write(b, 0, len);
                //����
                b = new byte[1024];
            }
            //�ر�
            outputStream.flush();
            inputStream.close();
            outputStream.close();
            
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
    }
    
    
    public void showThumbnail(){
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            HttpServletResponse response = getResponse();
            HttpServletRequest request = getRequest();
            String ATT_TABLE = request.getParameter("ATT_TABLE");
            String ID = request.getParameter("ID");
            UploadManagerHandler umh = new UploadManagerHandler();
            InputStream is = umh.getImg(conn, ATT_TABLE, ID);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("image/*"); // ���÷��ص��ļ�����
            //��Ŀ¼�б���
            BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            BufferedInputStream inputStream = new BufferedInputStream(is);
            //��д
            byte[] b = new byte[1024];
            int len = 0;
            while((len = inputStream.read(b)) != -1){
                outputStream.write(b, 0, len);
                //����
                b = new byte[1024];
            }
            //�ر�
            outputStream.flush();
            inputStream.close();
            outputStream.close();
            
            
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
    }
    
    /**�ӿڣ�ֻ���ú󱨸�
     * ���ú󱨸�-һ��
     * @Title: attTypeNormal
     * @Description: ��ȡ��������list
     * @author: xugy
     * @date: 2014-10-20����3:48:48
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList attTypeNormal(Connection conn, String birthdayYear, String NUM) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_NORMAL);
        //�ж϶�ͯ�Ƿ񳬹�10��
        String nowYear = DateUtility.getCurrentYear();
        int old = Integer.parseInt(nowYear)-Integer.parseInt(birthdayYear)+1;
        Data oldData = new Data();
        if(old>=10){
            oldData = handler.getSmallTypeData(conn, AttConstants.AR_SSDW);
            dl.add(oldData);
        }
        //�ж��Ƿ�����η���
        Data numData = new Data();
        if("3".equals(NUM)){
            numData = handler.getSmallTypeData(conn, AttConstants.AR_TXFK);
            dl.add(numData);
        }
        return dl;
    }
    /**�ӿڣ�ֻ���ú󱨸�
     * ���ú󱨸�-һ�㣬���ĸ�����ȥ����Ƭ�ϴ�
     * @Title: attTypeNormalCN
     * @Description: ��ȡ��������list
     * @author: xugy
     * @date: 2014-10-20����4:04:25
     * @param conn
     * @param birthdayYear
     * @param NUM
     * @return
     * @throws DBException
     */
    public DataList attTypeNormalCN(Connection conn, String birthdayYear, String NUM) throws DBException{
        DataList dl = new DataList();
        dl = attTypeNormal(conn, birthdayYear, NUM);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    dl.remove(dl.getData(i));
                }
            }
        }
        return dl;
    }
    /**�ӿڣ�ֻ���ú󱨸�
     * ���ú󱨸�-������ͥ
     * @Title: attTypeChangeFamily
     * @Description: ��ȡ��������list
     * @author: xugy
     * @date: 2014-10-20����4:08:22
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList attTypeChangeFamily(Connection conn) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_CHANGE_FAMILY);
        return dl;
    }
    /**�ӿڣ�ֻ���ú󱨸�
     * ���ú󱨸�-����
     * @Title: attTypeDead
     * @Description: ��ȡ��������list
     * @author: xugy
     * @date: 2014-10-20����4:09:35
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList attTypeDead(Connection conn) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_DEAD);
        return dl;
    }

}
