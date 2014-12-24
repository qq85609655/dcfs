package com.hx.cms.init;

import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;

import java.sql.Connection;
import java.sql.SQLException;

import com.hx.cms.channel.vo.Channel;

public class InitFullTextChannels {

    
    public static void main(String[] args) {
        //initChannelsChild();
        list();
    }
    
    public static void list(){
        Connection conn = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            IDataExecute ide = DataBaseFactory.getDataBase(conn);
            DataList dataList = ide.find("SELECT * FROM CMS_CHANNEL");
            System.out.println("共有栏目："+dataList.size()+"个");
            for (int i = 0; i < dataList.size(); i++) {
                Data data = dataList.getData(i);
                System.out.println(data.getString(Channel.NAME)+":"+data.getString(Channel.FULL_TEXT_IDS));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    //在子节点中加入父节点ID
    public static void initChannelsChild(){
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            IDataExecute ide = DataBaseFactory.getDataBase(conn);
            DataList dataList = ide.find("SELECT ID FROM CMS_CHANNEL");
            
            if(dataList != null){
                System.out.println("共有栏目："+dataList.size()+"个!");
                for (int j = 0; j < dataList.size(); j++) {
                    Data channel = dataList.getData(j);
                    
                    //根据ID获取它自己和所有子节点ID并保存到当前栏目的FULL_TEXT_ID字段，多个ID用逗号","分隔
                    DataList children = ide.find("WITH T AS(SELECT * FROM CMS_CHANNEL WHERE ID = '"+channel.getString(Channel.ID)+"' UNION ALL SELECT A.* FROM CMS_CHANNEL AS A JOIN T AS B ON A.ID = B.PARENT_ID) SELECT ID FROM T ORDER BY ID");
                    StringBuffer ids = new StringBuffer();
                    if(children!=null){
                        for (int i = 0; i < children.size(); i++) {
                            Data child = children.getData(i);
                            ids.append(child.getString(Channel.ID)).append(",");
                        }
                    }
                    
                    //保存
                    Data storeChannel = new Data();
                    storeChannel.setEntityName("CMS_CHANNEL");
                    storeChannel.setPrimaryKey(Channel.ID);
                    storeChannel.add(Channel.ID, channel.getString(Channel.ID));
                    storeChannel.add(Channel.FULL_TEXT_IDS, ids.toString());
                    storeChannel = ide.store(storeChannel);
                    System.out.println("第"+j+"个栏目:"+storeChannel.getString(Channel.NAME)+"--保存全文ID为："+storeChannel.getString(Channel.FULL_TEXT_IDS));
                    db.commit();
                }
            }
            
            System.out.println("完成频道");
        } catch (Exception e) {
            e.printStackTrace();
            try {
                db.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
