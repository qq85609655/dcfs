/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package com.dcfs.common;

import hx.log.Log;
import hx.log.UtilLog;

import java.util.ResourceBundle;

/**
 * @Title: CompanyConfig.java
 * @Description:修改历史配置类
 * @Company: 21softech
 * @Created on 2012-5-21 下午02:03:58
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ModifyHistoryConfig {
    
 private static Log log=UtilLog.getLog(ModifyHistoryConfig.class);
    
    private static String showstring="";
    
    protected static boolean isload=true;
    /*static{
        init(null);
    }  */
   
    private static void init(String ss,String fileName){
        try{
            ResourceBundle p = ResourceBundle.getBundle(fileName);
            String Showstring = p.getString(ss);
            if(Showstring!=null && !Showstring.equals("")){
                showstring=Showstring;
            }
        }catch(Exception e){
            log.logError("读取配置文件失败！", e);
        }
    }
    /**
     * @return Returns the rootDir.
     */
    public static String getShowstring(String oristring,String fileName) {
        if(isload){
            init(oristring,fileName);
        }
        return showstring;
    }
}
