package com.dcfs.far.adoptionRegis;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: AdoptionRegisHandler.java
 * @Description: �����Ǽǰ���
 * @Company: 21softech
 * @Created on 2014-9-22 ����7:54:44
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdoptionRegisHandler extends BaseHandler {
    /**
     * 
     * @Title: findAdoptionRegisList
     * @Description: �����Ǽ��б�
     * @author: xugy
     * @date: 2014-9-22����7:56:58
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAdoptionRegisList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��������
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", null);   //������ͯ��������
        String ADREG_NO = data.getString("ADREG_NO", null);   //�Ǽ�֤��
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String ADREG_STATE = data.getString("ADREG_STATE", null);   //�Ǽ�״̬
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAdoptionRegisList", provinceCode, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, WELFARE_NAME_CN, CHILD_TYPE, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, IS_CONVENTION_ADOPT, ADREG_NO, SIGN_DATE_START, SIGN_DATE_END, ADREG_STATE, ADREG_DATE_START, ADREG_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getAdoptionRegInfo
     * @Description: ��ȡ�����Ǽ���Ϣ
     * @author: xugy
     * @date: 2014-9-23����2:06:23
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAdoptionRegInfo(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAdoptionRegInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findOldFarSN
     * @Description: ��ȡ�Ǽ�֤�žɺ�
     * @author: xugy
     * @date: 2014-9-24����11:08:56
     * @param conn
     * @param provinceCode
     * @return
     * @throws DBException 
     */
    public CodeList findOldFarSN(Connection conn, String provinceCode) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findOldFarSN", provinceCode);
        DataList dataList = ide.find(sql);
        CodeList list=new CodeList();
        for(int i=0;i<dataList.size();i++){
            Code c=new Code();
            c.setValue(dataList.getData(i).getString("VALUE"));
            c.setName(dataList.getData(i).getString("NAME"));
            c.setRem(dataList.getData(i).getString("NAME"));
            list.add(c);
        }
        return list;
    }
    /**
     * 
     * @Title: storeFarSN
     * @Description: ���Ǽ�֤�žɺ���ʹ�õ��޸�״̬
     * @author: xugy
     * @date: 2014-9-24����2:55:22
     * @param conn
     * @param farData
     * @throws DBException 
     */
    public void storeFarSN(Connection conn, Data data) throws DBException {
        data.setEntityName("FAR_REGISTRATION_SN");
        data.setPrimaryKey("FAR_SN");
        data.setConnection(conn);
        data.store();
    }
    /**
     * 
     * @Title: getSavePFRInfo
     * @Description: ��ȡ���ú󱨸汣����Ϣ
     * @author: xugy
     * @date: 2014-10-9����4:13:08
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getSavePFRInfo(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getSavePFRInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findAdoptionRegisCancelList
     * @Description: �Ǽ�ע���б�
     * @author: xugy
     * @date: 2014-11-2����5:09:11
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAdoptionRegisCancelList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        String ADREG_NO = data.getString("ADREG_NO", null);   //�Ǽ�֤��
        String ADREG_INVALID_DATE_START = data.getString("ADREG_INVALID_DATE_START", null);   //��ʼע������
        String ADREG_INVALID_DATE_END = data.getString("ADREG_INVALID_DATE_END", null);   //����ע������
        String ADREG_STATE = data.getString("ADREG_STATE", null);   //�Ǽ�״̬
        
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAdoptionRegisCancelList", provinceCode, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, WELFARE_NAME_CN, CHILD_TYPE, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END, ADREG_NO, ADREG_INVALID_DATE_START, ADREG_INVALID_DATE_END, ADREG_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: saveArchiveInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-11-6����6:37:14
     * @param conn
     * @param aIdata
     * @throws DBException 
     */
    public void storeArchiveInfo(Connection conn, Data data) throws DBException {
        // ***��������*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_ARCHIVE_INFO");
        dataadd.setPrimaryKey("MI_ID");
        dataadd.store();
        
    }
    /**
     * 
     * @Title: findFLYAdoptionRegisList
     * @Description: ����Ժ�����Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����5:36:40
     * @param conn
     * @param wELFARE_ID
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFLYAdoptionRegisList(Connection conn, String WELFARE_ID, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯CODE
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        String ADREG_NO = data.getString("ADREG_NO", null);   //�Ǽ�֤��
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findFLYAdoptionRegisList",WELFARE_ID,COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME,FEMALE_NAME,NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END,ADREG_NO,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZAdoptionRegisList
     * @Description: ������֯�����Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����5:54:43
     * @param conn
     * @param ADOPT_ORG_ID
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList findSYZZAdoptionRegisList(Connection conn, String ADOPT_ORG_ID, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", null);   //�Ƿ�Լ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        String ADREG_STATE = data.getString("ADREG_STATE", null);   //�Ǽ�״̬
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAdoptionRegisList",ADOPT_ORG_ID,FILE_NO,MALE_NAME,FEMALE_NAME,PROVINCE_ID,WELFARE_ID,NAME_PINYIN,IS_CONVENTION_ADOPT,SIGN_DATE_START,SIGN_DATE_END,SIGN_NO,ADREG_DATE_START,ADREG_DATE_END,ADREG_STATE,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findAZBAdoptionRegisList
     * @Description: ���ò������Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����6:09:03
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList findAZBAdoptionRegisList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯CODE
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT",null);   //�Ƿ�Լ����
        String PROVINCE_ID = data.getString("PROVINCE_ID",null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        String ADREG_ALERT = data.getString("ADREG_ALERT", null);   //����״̬
        String ADREG_STATE = data.getString("ADREG_STATE", null);   //�Ǽ�״̬
        String ADREG_NO = data.getString("ADREG_NO", null);   //�Ǽ�֤��
        String SIGN_NO = data.getString("SIGN_NO",null);   //ǩ�����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBAdoptionRegisList",COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME,FEMALE_NAME, WELFARE_ID,IS_CONVENTION_ADOPT,PROVINCE_ID,NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END,ADREG_ALERT,ADREG_STATE,ADREG_NO,SIGN_NO,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����3:24:00
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackInfo(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: storeFeedbackRecord
     * @Description: 
     * @author: xugy
     * @date: 2014-12-9����3:33:48
     * @param conn
     * @param pFRdata
     * @throws DBException 
     */
    public void storeFeedbackRecord(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_RECORD");
        dataadd.setPrimaryKey("FEEDBACK_ID","NUM");
        dataadd.store();
    }
}
