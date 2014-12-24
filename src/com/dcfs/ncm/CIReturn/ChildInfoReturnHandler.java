package com.dcfs.ncm.CIReturn;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: ChildInfoReturnHandler.java
 * @Description: �������˻ز��ϵ����ò�
 * @Company: 21softech
 * @Created on 2014-12-16 ����7:28:22
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChildInfoReturnHandler extends BaseHandler {
    /**
     * 
     * @Title: findAZBApplyCIReturnList
     * @Description: ���ò���������˻��б�
     * @author: xugy
     * @date: 2014-12-16����8:54:59
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBApplyCIReturnList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������������
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String SN_TYPE = data.getString("SN_TYPE", null);   //��������
        String APPLY_USER = data.getString("APPLY_USER", null);   //������
        String APPLY_DATE_START = data.getString("APPLY_DATE_START", null);   //��ʼ��������
        String APPLY_DATE_END = data.getString("APPLY_DATE_END", null);   //������������
        String CONFIRM_DATE_START = data.getString("CONFIRM_DATE_START", null);   //��ʼȷ������
        String CONFIRM_DATE_END = data.getString("CONFIRM_DATE_END", null);   //����ȷ������
        String APPLY_STATE = data.getString("APPLY_STATE", null);   //����״̬
        String CONFIRM_STATE = data.getString("CONFIRM_STATE", null);   //ȷ�Ͻ��
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBApplyCIReturnList", PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, APPLY_USER, APPLY_DATE_START, APPLY_DATE_END, CONFIRM_DATE_START, CONFIRM_DATE_END, APPLY_STATE, CONFIRM_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findAZBSelectDABCIList
     * @Description: ���ò�ѡ�����ƽ��Ķ�ͯ�����б�
     * @author: xugy
     * @date: 2014-12-17����11:16:04
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBSelectDABCIList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������������
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String SN_TYPE = data.getString("SN_TYPE", null);   //��������
        String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);   //��ʼ�ƽ�����
        String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);   //�����ƽ�����
        String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);   //��ʼ��������
        String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);   //������������
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBSelectDABCIList", PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, TRANSFER_DATE_START, TRANSFER_DATE_END, RECEIVER_DATE_START, RECEIVER_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: saveNcmArchRevocation
     * @Description: ������������
     * @author: xugy
     * @date: 2014-12-17����1:19:17
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveNcmArchRevocation(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_ARCH_REVOCATION");
        dataadd.setPrimaryKey("NAR_ID");
        if("".equals(dataadd.getString("NAR_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
        
    }
    /**
     * 
     * @Title: findDABRevokeArchiveList
     * @Description: ���������������б�
     * @author: xugy
     * @date: 2014-12-17����2:26:29
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABRevokeArchiveList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String FILE_NO = data.getString("FILE_NO", null);   //�ļ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String ARCHIVE_STATE = data.getString("ARCHIVE_STATE", null);   //�鵵״̬
        String CONFIRM_USER = data.getString("CONFIRM_USER", null);   //ȷ����
        String CONFIRM_DATE_START = data.getString("CONFIRM_DATE_START", null);   //��ʼȷ������
        String CONFIRM_DATE_END = data.getString("CONFIRM_DATE_END", null);   //����ȷ������
        String APPLY_STATE = data.getString("APPLY_STATE", null);   //ȷ��״̬
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABRevokeArchiveList", ARCHIVE_NO, SIGN_NO, SIGN_DATE_START, SIGN_DATE_END, PROVINCE_ID, WELFARE_ID, NAME, FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, ARCHIVE_STATE, CONFIRM_USER, CONFIRM_DATE_START, CONFIRM_DATE_END, APPLY_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getNcmArchRevocation
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17����4:07:15
     * @param conn
     * @param NAR_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmArchRevocation(Connection conn, String NAR_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmArchRevocation", NAR_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getNcmArchiveInfo
     * @Description: ��ȡ������Ϣ
     * @author: xugy
     * @date: 2014-12-17����4:48:16
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmArchiveInfo(Connection conn, String CI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmArchiveInfo", CI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }

}
