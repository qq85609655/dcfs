/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URL;
/**
 * @Title: UtilFile.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 下午02:36:42
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class UtilFile
{

    public static String saveTemFile(String str, String suffix) throws IOException
    {
        String suffix1 = (suffix == null) ? ".tem" : suffix;

        java.io.File temfile = java.io.File.createTempFile("tem", suffix1, null);
        String fileName = temfile.getAbsolutePath();
        saveToFile(str, fileName);
        return fileName;

    }
    public static void saveToFile(byte[] content, String fileName) throws IOException
    {
        FileOutputStream out = null;
        try
        {
            File outFile = new File(fileName);
            if (!outFile.exists())
            {
                outFile.createNewFile();
            }
            out = new FileOutputStream(outFile);
            out.write(content);
            out.flush();
        } catch (IOException e)
        {
            throw e;
        } catch (Throwable e)
        {
            e.printStackTrace();
        } finally
        {
            if (out != null)
            {
                try
                {
                    out.close();
                } catch (Exception e1)
                {
                }
            }
        }
    }
    public static void saveToFile(String str, String filename) throws IOException
    {
        saveToFile(str, filename, "UTF-8");
    }

    public static void saveToFile(String str, String filename, String encode) throws IOException
    {
        if (str == null)
            throw new IllegalArgumentException("参数is null");
        java.io.File f = new java.io.File(filename);
        if (!f.exists())
            f.createNewFile();

        FileOutputStream fos = new FileOutputStream(filename);

        Writer out = new OutputStreamWriter(fos, encode);

        out.write(str);

        out.close();
    }
    public static void delFile(String fileName)
    {
        java.io.File f = new java.io.File(fileName);
        f.deleteOnExit();
    }

    /**
     * 功能描述：删除字符串数组指定路径的所有文件和文件夹。
     * @return boolean
     */
    public static boolean delDirectory(String filename)
    {
        deleteFileAndFolder(new File(filename.replace('\\', '/')));
        return true;
    }
    /**
     * 功能描述：删除字符串指定路径的所有文件和文件夹。
     * @return boolean
     */
    private static boolean deleteFileAndFolder(File filename)
    {
        File file = filename;
        if (file.isFile())
        {
            file.delete();
            return true;
        } else
        {
            File[] allfiles = file.listFiles();
            for (int i = 0; i < allfiles.length; i++)
            {
                deleteFileAndFolder(allfiles[i]);
            }
            file.delete();
            return true;
        }
    }
    public static void copyFile(String src, String dest) throws IOException
    {
        FileInputStream in = new FileInputStream(src);
        FileOutputStream out = new FileOutputStream(dest);
        byte buffer[] = new byte[1024];
        int read = -1;
        while ((read = in.read(buffer, 0, 1024)) != -1)
        {
            out.write(buffer, 0, read);
        }
        out.flush();
        out.close();
        in.close();
    }

    public static String readToString(String fileName) throws IOException
    {
        StringBuffer tem = new StringBuffer();
        FileReader fr = new FileReader(fileName);
        BufferedReader br = new BufferedReader(fr);
        String Line;
        try
        {
            Line = br.readLine();
            while (Line != null)
            {
                tem.append(Line);
                Line = br.readLine(); //从文件中继续读取一行数据
            }           
        } 
        finally
        {
            br.close(); //关闭BufferedReader对象,如果错误fr还能关闭否
            fr.close(); //关闭文件              
        }

        return tem.toString();
    }
    
    
    public static byte[] readBytes(String fileName) throws IOException
    {
        return readBytes(UtilURL.fromFilename(fileName));
    }
    public static byte[] readBytes(URL file) throws IOException
    {
        if (file==null)
         return new byte[0];
        byte[] data = null;
        InputStream in = null;
        ByteArrayOutputStream out = null;
        try
        {
            in = file.openStream();
            out = new ByteArrayOutputStream();
            int len = 0;
            byte[] tmp = new byte[65535];
            while ((len = in.read(tmp)) > 0)
            {
                out.write(tmp, 0, len);
            }
            data = out.toByteArray();
        } catch (IOException e)
        {
            throw e;
        } finally
        {
            try
            {
                in.close();
            } catch (Exception e1)
            {
            }
            try
            {
                out.close();
            } catch (Exception e2)
            {
            }
        }
        return data;
    }
    /**
     * 读取utf-8编码
     * @param input
     * @return
     * @throws Exception
     */
    public static String readFile(String input) throws Exception
    {
        char[] buffer = new char[4096];
        int len = 0;
        StringBuffer content = new StringBuffer(4096);

        try
        {
            InputStreamReader fr = new InputStreamReader(new FileInputStream(input), "UTF-8");

            BufferedReader br = new BufferedReader(fr);
            while ((len = br.read(buffer)) > -1)
            {
                content.append(buffer, 0, len);
            }

            br.close();
            fr.close();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return content.toString();
    }
    
    /**
     * 按制定编码读取文件
     * @param input
     * @param encoding
     * @return
     * @throws Exception
     */
    public static String readFile(String input,String encoding) throws Exception
    {
        char[] buffer = new char[4096];
        int len = 0;
        StringBuffer content = new StringBuffer(4096);

        try
        {
            InputStreamReader fr = new InputStreamReader(new FileInputStream(input), encoding);

            BufferedReader br = new BufferedReader(fr);
            while ((len = br.read(buffer)) > -1)
            {
                content.append(buffer, 0, len);
            }

            br.close();
            fr.close();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return content.toString();
    }

    public static void move(String input, String output) throws Exception
    {
        File inputFile = new File(input);
        File outputFile = new File(output);
        try
        {
            inputFile.renameTo(outputFile);
        } catch (Exception ex)
        {
            throw new Exception("Can not mv" + input + " to " + output + ex.getMessage());
        }
    }
    public static void makeDir(String home) throws Exception
    {
        File homedir = new File(home);
        if (!homedir.exists())
        {
            try
            {
                homedir.mkdirs();
            } catch (Exception ex)
            {
                throw new Exception("Can not mkdir :" + home + " Maybe include special charactor!");
            }
        }
    }
    public static void CopyDir(String sourcedir, String destdir) throws Exception
    {
        File dest = new File(destdir);
        File source = new File(sourcedir);

        String[] files = source.list();
        try
        {
            makeDir(destdir);
        } catch (Exception ex)
        {
            throw new Exception("CopyDir:" + ex.getMessage());
        }

        for (int i = 0; i < files.length; i++)
        {
            String sourcefile = source + File.separator + files[i];
            String destfile = dest + File.separator + files[i];
            File temp = new File(sourcefile);
            if (temp.isFile())
            {
                try
                {
                    copyFile(sourcefile, destfile);
                } catch (Exception ex)
                {
                    throw new Exception("CopyDir:" + ex.getMessage());
                }
            }
        }
    }
    public static void recursiveRemoveDir(File directory) throws Exception
    {
        if (!directory.exists())
            throw new IOException(directory.toString() + " do not exist!");

        String[] filelist = directory.list();
        File tmpFile = null;
        for (int i = 0; i < filelist.length; i++)
        {
            tmpFile = new File(directory.getAbsolutePath(), filelist[i]);
            if (tmpFile.isDirectory())
            {
                recursiveRemoveDir(tmpFile);
            } else if (tmpFile.isFile())
            {
                try
                {
                    tmpFile.delete();
                } catch (Exception ex)
                {
                    throw new Exception(tmpFile.toString() + " can not be deleted " + ex.getMessage());
                }
            }
        }
        try
        {
            directory.delete();
        } catch (Exception ex)
        {
            throw new Exception(directory.toString() + " can not be deleted " + ex.getMessage());
        } finally
        {
            filelist = null;
        }
    }

}