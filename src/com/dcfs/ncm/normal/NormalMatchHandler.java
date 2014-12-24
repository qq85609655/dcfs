package com.dcfs.ncm.normal;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;

import com.dcfs.common.transfercode.TransferCode;

/**
 * 
 * @Title: NormalMatchHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2014-9-2 ����3:55:02
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class NormalMatchHandler extends BaseHandler {
    
    /**
     * 
     * @Title: findMatchList
     * @Description: ƥ���б�
     * @author: xugy
     * @date: 2014-9-2����4:43:25
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //���Ŀ�ʼ����
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //���Ľ�������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String MATCH_RECEIVEDATE_START = data.getString("MATCH_RECEIVEDATE_START", null);   //���տ�ʼ����
        String MATCH_RECEIVEDATE_END = data.getString("MATCH_RECEIVEDATE_END", null);   //���ս�������
        String FILE_TYPE = data.getString("FILE_TYPE", "");   //�ļ�����
        if("".equals(FILE_TYPE)){
            FILE_TYPE = "(FILE_TYPE='10' or FILE_TYPE='30' or FILE_TYPE='31' or FILE_TYPE='32' or FILE_TYPE='33' or FILE_TYPE='34' or FILE_TYPE='35')";
        }else{
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String ADOPT_REQUEST_CN = data.getString("ADOPT_REQUEST_CN", null);   //����Ҫ��
        String UNDERAGE_NUM = data.getString("UNDERAGE_NUM", null);   //��Ů����
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //ƥ�����
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //ƥ��״̬
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("9".equals(MATCH_STATE)){
            MATCH_STATE = "(MATCH_STATE='0' or MATCH_STATE='1')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
            
        }
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFMatchList", nowDate, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, MATCH_RECEIVEDATE_START, MATCH_RECEIVEDATE_END, FILE_TYPE, ADOPT_REQUEST_CN, UNDERAGE_NUM, MATCH_NUM, MATCH_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: AFplanCountSum1
     * @Description: ͨ��REG_DATE��ѯ�����ļ�����
     * @author: xugy
     * @date: 2014-9-3����10:38:13
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public Data AFplanCountSum1(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AFplanCountSum1", nowDate, FILE_TYPE, DATE_START, DATE_END);
        //System.out.println(sql);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: AFplanCountSum2
     * @Description: ͨ��RECEIVER_DATE��ѯ�����ļ�����
     * @author: xugy
     * @date: 2014-9-3����10:39:04
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public Data AFplanCountSum2(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String TRANSFER_CODE = TransferCode.FILE_SHB_DAB;//�ļ����ӣ���˲���������
        String sql = getSql("AFplanCountSum2", nowDate, FILE_TYPE, DATE_START, DATE_END, TRANSFER_CODE);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: CIplanCount
     * @Description: ��ͯ���ϸ�ʡ����
     * @author: xugy
     * @date: 2014-9-3����2:30:28
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList CIplanCount(Connection conn) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("CIplanCount");
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: CIplanCountSum
     * @Description: ��ͯ����������
     * @author: xugy
     * @date: 2014-9-3����2:41:49
     * @param conn
     * @return
     * @throws DBException
     */
    public Data CIplanCountSum(Connection conn) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("CIplanCountSum");
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findAFPlanList1
     * @Description: ͨ��REG_DATE��ѯ�����ļ�����
     * @author: xugy
     * @date: 2014-9-3����4:20:48
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public DataList findAFPlanList1(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFPlanList1", nowDate, FILE_TYPE, DATE_START, DATE_END);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: findAFPlanList2
     * @Description: ͨ��RECEIVER_DATE��ѯ�����ļ�����
     * @author: xugy
     * @date: 2014-9-3����4:20:52
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public DataList findAFPlanList2(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String TRANSFER_CODE = TransferCode.FILE_SHB_DAB;//�ļ����ӣ���˲���������
        String sql = getSql("findAFPlanList2", nowDate, FILE_TYPE, DATE_START, DATE_END, TRANSFER_CODE);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getAFExpireDate
     * @Description: ��ȡ�ļ���������׼��ĵ�������
     * @author: xugy
     * @date: 2014-9-4����11:24:35
     * @param conn
     * @param AFid
     * @return
     * @throws DBException 
     */
    public Data getAFExpireDate(Connection conn, String AFid) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAFExpireDate", AFid);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findCIMatchList
     * @Description: ѡ��ƥ���ͯ�б�
     * @author: xugy
     * @date: 2014-9-4����2:35:03
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findCIMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String CHECKUP_DATE_START = data.getString("CHECKUP_DATE_START", null);   //��쿪ʼ����
        String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END", null); //����������
        String NAME = data.getString("NAME", null); //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //���տ�ʼ
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //���ս���
        String CHILD_TYPE = "1";   //��ͯ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCIMatchList", PROVINCE_ID, WELFARE_ID, CHECKUP_DATE_START, CHECKUP_DATE_END, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
