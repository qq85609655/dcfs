/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.word.data;


/**
 * @Title: DataFactory.java
 * @Description:
 * @Company: 21softech
 * @Created on 2014-11-5 08:27:20
 * @author °Øº×ÔÆ
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DataFactory {

    public static BaseData getDataBase(String classpath) {
        BaseData baseData = null;
        try {
            baseData = (BaseData)Class.forName(classpath).newInstance();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return baseData;
    }

}
