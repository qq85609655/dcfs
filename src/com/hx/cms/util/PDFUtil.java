package com.hx.cms.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.util.PDFTextStripper;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.List;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * PDF��д��
 * @author lij
 *
 */
public class PDFUtil {

	//public static final String CHARACTOR_FONT_CH_FILE = "SIMFANG.TTF";  //���γ���   
	public static final String CHARACTOR_FONT_CH_FILE = "SIMHEI.TTF"; //���峣��   
	public static final Rectangle PAGE_SIZE = PageSize.A4;
	public static final float MARGIN_LEFT = 50;
	public static final float MARGIN_RIGHT = 50;
	public static final float MARGIN_TOP = 50;
	public static final float MARGIN_BOTTOM = 50;
	public static final float SPACING = 20;

	private Document document = null;

	/**  
	 * ���ܣ������������ݵ�Ŀ���ĵ�  
	 * @param fileName �洢�ļ�����ʱ·��  
	 * @return   
	 */
	public void createDocument(String fileName) {
		File file = new File(fileName);
		FileOutputStream out = null;
		document = new Document(PAGE_SIZE, MARGIN_LEFT, MARGIN_RIGHT,MARGIN_TOP, MARGIN_BOTTOM);
		try {
			out = new FileOutputStream(file);
			//PdfWriter writer =    
			PdfWriter.getInstance(document, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ���ĵ�׼��д������   
		document.open();
	}

	/**  
	 * ���½�д�뵽ָ����PDF�ĵ���  
	 * @param chapter  
	 * @return   
	 */
	public void writeChapterToDoc(Chapter chapter) {
		try {
			if (document != null) {
				if (!document.isOpen())
					document.open();
				document.add(chapter);
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}

	/**  
	 * ����  ����PDF�ĵ��е��½�  
	 * @param title �½ڱ���  
	 * @param chapterNum �½����к�  
	 * @param alignment 0��ʾalign=left��1��ʾalign=center  
	 * @param numberDepth �½��Ƿ����� ��ֵ=1 ��ʾ����� 1.�½�һ��1.1С��һ...����ֵ=0��ʾ�������  
	 * @param font �����ʽ  
	 * @return Chapter�½�  
	 */
	public static Chapter createChapter(String title, int chapterNum, int alignment, int numberDepth, Font font) {
		Paragraph chapterTitle = new Paragraph(title, font);
		chapterTitle.setAlignment(alignment);
		Chapter chapter = new Chapter(chapterTitle, chapterNum);
		chapter.setNumberDepth(numberDepth);
		return chapter;
	}

	/**  
	 * ���ܣ�����ĳָ���½��µ�С��  
	 * @param chapter ָ���½�  
	 * @param title С�ڱ���  
	 * @param font �����ʽ  
	 * @param numberDepth С���Ƿ����� ��ֵ=1 ��ʾ����� 1.�½�һ��1.1С��һ...����ֵ=0��ʾ�������  
	 * @return section��ָ���½ں�׷��С��  
	 */
	public static Section createSection(Chapter chapter, String title, Font font, int numberDepth) {
		Section section = null;
		if (chapter != null) {
			Paragraph sectionTitle = new Paragraph(title, font);
			sectionTitle.setSpacingBefore(SPACING);
			section = chapter.addSection(sectionTitle);
			section.setNumberDepth(numberDepth);
		}
		return section;
	}

	/**  
	 * ���ܣ���PDF�ĵ������ӵ�����  
	 * @param text ����  
	 * @param font ���ݶ�Ӧ������  
	 * @return phrase ָ�������ʽ������  
	 */
	public static Phrase createPhrase(String text, Font font) {
		Phrase phrase = new Paragraph(text, font);
		return phrase;
	}

	/**  
	 * ���ܣ������б�  
	 * @param numbered  ����Ϊ true �����봴��һ�����б�ŵ��б�  
	 * @param lettered ����Ϊtrue��ʾ�б�������ĸ���б�ţ�Ϊfalse�������ֽ��б��  
	 * @param symbolIndent  
	 * @return list  
	 */
	public static List createList(boolean numbered, boolean lettered, float symbolIndent) {
		List list = new List(numbered, lettered, symbolIndent);
		return list;
	}

	/**  
	 * ���ܣ������б��е���  
	 * @param content �б����е�����  
	 * @param font �����ʽ  
	 * @return listItem  
	 */
	public static ListItem createListItem(String content, Font font) {
		ListItem listItem = new ListItem(content, font);
		return listItem;
	}

	/**  
	 * ���ܣ����������ʽ  
	 * @param fontname   
	 * @param size �����С  
	 * @param style ������  
	 * @param color ������ɫ  
	 * @return Font  
	 */
	public static Font createFont(String fontname, float size, int style, BaseColor color) {
		Font font = FontFactory.getFont(fontname, size, style, color);
		return font;
	}

	/**  
	 * ���ܣ� ����֧�����ĵ�����---����  
	 * @param size �����С  
	 * @param style ������  
	 * @param color ���� ��ɫ  
	 * @return  �����ʽ  
	 */
	public static Font createCHineseFont(float size, int style, BaseColor color) {
		BaseFont bfChinese = null;
		try {
			bfChinese = BaseFont.createFont(CHARACTOR_FONT_CH_FILE, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new Font(bfChinese, size, style, color);
	}

	/**  
	 * ���ر�PDF�ĵ�  
	 */
	public void closeDocument() {
		if (document != null) {
			document.close();
		}
	}

	/**  
	 * ��PDF�ļ���ʹ����pdfbox��Դ��Ŀ  
	 * @param fileName  
	 */
	public static void readPDF(String fileName) {
		File file = new File(fileName);
		FileInputStream in = null;
		try {
			in = new FileInputStream(fileName);
			// �½�һ��PDF����������   
			PDFParser parser = new PDFParser(in);
			// ��PDF�ļ����н���   
			parser.parse();
			// ��ȡ������õ���PDF�ĵ�����   
			PDDocument pdfdocument = parser.getPDDocument();
			// �½�һ��PDF�ı�������   
			PDFTextStripper stripper = new PDFTextStripper();
			// ��PDF�ĵ������а����ı�   
			String result = stripper.getText(pdfdocument);
			System.out.println("PDF�ļ����ı��������£�");
			System.out.println(result);

		} catch (Exception e) {
			System.out.println("��ȡPDF�ļ�" + file.getAbsolutePath() + "��ʧ�ܣ�" + e);
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e1) {
				}
			}
		}
	}
	
	public static String readPDF(File file) {
		String result = "";
		if(file == null || !file.exists()){
			return result;
		}
		
		FileInputStream in = null;
		try {
			in = new FileInputStream(file);
			// �½�һ��PDF����������   
			PDFParser parser = new PDFParser(in);
			// ��PDF�ļ����н���   
			parser.parse();
			// ��ȡ������õ���PDF�ĵ�����   
			PDDocument pdfdocument = parser.getPDDocument();
			// �½�һ��PDF�ı�������   
			PDFTextStripper stripper = new PDFTextStripper();
			// ��PDF�ĵ������а����ı�   
			result = stripper.getText(pdfdocument);
			/*System.out.println("PDF�ļ����ı��������£�");
			System.out.println(result);*/
		} catch (Exception e) {
			System.out.println("��ȡPDF�ļ�" + file.getAbsolutePath() + "ʱʧ�ܣ�" + e);
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e1) {
				}
			}
		}
		return result;
	}

	/**  
	 * ����pdf�ļ��Ĵ���  
	 * @param args  
	 */
	public static void main(String[] args) {

		/*
		String fileName = "C:1.pdf"; //�������ֶ��Ѿ���·�����ļ��и����ϡ�   
		PDFUtil pdfUtil = new PDFUtil();

		Font chapterFont = PDFUtil.createCHineseFont(20, Font.BOLD,
				new BaseColor(0, 0, 255));//���±�������   
		Font sectionFont = PDFUtil.createCHineseFont(16, Font.BOLD,
				new BaseColor(0, 0, 255));//����С������   
		Font textFont = PDFUtil.createCHineseFont(10, Font.NORMAL,
				new BaseColor(0, 0, 0));//С����������   

		pdfUtil.createDocument(fileName);
		Chapter chapter = PDFUtil.createChapter("���򲡲���1", 1, 1, 0, chapterFont);
		Section section1 = PDFUtil.createSection(chapter, "������ϵ����Ϣ", sectionFont, 0);
		Phrase text1 = PDFUtil.createPhrase("����������ͬ���ֳɲ���������д�����ϻ�����Ϣ�󣬴���������", textFont);
		section1.add(text1);

		Section section2 = PDFUtil.createSection(chapter, "�����������", sectionFont, 0);
		Phrase text2 = PDFUtil.createPhrase("1.���ز�������PDF�ĵ�", textFont);
		//text2.setFirstLineIndent(20);  //��һ�пո����   
		section2.add(text1);
		section2.add(text2);

		List list = PDFUtil.createList(true, false, 20);
		String tmp = "����ʲô�ܹ��ĵ����ĵ��� PDF �ĵ�������Ԫ�ص������� ";
		ListItem listItem1 = PDFUtil.createListItem(tmp, textFont);
		ListItem listItem2 = PDFUtil.createListItem("�б�2", textFont);
		list.add(listItem1);
		list.add(listItem2);
		section2.add(list);

		pdfUtil.writeChapterToDoc(chapter);
		pdfUtil.closeDocument();
		*/
		
		PDFUtil.readPDF("C:\\1.pdf");
	}
}