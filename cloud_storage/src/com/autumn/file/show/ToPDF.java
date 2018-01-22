package com.autumn.file.show;

import java.io.*;

import org.springframework.stereotype.Component;

import com.artofsolving.jodconverter.*;

import com.artofsolving.jodconverter.openoffice.connection.*;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.artofsolving.jodconverter.openoffice.converter.StreamOpenOfficeDocumentConverter;
@Component
public class ToPDF {
	/*public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		ToPDF tp=new ToPDF();
		String src="D:/Documents/新老生见面会签到表.doc";
		String des="D:/3.pdf";
		tp.createPDF(src,des);

	}*/
	 
	public String createPDF(String srcpath,String despath,String url) throws Exception{
		File inputFile=new File(srcpath);
		File File=new File(despath);
		if(File.exists()){
			System.out.println("目标文件存在！");
			return null;
		}
		File outputFile=new File(despath);
		if(!outputFile.getParentFile().exists()){
			outputFile.getParentFile().exists();
		}
        // connect to an OpenOffice.org instance running on port 8100
		 String command = "C:/Program Files (x86)/OpenOffice 4/program/soffice.exe -headless -accept=\"socket,host="+url+",port=8100;urp;\"";
		 Process p = Runtime.getRuntime().exec(command);
        OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
        connection.connect();
         
        // convert
        DocumentConverter converter = new StreamOpenOfficeDocumentConverter(connection);
        converter.convert(inputFile, outputFile);
         
        // close the connection
        p.destroy();
        connection.disconnect();
        return despath;
        
	}

}
