package com.dcfs.far.appointment;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @Title: AppointmentHandler.java
 * @Description: ��������ԤԼ
 * @Company: 21softech
 * @Created on 2014-9-29 ����5:28:14
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AppointmentHandler extends BaseHandler {
    /**
     * 
     * @Title: findAppointmentRecordList
     * @Description: ������֯ԤԼ�б�
     * @author: xugy
     * @date: 2014-9-29����5:33:23
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAppointmentRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String SIGN_NO = data.getString("SIGN_NO", null);   //֪ͨ���
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //��ʼԤԼʱ��
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //����ԤԼʱ��
        String SUGGEST_DATE_START = data.getString("SUGGEST_DATE_START", null);   //��ʼ����ʱ��
        String SUGGEST_DATE_END = data.getString("SUGGEST_DATE_END", null);   //��������ʱ��
        String ORDER_STATE = data.getString("ORDER_STATE", null);   //ԤԼ״̬
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAppointmentRecordList", adoptOrg, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, SUGGEST_DATE_START, SUGGEST_DATE_END, ORDER_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZAppointmentSelectList
     * @Description: ������֯ԤԼѡ���б�
     * @author: xugy
     * @date: 2014-9-29����8:52:51
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAppointmentSelectList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String SIGN_NO = data.getString("SIGN_NO", null);   //֪ͨ���
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAppointmentSelectList", adoptOrg, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SIGN_DATE_START, SIGN_DATE_END, compositor, ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getAppointmentShowInfo
     * @Description: ��ȡԤԼ�����ʾ��Ϣ
     * @author: xugy
     * @date: 2014-9-30����1:34:31
     * @param conn
     * @param id
     * @return
     * @throws DBException 
     */
    public Data getAppointmentShowInfo(Connection conn, String id) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAppointmentShowInfo", id);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: SYZZAppointmentSave
     * @Description: ԤԼ���뱣��
     * @author: xugy
     * @date: 2014-9-30����2:16:00
     * @param conn
     * @param data
     * @throws DBException 
     */
    public void SYZZAppointmentSave(Connection conn, Data data) throws DBException {
     // ***��������*****
        Data dataadd = new Data(data);

        dataadd.setConnection(conn);
        dataadd.setEntityName("FAR_APPOINTMENT_RECORD");
        dataadd.setPrimaryKey("AR_ID");
        if ("".equals(dataadd.getString("AR_ID", ""))) {
            dataadd.create();         
        } else {
            dataadd.store();
        }
        
    }
    /**
     * 
     * @Title: getAppointmentInfo
     * @Description: ԤԼ�����޸�ҳ����Ϣ
     * @author: xugy
     * @date: 2014-9-30����3:57:47
     * @param conn
     * @param AR_ID
     * @return
     * @throws DBException 
     */
    public Data getAppointmentInfo(Connection conn, String AR_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAppointmentInfo", AR_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    
    
    
    
    
    
    /**
     * 
     * @Title: findSTAppointmentAcceptList
     * @Description: ʡ��ԤԼ����
     * @author: xugy
     * @date: 2014-10-2����2:59:44
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSTAppointmentAcceptList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String SIGN_NO = data.getString("SIGN_NO", null);   //֪ͨ���
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //��ʼԤԼʱ��
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //����ԤԼʱ��
        String SUGGEST_DATE_START = data.getString("SUGGEST_DATE_START", null);   //��ʼ����ʱ��
        String SUGGEST_DATE_END = data.getString("SUGGEST_DATE_END", null);   //��������ʱ��
        String ORDER_STATE = data.getString("ORDER_STATE", null);   //ԤԼ״̬
        
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSTAppointmentAcceptList", provinceCode, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, WELFARE_NAME_CN, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, SUGGEST_DATE_START, SUGGEST_DATE_END, ORDER_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findFLYApppointmentList
     * @Description: ����Ժ����ԤԼ�б�
     * @author: xugy
     * @date: 2014-10-9����9:29:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFLYApppointmentList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String SIGN_NO = data.getString("SIGN_NO", null);   //֪ͨ���
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //��ʼԤԼʱ��
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //����ԤԼʱ��
        
        
        String WelfareCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findFLYApppointmentList", WelfareCode, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
