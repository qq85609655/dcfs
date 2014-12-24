/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.word.getword;

import hx.common.Exception.DBException;
import hx.config.CommonConfig;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.word.data.BaseData;
import hx.word.data.DataFactory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import com.dcfs.pdfTest1;
import com.dcfs.common.atttype.AttConstants;
import com.hx.upload.sdk.AttHelper;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @Title: GetWord.java
 * @Description:根据模版生成word
 * @Company: 21softech
 * @Created on 2014-11-5 05:34:35
 * @author 柏鹤云
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class GetWord {
    
    private Configuration configuration = null;
    
    public GetWord() {
        configuration = new Configuration();
        configuration.setDefaultEncoding("GBK");
    }
    
    public void createDoc(Connection conn, String id,String ftlname,String classpath,String savepath) throws Exception {
        //获取实现类
        BaseData baseData = DataFactory.getDataBase(classpath);
        Map<String,Object> dataMap=baseData.getData(conn, id);
        configuration.setClassForTemplateLoading(this.getClass(), "/hx/word/template");
        Template t=null;
        try {
            t = configuration.getTemplate(ftlname,"GBK");
        } catch (IOException e) {
            e.printStackTrace();
        }
        File outFile = new File(savepath);
        Writer out = null;
        try {
            //out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile),"GBK"));
            
            FileOutputStream fileOutputStream = new FileOutputStream(outFile);
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(fileOutputStream);
            out = new BufferedWriter(outputStreamWriter);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
        }
        try {
            t.process(dataMap, out);
        } catch (TemplateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            if(out!=null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }	
    }
    
    private static Log log=UtilLog.getLog(pdfTest1.class);

    /**
     * @param args
     */
    public static void main(String[] args) {
    	
        GetWord getWord = new GetWord();
        System.out.println("dddd");
        String MI_ID = "25265ae8-8c33-4cfb-a5ba-10a42b24a9a4";
        
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            String path2 = CommonConfig.getProjectPath() + "/tempFile/收养登记证.doc";
            //产生收养登记证
            getWord.createDoc(conn, MI_ID,"sydjz.ftl","hx.word.data.impl.GetWordSydjzImpl",path2);
            File file2 = new File(path2);
            if(file2.exists()){
                AttHelper.delAttsOfPackageId(MI_ID, AttConstants.SYDJZ, "AF");//删除原附件
                
                AttHelper.manualUploadAtt(file2, "AF", MI_ID, "收养登记证.doc", AttConstants.SYDJZ, "AF", AttConstants.SYDJZ, MI_ID);
                file2.delete();//删除原来生成的收养登记证
            }
            String IS_CONVENTION_ADOPT = "1";//公约收养
            if("1".equals(IS_CONVENTION_ADOPT)){//公约收养的生成跨国收养合格证明
                String path3 = CommonConfig.getProjectPath() + "/tempFile/跨国收养合格证明.doc";
                getWord.createDoc(conn, MI_ID,"syhgzm.ftl","hx.word.data.impl.GetWordSyhgzmImpl",path3);
                File file3 = new File(path3);
                if(file3.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.KGSYHGZM, "AF");//删除原附件
                    
                    AttHelper.manualUploadAtt(file3, "AF",MI_ID, "跨国收养合格证明.doc", AttConstants.KGSYHGZM, "AF", AttConstants.KGSYHGZM, MI_ID);
                    file3.delete();//删除原来生成的跨国收养合格证明
                }
            }
        } catch (DBException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
    }

}
