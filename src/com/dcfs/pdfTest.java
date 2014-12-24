package com.dcfs;

import hx.common.Exception.DBException;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import org.codehaus.xfire.handler.Phase;

import com.dcfs.ncm.MatchAction;
import com.hx.upload.datasource.DatasourceManager;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class pdfTest {
    private static Log log=UtilLog.getLog(pdfTest.class);
    
    public boolean iTextTest() {
        try {
            //实例化文档对象  
            Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4纸，左右上下空白
            
            String PDFpath = "C://Users//xugaoyang//Desktop//11111111.pdf";//输出文件路径
            // PdfWriter对象
            PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//文件的输出路径+文件的实际名称 
            float width = document.getPageSize().getWidth() - 160;
            document.open();// 打开文档
            //pdf文档中中文字体的设置，注意一定要添加iTextAsian.jar包
            //中文字体
            BaseFont bfHEI = BaseFont.createFont("C:\\Windows\\Fonts\\SIMHEI.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//黑体
            //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//四通宋体
            //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 楷体字
            //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 仿宋体
            BaseFont bfSONG = BaseFont.createFont("C:\\Windows\\Fonts\\SIMSUN.TTC,0",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  宋体
            //黑体 粗体
            Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//黑体 10 粗体
            //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//黑体 11 粗体
            //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//黑体 12 粗体
            //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//黑体 16 粗体
            Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//黑体 20 粗体
            //黑体 正常
            //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//黑体 7 正常
            
            //宋体 正常
            //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//宋体 8 正常
            Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//宋体 8.5 正常
            //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//宋体 9 正常
            //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//宋体 9.5 正常
            Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//宋体 10 正常
            //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//宋体 10.5 正常
            //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//宋体 11 正常
            Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//宋体 12 正常
            //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//宋体 12.5 正常
            
            //宋体 粗体
            Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//宋体 10 粗体
            //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//宋体 10.5 粗体
            //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//宋体 11 粗体
            //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//宋体 12 粗体
            Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//宋体 15 粗体
            
            //宋体 斜体
            //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//宋体 10 斜体
            
            
            //西文字体
            //times new Roman 正常
            //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 正常
            Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 正常
            //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 正常
            //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 正常
            Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 正常
            
            //times new Roman 粗体
            Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 粗体
            Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 粗体
            Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 粗体
            Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 粗体
            //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 粗体
            
            //times new Roman 斜体
            Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 斜体
            
            //HELVETICA 正常
            Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 正常
            //HELVETICA 粗体
            Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 粗体
            
            String isFB = "1";//档案副本
            String isGY = "1";//是否公约
            
            //中文标题
            Paragraph ParagraphTitleCN = new Paragraph("来 华 收 养 子 女 通 知 书", FontCN_HEI20B);
            ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleCN);
            //英文标题
            Paragraph ParagraphTitleEN = new Paragraph("Notice of Travelling to China for Adoption", FontEN_T12B);
            ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
            if("0".equals(isFB)){
                ParagraphTitleEN.setSpacingAfter(20);
            }
            document.add(ParagraphTitleEN);
            if("1".equals(isFB)){
                //档案副本
                Paragraph ParagraphTitleFB = new Paragraph("（副    本）", FontCN_SONG15B);
                ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
                document.add(ParagraphTitleFB);
            }
            //文件编号
            String fileCode = "(2012) YD-0147-08-0432";//文件编号即收养人文件收文编号
            Paragraph ParagraphFileCode = new Paragraph(fileCode, FontEN_T14B);
            ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
            ParagraphFileCode.setSpacingAfter(5);
            document.add(ParagraphFileCode);
            //收养人称呼
            String maleName = "GIULIANO CASSINADRI";//男收养人
            Paragraph ParagraphMaleName = new Paragraph("MR."+maleName, FontCN_SONG12N);
            document.add(ParagraphMaleName);
            String femaleName = "MARIALUISA RABITTI";//女收养人
            Paragraph ParagraphFemaleName = new Paragraph("& MRS."+femaleName+":", FontCN_SONG12N);
            //ParagraphFemaleName.setSpacingAfter(10);//与下段相隔
            document.add(ParagraphFemaleName);
            //中文正文
            Paragraph ParagraphContextCN = new Paragraph();
            ParagraphContextCN.setFirstLineIndent(20);//首行缩进
            Phrase PhraseContextCN1 = new Phrase();
            if("0".equals(isGY)){//非公约
                PhraseContextCN1 = new Phrase("根据《中华人民共和国收养法》，经审查，同意你们收养", FontCN_SONG10N);
            }
            if("1".equals(isGY)){//公约
                PhraseContextCN1 = new Phrase("根据《中华人民共和国收养法》和《跨国收养方面保护儿童及合作公约》，经审查，同意你们收养", FontCN_SONG10N);
            }
            ParagraphContextCN.add(PhraseContextCN1);
            String SWI_CN = "广西壮族自治区南宁市邕宁区社会福利院";//福利院
            Phrase PhraseContextCN2 = new Phrase(SWI_CN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN2);
            Phrase PhraseContextCN3 = new Phrase("抚养的", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN3);
            String nameCN = "宁福向";//儿童姓名
            Phrase PhraseContextCN4 = new Phrase(nameCN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN4);
            Phrase PhraseContextCN5 = new Phrase("。请你们持本通知亲自到中国", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN5);
            String provinceCN = "广西壮族自治区";//省份
            Phrase PhraseContextCN6 = new Phrase(provinceCN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN6);
            Phrase PhraseContextCN7 = new Phrase("民政厅收养登记机关办理收养登记手续。", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN7);
            ParagraphContextCN.setLeading(20f);
            document.add(ParagraphContextCN);
            //英文正文
            Paragraph ParagraphContextEN = new Paragraph();
            ParagraphContextEN.setFirstLineIndent(20);//首行缩进
            Phrase PhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN1);
            Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China", FontEN_T11I);
            ParagraphContextEN.add(PhraseContextEN2);
            if("1".equals(isGY)){//公约
                Phrase PhraseContextEN2GY1 = new Phrase(" and the ", FontEN_T11N);
                ParagraphContextEN.add(PhraseContextEN2GY1);
                
                Phrase PhraseContextEN2GY2 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption", FontEN_T11I);
                ParagraphContextEN.add(PhraseContextEN2GY2);
            }
            Phrase PhraseContextEN3 = new Phrase(",we agreed that the child,", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN3);
            String nameEN = "NING FU XIANG";//儿童姓名
            Phrase PhraseContextEN4 = new Phrase(nameEN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN4);
            Phrase PhraseContextEN5 = new Phrase(",who is in the care of ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN5);
            String SWI_EN = "SWI of Yongning Dist.,Nanning Guangxi Province";//福利院
            Phrase PhraseContextEN6 = new Phrase(SWI_EN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN6);
            Phrase PhraseContextEN7 = new Phrase(",be place with you for adoption.Please travel in person with this notice to the adoption registry office within the Civil Affairs Department of ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN7);
            String provinceEN = "Guangxi Province";//省份
            Phrase PhraseContextEN8 = new Phrase(provinceEN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN8);
            Phrase PhraseContextEN9 = new Phrase("in China to proceed the registration formalities.", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN9);
            ParagraphContextEN.setLeading(20f);
            ParagraphContextEN.setSpacingAfter(25);//与下段相隔
            document.add(ParagraphContextEN);
            
            PdfPTable Table1 = new PdfPTable(2);
            Table1.setTotalWidth(width);
            Table1.setLockedWidth(true);
            
            PdfPCell Table1_cell1 = new PdfPCell();
            Paragraph Paragraph_Adopted = new Paragraph();
            Phrase Phrase_Adopted1 = new Phrase("被收养人姓名 ", FontCN_SONG10N);
            Paragraph_Adopted.add(Phrase_Adopted1);
            Phrase Phrase_Adopted2 = new Phrase("Name of Adopted Child:", FontEN_H7N);
            Paragraph_Adopted.add(Phrase_Adopted2);
            Table1_cell1.addElement(Paragraph_Adopted);
            Table1_cell1.setBorder(0);
            Table1.addCell(Table1_cell1);
            
            PdfPCell Table1_cell2 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Father = new Paragraph();
            Phrase Phrase_Adoptive_Father1 = new Phrase("预收养父亲姓名 ", FontCN_SONG10N);
            Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father1);
            Phrase Phrase_Adoptive_Father2 = new Phrase("Name of Prospective Adoptive Father:", FontEN_H7N);
            Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father2);
            Table1_cell2.addElement(Paragraph_Adoptive_Father);
            Table1_cell2.setBorder(0);
            Table1.addCell(Table1_cell2);
            
            PdfPCell Table1_cell3 = new PdfPCell();
            String Adopted_Name = "宁福向";
            Table1_cell3.addElement(new Paragraph(Adopted_Name, FontCN_SONG10B));
            Table1_cell3.setBorder(0);
            Table1.addCell(Table1_cell3);
            
            PdfPCell Table1_cell4 = new PdfPCell();
            String Adoptive_Father_Name = "GIULIANO CASSINADRI JUNIROU";
            Table1_cell4.addElement(new Paragraph(Adoptive_Father_Name, FontEN_H10B));
            Table1_cell4.setBorder(0);
            Table1.addCell(Table1_cell4);
            
            
            PdfPCell Table1_cell5 = new PdfPCell();
            Paragraph Paragraph_Adopted_Sex = new Paragraph();
            Phrase Phrase_Adopted_Sex1 = new Phrase("性别 ", FontCN_SONG10N);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex1);
            Phrase Phrase_Adopted_Sex2 = new Phrase("Sex: ", FontEN_H7N);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex2);
            String Adopted_Sex = "女";
            Phrase Phrase_Adopted_Sex3 = new Phrase(Adopted_Sex, FontCN_SONG10B);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex3);
            Table1_cell5.addElement(Paragraph_Adopted_Sex);
            Table1_cell5.setBorder(0);
            Table1.addCell(Table1_cell5);
            
            
            PdfPCell Table1_cell6 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Father_DOB = new Paragraph();
            Phrase Phrase_Adoptive_Father_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
            Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB1);
            Phrase Phrase_Adoptive_Father_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
            Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB2);
            String Adoptive_Father_DOB = "1958-03-06";
            Phrase Phrase_Adoptive_Father_DOB3 = new Phrase(Adoptive_Father_DOB, FontEN_H10B);
            Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB3);
            Table1_cell6.addElement(Paragraph_Adoptive_Father_DOB);
            Table1_cell6.setBorder(0);
            Table1.addCell(Table1_cell6);
            
            PdfPCell Table1_cell7 = new PdfPCell();
            Paragraph Paragraph_Adopted_DOB = new Paragraph();
            Phrase Phrase_Adoped_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
            Paragraph_Adopted_DOB.add(Phrase_Adoped_DOB1);
            Phrase Phrase_Adopted_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
            Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB2);
            String Adopted_DOB = "2011-02-20";
            Phrase Phrase_Adopted_DOB3 = new Phrase(Adopted_DOB, FontEN_H10B);
            Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB3);
            Table1_cell7.addElement(Paragraph_Adoptive_Father_DOB);
            Table1_cell7.setBorder(0);
            Table1.addCell(Table1_cell7);
            
            PdfPCell Table1_cell8 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Mother = new Paragraph();
            Phrase Phrase_Adoptive_Mother1 = new Phrase("预收养母亲姓名 ", FontCN_SONG10N);
            Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother1);
            Phrase Phrase_Adoptive_Mother2 = new Phrase("Name of Prospective Adoptive Mother:", FontEN_H7N);
            Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother2);
            Table1_cell8.addElement(Paragraph_Adoptive_Mother);
            Table1_cell8.setBorder(0);
            Table1.addCell(Table1_cell8);
            
            PdfPCell Table1_cell9 = new PdfPCell();
            Paragraph Paragraph_Adopted_Add = new Paragraph();
            Phrase Phrase_Adopted_Add1 = new Phrase("所在地 ", FontCN_SONG10N);
            Paragraph_Adopted_Add.add(Phrase_Adopted_Add1);
            Phrase Phrase_Adopted_Add2 = new Phrase("Residential information(SWI/Address):", FontEN_H7N);
            Paragraph_Adopted_Add.add(Phrase_Adopted_Add2);
            Table1_cell9.addElement(Paragraph_Adopted_Add);
            Table1_cell9.setBorder(0);
            Table1.addCell(Table1_cell9);
            
            PdfPCell Table1_cell10 = new PdfPCell();
            String Adoptive_Mother_Name = "MARIALUISA RABITTI JUNIROU";
            Table1_cell10.addElement(new Paragraph(Adoptive_Mother_Name, FontEN_H10B));
            Table1_cell10.setBorder(0);
            Table1.addCell(Table1_cell10);
            
            PdfPCell Table1_cell11 = new PdfPCell();
            String Adopted_Address = "广西壮族自治区南宁市邕宁区社会福利院";
            Table1_cell11.addElement(new Paragraph(Adopted_Address, FontCN_SONG10B));
            Table1_cell11.setBorder(0);
            Table1.addCell(Table1_cell11);
            
            PdfPCell Table1_cell12 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Mother_DOB = new Paragraph();
            Phrase Phrase_Adoptive_Mother_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
            Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB1);
            Phrase Phrase_Adoptive_Mother_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
            Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB2);
            String Adoptive_Mother_DOB = "1958-03-06";
            Phrase Phrase_Adoptive_Mother_DOB3 = new Phrase(Adoptive_Mother_DOB, FontEN_H10B);
            Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB3);
            Table1_cell12.addElement(Paragraph_Adoptive_Mother_DOB);
            Table1_cell12.setBorder(0);
            Table1.addCell(Table1_cell12);
            Table1.writeSelectedRows(0, -1, 80, 420, writer.getDirectContent());
            
            
            Image photograph = Image.getInstance("C:/Users/xugaoyang/Desktop/1.PNG");
            photograph.setAbsolutePosition(95, 160);
            photograph.scaleAbsolute(72f, 100f);
            document.add(photograph);
            
            PdfPTable Table2 = new PdfPTable(1);
            Table2.setTotalWidth(width-190);
            Table2.setLockedWidth(true);
            
            PdfPCell Table2_cell1 = new PdfPCell(new Paragraph("  中国儿童福利和收养中心", FontCN_SONG15B));
            Table2_cell1.setBorder(0);
            Table2_cell1.setFixedHeight(25f);
            Table2_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell1);
            
            PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("China Center for Children's Welfare and Adoption", FontEN_T10B));
            Table2_cell2.setBorder(0);
            Table2_cell2.setFixedHeight(18f);
            Table2_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell2);
            
            PdfPCell Table2_cell3 = new PdfPCell(new Paragraph("2012年10月19日", FontCN_SONG10N));
            Table2_cell3.setBorder(0);
            Table2_cell3.setFixedHeight(18f);
            Table2_cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell3);
            
            PdfPCell Table2_cell4 = new PdfPCell(new Paragraph("地址：中国北京市东城区王家园胡同16号", FontCN_SONG8_5N));
            Table2_cell4.setBorder(0);
            Table2_cell4.setFixedHeight(18f);
            Table2_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell4);
            
            PdfPCell Table2_cell5 = new PdfPCell(new Paragraph("Address: No.16,Wangjiayuan Lane,Dongcheng District,Beijing,China", FontEN_T8_5N));
            Table2_cell5.setBorder(0);
            Table2_cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell5);
            
            Table2.writeSelectedRows(0, -1, 275, 250, writer.getDirectContent());
            
            PdfPTable Table3 = new PdfPTable(1);
            Table3.setTotalWidth(width);
            Table3.setLockedWidth(true);
            
            PdfPCell Table3_cell1 = new PdfPCell(new Paragraph("注：本通知书自签发之日起三个月内有效。", FontCN_HEI10B));
            Table3_cell1.setFixedHeight(18f);
            Table3_cell1.setBorder(0);
            Table3.addCell(Table3_cell1);
            
            PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("Note:This Notice is valid within three mmonths from the date of issuance.", FontEN_H10B));
            Table3_cell2.setBorder(0);
            Table3.addCell(Table3_cell2);
            
            Table3.writeSelectedRows(0, -1, 80, 130, writer.getDirectContent());
            
            document.close();
            /*File file = new File(PDFpath);
            String attTypeCode = "AR";
            String packageId = UUID.getUUID();
            
            AttHelper.manualUploadAtt(file, "OTHER", packageId);*/
            
            return true;
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (DocumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    /**
     * @Title: main
     * @Description: 
     * @author: xugy
     * @date: 2014-9-16下午5:33:27
     * @param args
     */

    public static void main(String[] args) {
        MatchAction ma = new MatchAction();
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            /*String MI_ID = "7dbda188-0be5-4396-bdca-014a1967835d";
            String isFB = "0";
            //ma.noticeOfTravellingToChinaForAdoption(conn, MI_ID, isFB, "1");
            ma.noticeForAdoption(conn, MI_ID, "0");
            ma.noticeForAdoption(conn, MI_ID, "1");*/
            
            InputStream is = pdfTest.class.getClassLoader().getResourceAsStream("upload-config.properties");
            Properties properties = new Properties();
            String tempUpload = properties.getProperty("tempUpload");
            System.out.println(tempUpload);
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
        
        //System.out.println(new pdfTest().iTextTest()); 

    }

}
