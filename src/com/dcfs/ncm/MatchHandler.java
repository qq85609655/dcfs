package com.dcfs.ncm;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.dcfs.common.atttype.AttConstants;
/**
 * 
 * @Title: MatchHandler.java
 * @Description: ƥ�乫������
 * @Company: 21softech
 * @Created on 2014-10-30 ����10:17:45
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchHandler extends BaseHandler {
    /**
     * 
     * @Title: saveNcmMatchInfo
     * @Description: ��ͥƥ����Ϣ����
     * @author: xugy
     * @date: 2014-10-30����10:22:07
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveNcmMatchInfo(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_INFO");
        dataadd.setPrimaryKey("MI_ID");
        if("".equals(dataadd.getString("MI_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: storeNcmMatchInfo
     * @Description: �����ļ�ID��AF_ID���޸�ƥ����Ϣ
     * @author: xugy
     * @date: 2014-12-16����11:19:03
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data storeNcmMatchInfoOne(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_INFO");
        dataadd.setPrimaryKey("AF_ID");
        return dataadd.store();
    }
    /**
     * 
     * @Title: storeNcmMatchInfoTwo
     * @Description: �����ļ�ID��AF_ID������ID��CI_ID���޸�ƥ����Ϣ
     * @author: xugy
     * @date: 2014-12-16����11:57:48
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data storeNcmMatchInfoTwo(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_INFO");
        dataadd.setPrimaryKey("AF_ID","CI_ID");
        return dataadd.store();
    }
    /**
     * 
     * @Title: saveNcmMatchAudit
     * @Description: ƥ����˼�¼����
     * @author: xugy
     * @date: 2014-10-30����10:23:02
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveNcmMatchAudit(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_AUDIT");
        dataadd.setPrimaryKey("MAU_ID");
        if("".equals(dataadd.getString("MAU_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: saveNcmArchiveInfo
     * @Description: ��������������Ϣ����
     * @author: xugy
     * @date: 2014-11-2����2:47:47
     * @param conn
     * @param data
     * @throws DBException
     */
    public void saveNcmArchiveInfo(Connection conn, Data data) throws DBException {
        // ***��������*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_ARCHIVE_INFO");
        dataadd.setPrimaryKey("ARCHIVE_ID");
        if ("".equals(dataadd.getString("ARCHIVE_ID", ""))) {
            dataadd.create();         
        } else {
            dataadd.store();
        }
    }
    /**
     * 
     * @Title: saveNcmPrintRecord
     * @Description: ��ӡ��¼����
     * @author: xugy
     * @date: 2014-11-12����9:58:14
     * @param conn
     * @param data
     * @throws DBException
     */
    public void saveNcmPrintRecord(Connection conn, Data data) throws DBException {
        // ***��������*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_PRINT_RECORD");
        dataadd.setPrimaryKey("PR_ID");
        if ("".equals(dataadd.getString("PR_ID", ""))) {
            dataadd.create();         
        } else {
            dataadd.store();
        }
    }
    /**
     * 
     * @Title: getCIInfo
     * @Description: ���ݶ�ͯ��Ż�ȡ��ͯ��Ϣ
     * @author: xugy
     * @date: 2014-10-30����10:26:31
     * @param conn
     * @param CHILD_NO
     * @return
     * @throws DBException
     */
    public DataList getCIInfoInChildNo(Connection conn, String CHILD_NO) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfoInChildNo", CHILD_NO);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl;
    }
    /**
     * 
     * @Title: getCIInfoOfCiId
     * @Description: ����������ȡ��ͯ��Ϣ
     * @author: xugy
     * @date: 2014-10-30����11:27:18
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException
     */
    public Data getCIInfoOfCiId(Connection conn, String CI_ID) throws DBException{
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfoOfCiId", CI_ID);
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
     * @Title: getAFInfoOfCiId
     * @Description: ����������ȡ��������Ϣ
     * @author: xugy
     * @date: 2014-10-30����11:28:51
     * @param conn
     * @param AF_ID
     * @return
     * @throws DBException
     */
    public Data getAFInfoOfAfId(Connection conn, String AF_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAFInfoOfAfId", AF_ID);
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
     * @Title: getCiIdOfChildNo
     * @Description: ���ݶ�ͯ��Ż�ȡ��ͯ����ID
     * @author: xugy
     * @date: 2014-10-30����4:09:45
     * @param conn
     * @param CHILD_NO
     * @return
     * @throws DBException
     */
    public String getCiIdOfChildNo(Connection conn, String CHILD_NO) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCiIdOfChildNo", CHILD_NO);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0).getString("CI_ID");
    }
    /**
     * 
     * @Title: getNcmMatchInfo
     * @Description: �Լ�ͥƥ����Ϣ��NCM_MATCH_INFO��Ϊ�������ƥ����Ϣ
     * @author: xugy
     * @date: 2014-11-2����11:19:48
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException
     */
    public Data getNcmMatchInfo(Connection conn, String MI_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmMatchInfo", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getNcmMatchInfoForAdreg
     * @Description: �����Ǽ�������
     * @author: xugy
     * @date: 2014-11-7����4:03:26
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmMatchInfoForAdreg(Connection conn, String MI_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmMatchInfoForAdreg", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getNcmMatchInfoForAdregCard
     * @Description: �����Ǽ�֤
     * @author: xugy
     * @date: 2014-11-9����5:42:57
     * @param MI_ID
     * @return
     * @throws DBException
     */
    public Data getNcmMatchInfoForAdregCard(Connection conn, String MI_ID) throws DBException{
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmMatchInfoForAdregCard", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getLetterInfo
     * @Description: �����������Ϣ
     * @author: xugy
     * @date: 2014-11-9����7:21:35
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getLetterInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getLetterInfo", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getIntercountryAdoptionInfo
     * @Description: ��������ϸ�֤
     * @author: xugy
     * @date: 2014-11-10����12:41:25
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getIntercountryAdoptionInfo(Connection conn, String MI_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getIntercountryAdoptionInfo", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getNoticeInfo
     * @Description: ����������Ů֪ͨ��
     * @author: xugy
     * @date: 2014-11-10����3:54:10
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException
     */
    public Data getNoticeInfo(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNoticeInfo", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getPhotoPath
     * @Description: 
     * @author: xugy
     * @date: 2014-11-10����4:59:36
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException 
     */
    public String getPhotoPath(Connection conn, String CI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPhotoPath", CI_ID, AttConstants.CI_IMAGE);
        DataList dl = ide.find(sql);
        String path="";
        if(dl.size()>0){
            path = dl.getData(0).getString("FILESYSTEM_PATH") + dl.getData(0).getString("RANDOM_NAME");
        }
        return path;
        
        //System.out.println(dl);
    }
    /**
     * 
     * @Title: getPrintNum
     * @Description: ��ȡ��ӡ����
     * @author: xugy
     * @date: 2014-11-12����9:39:15
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getPrintNum(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPrintNum", MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }
    /**
     * �����˲���ͬ������ʱ���ȶԱ����������ִ��ҵ��
     * @Title: selectMatchStateForUpdate
     * @Description: 
     * @author: xugy
     * @date: 2014-12-12����10:43:43
     * @param conn
     * @param MI_ID
     * @param AF_ID
     * @return
     * @throws DBException 
     */
    public Data selectMatchStateForUpdate(Connection conn, String AF_ID, String MI_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("selectMatchStateForUpdate", AF_ID, MI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    
    public Data getCIInfoOfChildNo(Connection conn, String CHILD_NO) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfoOfChildNo", CHILD_NO);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
}
