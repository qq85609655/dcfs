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
            //ʵ�����ĵ�����  
            Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4ֽ���������¿հ�
            
            String PDFpath = "C://Users//xugaoyang//Desktop//11111111.pdf";//����ļ�·��
            // PdfWriter����
            PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
            float width = document.getPageSize().getWidth() - 160;
            document.open();// ���ĵ�
            //pdf�ĵ���������������ã�ע��һ��Ҫ���iTextAsian.jar��
            //��������
            BaseFont bfHEI = BaseFont.createFont("C:\\Windows\\Fonts\\SIMHEI.TTF", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
            //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//��ͨ����
            //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
            //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// ������
            BaseFont bfSONG = BaseFont.createFont("C:\\Windows\\Fonts\\SIMSUN.TTC,0",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
            //���� ����
            Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//���� 10 ����
            //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//���� 11 ����
            //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//���� 12 ����
            //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//���� 16 ����
            Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//���� 20 ����
            //���� ����
            //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//���� 7 ����
            
            //���� ����
            //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//���� 8 ����
            Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//���� 8.5 ����
            //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//���� 9 ����
            //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//���� 9.5 ����
            Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//���� 10 ����
            //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//���� 10.5 ����
            //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//���� 11 ����
            Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
            //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//���� 12.5 ����
            
            //���� ����
            Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//���� 10 ����
            //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//���� 10.5 ����
            //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//���� 11 ����
            //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//���� 12 ����
            Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//���� 15 ����
            
            //���� б��
            //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//���� 10 б��
            
            
            //��������
            //times new Roman ����
            //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 ����
            Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 ����
            //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 ����
            //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 ����
            Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 ����
            
            //times new Roman ����
            Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 ����
            Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 ����
            Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 ����
            Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 ����
            //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 ����
            
            //times new Roman б��
            Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 б��
            
            //HELVETICA ����
            Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 ����
            //HELVETICA ����
            Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 ����
            
            String isFB = "1";//��������
            String isGY = "1";//�Ƿ�Լ
            
            //���ı���
            Paragraph ParagraphTitleCN = new Paragraph("�� �� �� �� �� Ů ͨ ֪ ��", FontCN_HEI20B);
            ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleCN);
            //Ӣ�ı���
            Paragraph ParagraphTitleEN = new Paragraph("Notice of Travelling to China for Adoption", FontEN_T12B);
            ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
            if("0".equals(isFB)){
                ParagraphTitleEN.setSpacingAfter(20);
            }
            document.add(ParagraphTitleEN);
            if("1".equals(isFB)){
                //��������
                Paragraph ParagraphTitleFB = new Paragraph("����    ����", FontCN_SONG15B);
                ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
                document.add(ParagraphTitleFB);
            }
            //�ļ����
            String fileCode = "(2012) YD-0147-08-0432";//�ļ���ż��������ļ����ı��
            Paragraph ParagraphFileCode = new Paragraph(fileCode, FontEN_T14B);
            ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
            ParagraphFileCode.setSpacingAfter(5);
            document.add(ParagraphFileCode);
            //�����˳ƺ�
            String maleName = "GIULIANO CASSINADRI";//��������
            Paragraph ParagraphMaleName = new Paragraph("MR."+maleName, FontCN_SONG12N);
            document.add(ParagraphMaleName);
            String femaleName = "MARIALUISA RABITTI";//Ů������
            Paragraph ParagraphFemaleName = new Paragraph("& MRS."+femaleName+":", FontCN_SONG12N);
            //ParagraphFemaleName.setSpacingAfter(10);//���¶����
            document.add(ParagraphFemaleName);
            //��������
            Paragraph ParagraphContextCN = new Paragraph();
            ParagraphContextCN.setFirstLineIndent(20);//��������
            Phrase PhraseContextCN1 = new Phrase();
            if("0".equals(isGY)){//�ǹ�Լ
                PhraseContextCN1 = new Phrase("���ݡ��л����񹲺͹���������������飬ͬ����������", FontCN_SONG10N);
            }
            if("1".equals(isGY)){//��Լ
                PhraseContextCN1 = new Phrase("���ݡ��л����񹲺͹����������͡�����������汣����ͯ��������Լ��������飬ͬ����������", FontCN_SONG10N);
            }
            ParagraphContextCN.add(PhraseContextCN1);
            String SWI_CN = "����׳����������������������ḣ��Ժ";//����Ժ
            Phrase PhraseContextCN2 = new Phrase(SWI_CN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN2);
            Phrase PhraseContextCN3 = new Phrase("������", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN3);
            String nameCN = "������";//��ͯ����
            Phrase PhraseContextCN4 = new Phrase(nameCN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN4);
            Phrase PhraseContextCN5 = new Phrase("�������ǳֱ�֪ͨ���Ե��й�", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN5);
            String provinceCN = "����׳��������";//ʡ��
            Phrase PhraseContextCN6 = new Phrase(provinceCN, FontCN_SONG10B);
            ParagraphContextCN.add(PhraseContextCN6);
            Phrase PhraseContextCN7 = new Phrase("�����������Ǽǻ��ذ��������Ǽ�������", FontCN_SONG10N);
            ParagraphContextCN.add(PhraseContextCN7);
            ParagraphContextCN.setLeading(20f);
            document.add(ParagraphContextCN);
            //Ӣ������
            Paragraph ParagraphContextEN = new Paragraph();
            ParagraphContextEN.setFirstLineIndent(20);//��������
            Phrase PhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN1);
            Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China", FontEN_T11I);
            ParagraphContextEN.add(PhraseContextEN2);
            if("1".equals(isGY)){//��Լ
                Phrase PhraseContextEN2GY1 = new Phrase(" and the ", FontEN_T11N);
                ParagraphContextEN.add(PhraseContextEN2GY1);
                
                Phrase PhraseContextEN2GY2 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption", FontEN_T11I);
                ParagraphContextEN.add(PhraseContextEN2GY2);
            }
            Phrase PhraseContextEN3 = new Phrase(",we agreed that the child,", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN3);
            String nameEN = "NING FU XIANG";//��ͯ����
            Phrase PhraseContextEN4 = new Phrase(nameEN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN4);
            Phrase PhraseContextEN5 = new Phrase(",who is in the care of ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN5);
            String SWI_EN = "SWI of Yongning Dist.,Nanning Guangxi Province";//����Ժ
            Phrase PhraseContextEN6 = new Phrase(SWI_EN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN6);
            Phrase PhraseContextEN7 = new Phrase(",be place with you for adoption.Please travel in person with this notice to the adoption registry office within the Civil Affairs Department of ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN7);
            String provinceEN = "Guangxi Province";//ʡ��
            Phrase PhraseContextEN8 = new Phrase(provinceEN, FontEN_T11B);
            ParagraphContextEN.add(PhraseContextEN8);
            Phrase PhraseContextEN9 = new Phrase("in China to proceed the registration formalities.", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN9);
            ParagraphContextEN.setLeading(20f);
            ParagraphContextEN.setSpacingAfter(25);//���¶����
            document.add(ParagraphContextEN);
            
            PdfPTable Table1 = new PdfPTable(2);
            Table1.setTotalWidth(width);
            Table1.setLockedWidth(true);
            
            PdfPCell Table1_cell1 = new PdfPCell();
            Paragraph Paragraph_Adopted = new Paragraph();
            Phrase Phrase_Adopted1 = new Phrase("������������ ", FontCN_SONG10N);
            Paragraph_Adopted.add(Phrase_Adopted1);
            Phrase Phrase_Adopted2 = new Phrase("Name of Adopted Child:", FontEN_H7N);
            Paragraph_Adopted.add(Phrase_Adopted2);
            Table1_cell1.addElement(Paragraph_Adopted);
            Table1_cell1.setBorder(0);
            Table1.addCell(Table1_cell1);
            
            PdfPCell Table1_cell2 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Father = new Paragraph();
            Phrase Phrase_Adoptive_Father1 = new Phrase("Ԥ������������ ", FontCN_SONG10N);
            Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father1);
            Phrase Phrase_Adoptive_Father2 = new Phrase("Name of Prospective Adoptive Father:", FontEN_H7N);
            Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father2);
            Table1_cell2.addElement(Paragraph_Adoptive_Father);
            Table1_cell2.setBorder(0);
            Table1.addCell(Table1_cell2);
            
            PdfPCell Table1_cell3 = new PdfPCell();
            String Adopted_Name = "������";
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
            Phrase Phrase_Adopted_Sex1 = new Phrase("�Ա� ", FontCN_SONG10N);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex1);
            Phrase Phrase_Adopted_Sex2 = new Phrase("Sex: ", FontEN_H7N);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex2);
            String Adopted_Sex = "Ů";
            Phrase Phrase_Adopted_Sex3 = new Phrase(Adopted_Sex, FontCN_SONG10B);
            Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex3);
            Table1_cell5.addElement(Paragraph_Adopted_Sex);
            Table1_cell5.setBorder(0);
            Table1.addCell(Table1_cell5);
            
            
            PdfPCell Table1_cell6 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Father_DOB = new Paragraph();
            Phrase Phrase_Adoptive_Father_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
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
            Phrase Phrase_Adoped_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
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
            Phrase Phrase_Adoptive_Mother1 = new Phrase("Ԥ����ĸ������ ", FontCN_SONG10N);
            Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother1);
            Phrase Phrase_Adoptive_Mother2 = new Phrase("Name of Prospective Adoptive Mother:", FontEN_H7N);
            Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother2);
            Table1_cell8.addElement(Paragraph_Adoptive_Mother);
            Table1_cell8.setBorder(0);
            Table1.addCell(Table1_cell8);
            
            PdfPCell Table1_cell9 = new PdfPCell();
            Paragraph Paragraph_Adopted_Add = new Paragraph();
            Phrase Phrase_Adopted_Add1 = new Phrase("���ڵ� ", FontCN_SONG10N);
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
            String Adopted_Address = "����׳����������������������ḣ��Ժ";
            Table1_cell11.addElement(new Paragraph(Adopted_Address, FontCN_SONG10B));
            Table1_cell11.setBorder(0);
            Table1.addCell(Table1_cell11);
            
            PdfPCell Table1_cell12 = new PdfPCell();
            Paragraph Paragraph_Adoptive_Mother_DOB = new Paragraph();
            Phrase Phrase_Adoptive_Mother_DOB1 = new Phrase("�������� ", FontCN_SONG10N);
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
            
            PdfPCell Table2_cell1 = new PdfPCell(new Paragraph("  �й���ͯ��������������", FontCN_SONG15B));
            Table2_cell1.setBorder(0);
            Table2_cell1.setFixedHeight(25f);
            Table2_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell1);
            
            PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("China Center for Children's Welfare and Adoption", FontEN_T10B));
            Table2_cell2.setBorder(0);
            Table2_cell2.setFixedHeight(18f);
            Table2_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell2);
            
            PdfPCell Table2_cell3 = new PdfPCell(new Paragraph("2012��10��19��", FontCN_SONG10N));
            Table2_cell3.setBorder(0);
            Table2_cell3.setFixedHeight(18f);
            Table2_cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
            Table2.addCell(Table2_cell3);
            
            PdfPCell Table2_cell4 = new PdfPCell(new Paragraph("��ַ���й������ж���������԰��ͬ16��", FontCN_SONG8_5N));
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
            
            PdfPCell Table3_cell1 = new PdfPCell(new Paragraph("ע����֪ͨ����ǩ��֮��������������Ч��", FontCN_HEI10B));
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
     * @date: 2014-9-16����5:33:27
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
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
        
        //System.out.println(new pdfTest().iTextTest()); 

    }

}
