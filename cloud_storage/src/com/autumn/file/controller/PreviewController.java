package com.autumn.file.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.autumn.file.service.FolderFileService;
import com.autumn.file.show.ToPDF;

@Controller
@RequestMapping("/preview")
public class PreviewController {
	
	@Resource
	private FolderFileService folderFileService;
	@Resource
	private ToPDF toPDF;
	
	@RequestMapping(value="/pdf.do",produces="text/html;charset=UTF-8;")
	public @ResponseBody String getPdf(int subfolderid,String filename,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String path = folderFileService.downByIds(subfolderid);
		System.out.println(path);
		String [] pathF=path.split("\\.");
		String laString=pathF[pathF.length-1];
		ServletContext sc = request.getSession().getServletContext();  
        // 上传位置  
        
		if(laString.equals("doc")||laString.equals("docx")||laString.equals("xlsx")||laString.equals("xls")||laString.equals("ppt")||laString.equals("pptx")){
			String pathaa = sc.getRealPath("/generic/web/pdf/");
	        System.out.println(pathaa);
			/*String pdfname=UUID.randomUUID().toString().replaceAll("-", "")+".pdf";
			String despath=pathaa+pdfname;*/
	        String [] pathFs=filename.split("\\.");
			String lastn=pathFs[0]+".pdf";
	        String despath=pathaa+lastn;
	        
			 String url= request.getServerName();
			 System.out.println("预览文件pdf的临时路径"+despath);
			String newPath= toPDF.createPDF(path, despath,url);
			if(newPath==null){
				//response.getWriter().print("<script> window.open('http://"+url+":8080/cloud_storage/generic/web/viewer.html?file=pdf/"+pdfname+"',false);</script>");
				return lastn;
				
			}
			return lastn;
			
			
		}
		else if(laString.equals("mp3")||laString.equals("mp4")){
			String pathaa = sc.getRealPath("/audio/");
	        System.out.println(pathaa);
			/*String pdfname=UUID.randomUUID().toString().replaceAll("-", "")+"."+laString;
			String despath=pathaa+pdfname;*/
	        String despath=pathaa+filename;
			File f = new File(despath);  
			if(f.exists()){
				System.out.println("目标文件存在！");
				return filename;
			}   
		         
		            try {  
		                FileOutputStream fos = new FileOutputStream(despath); 
		                FileInputStream in=new FileInputStream(path);
		               // InputStream in = f.getInputStream();  
		                int b = 0;  
		                while ((b = in.read()) != -1) {  
		                    fos.write(b); 
		                }  
		                fos.close();  
		                in.close();  
		            } catch (Exception e) {  
		                e.printStackTrace();  
		            }  
		        
			return filename;
		}
		
		
		return null;
	}
	@RequestMapping("/toPlay.do")
	public String to(){
		
		return "copy";
	}
	
	

}
