/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import hx.log.Log;
import hx.log.UtilLog;

import java.util.ResourceBundle;

/**
 * @Title: AdrDamConfig.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-20 下午05:37:23
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MessageConfig {
    private static Log log=UtilLog.getLog(MessageConfig.class);
    
    private static String rootDir="";
    
    private static String rootDirMessage="";
    
    private static int uploadsize=100;
    
    protected static boolean isload=false;
    
    static{
        init();
    }
    private static void init(){
        try{
            ResourceBundle p = ResourceBundle.getBundle("message-config");
            String dir = p.getString("root_Dir");
            if(dir!=null && !dir.equals("")){
                rootDir=dir;
            }
            String dirMessage = p.getString("root_Dir_Message");
            if(dirMessage!=null && !dirMessage.equals("")){
                rootDirMessage=dirMessage;
            }
            String uploa_dsize = p.getString("uploa_dsize");
            if(uploa_dsize!=null && !uploa_dsize.equals("")){
                uploadsize=Integer.parseInt(uploa_dsize);
            }   
        }catch(Exception e){
            log.logError("读取配置文件失败！", e);
        }
    }
    /**
     * @return Returns the rootDir.
     */
    public static String getRootDir() {
        if(isload){
            init();
        }
        return rootDir;
    }
    /**
     * @param rootDir The rootDir to set.
     */
    public static void setRootDir(String rootDir) {
        MessageConfig.rootDir = rootDir;
    }
    /**
     * @return Returns the rootDirMessage.
     */
    public static String getRootDirMessage() {
        if(isload){
            init();
        }
        return rootDirMessage;
    }
    /**
     * @param rootDirMessage The rootDirMessage to set.
     */
    public static void setRootDirMessage(String rootDirMessage) {
        MessageConfig.rootDirMessage = rootDirMessage;
    }
    /**
     * @return Returns the uploadsize.
     */
    public static int getUploadsize() {
        if(isload){
            init();
        }
        return uploadsize;
    }
    /**
     * @param uploadsize The uploadsize to set.
     */
    public static void setUploadsize(int uploadsize) {
        MessageConfig.uploadsize = uploadsize;
    }
}
