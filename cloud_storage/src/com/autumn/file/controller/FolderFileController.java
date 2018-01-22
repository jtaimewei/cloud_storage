package com.autumn.file.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.autumn.commons.DateUtils;
import com.autumn.commons.RandomCode;
import com.autumn.file.model.FilePackage;
import com.autumn.file.model.FolderFile;
import com.autumn.file.model.PagingInfo;
import com.autumn.file.model.PictureShowPackge;
import com.autumn.file.model.Share;
import com.autumn.file.service.FolderFileService;
import com.autumn.user.model.User;

@Controller
@RequestMapping("/file")
public class FolderFileController {
	@Resource
	private FolderFile folderFile;
	@Resource
	private Share share;
	@Resource
	private FilePackage filePackage;
	@Resource
	private FolderFileService folderFileService;
	@Resource
	private PictureShowPackge pictureShowPacke;
	@Resource
	private PagingInfo pagingInfo;
	//用户登录成功之后，根据用户名去遍历用户的文件结构
	Map<Integer,String> map = null;
	@RequestMapping(value="/listFileStructure.do",produces="text/html;charset=UTF-8;")
	public String findListFileStructure(Model model,int page,String subfolderfolder,int subfolderid,HttpSession session){
		Iterator it = null;
		int f = 0;
		if(subfolderid==0){
			map= new TreeMap<Integer,String>();
			map.put(subfolderid, subfolderfolder);
		}else{
			it = map.keySet().iterator();
			while(it.hasNext()){
				int i = (int) it.next();
				String name = map.get(i);
				
				if(subfolderfolder.equals(name) && i == subfolderid){
					f = 1;
					continue;
				}
				if(f == 1){
					it.remove();
				}
				
			}
			if(f==0){
				map.put(subfolderid, subfolderfolder);
			}
		}
		for (Map.Entry<Integer, String> ma : map.entrySet()) {
			System.out.println(ma.getKey() + "-+++++-" + ma.getValue());
		}
		session.setAttribute("connectList",map);
		
		session.setAttribute("folderfatherid", subfolderid);
		User usersession=(User)session.getAttribute("user");
		filePackage.setUsername(usersession.getUsername());
		filePackage.setPagenumber(20);
		filePackage.setPage(filePackage.getPagenumber()*(page-1));
		filePackage.setFolderfatherid(subfolderid);
		List<FolderFile> folderfile = folderFileService.findListFileStructureByUsername(filePackage);
		
		
		/*int a=(int)session.getAttribute("folderfatherid");
		System.out.println("=----="+a);*/
		/*返回FolderFile集合*/
		model.addAttribute("folderfile",folderfile);
		
		return "main";
	}
	/*添加文件夹-先判断再添加*/
	@RequestMapping(value="/addFolder.do",method=RequestMethod.POST)
	public @ResponseBody FolderFile addFolder(@RequestBody Map<String, String> map,HttpSession session){
		//System.out.println(map.get("foldername"));
		String foldername=map.get("foldername");
		/*根据父级目录id去查询这个目录下所有的文件夹名字
		解决创建文件夹时候同名*/
		
		folderFile.setSubfolderfile("");
		folderFile.setFolderid((int)session.getAttribute("folderid"));
		folderFile.setSubfolderfather((int)session.getAttribute("folderfatherid"));
		folderFile.setSubfolderfolder(foldername);
		FolderFile folderFile1=folderFileService.findFolderNameList(folderFile);
			if(folderFile1!=null){
				folderFile.setSubfolderfolder("");
				return folderFile;
			}
		
			folderFile.setSubfolderfolder(foldername);//文件夹名字
			folderFile.setFolderid((int)session.getAttribute("folderid"));//根目录id
			folderFile.setSubfoldersize(0);//文件夹大小
			folderFile.setSubfolderdate(DateUtils.getDATE());//存入日期
			folderFile.setSubfolderfather((int)session.getAttribute("folderfatherid"));//父级目录id
			folderFile.setSubfolderflag(1);
			folderFile=  folderFileService.addAndBackFolder(folderFile);
		
			return folderFile;
			
	}
	
	/*判断上传的文件名字在该文件目录下是否已经存在*/
	@RequestMapping("/checkFileName.do")
	public @ResponseBody FolderFile findFile(@RequestBody Map<String, String> map,HttpSession session){
		String filename=map.get("filename");
		folderFile.setSubfolderfolder("");
		folderFile.setFolderid((int)session.getAttribute("folderid"));//根目录
		folderFile.setSubfolderfather((int)session.getAttribute("folderfatherid"));//父级目录
		folderFile.setSubfolderfile(filename);//文件的名字
		FolderFile folderFile1=folderFileService.findFolderNameList(folderFile);
			if(folderFile1!=null){
				folderFile.setSubfolderfile("");
				return folderFile;
			}
		return folderFile;
	}
	
	/*上传文件*/
	@RequestMapping("/uploadFile.do")
	public  String uploadFile(@RequestParam("subfolderfile") CommonsMultipartFile file,String filename,HttpServletRequest request, Model model,HttpSession session){
		String fileName = file.getOriginalFilename();  
       // System.out.println("原始文件名:" + fileName);
        String[] name=fileName.split("\\.");
        String newfilename=filename+"."+name[1]; 
        System.out.println("----+--getSize()--------"+file.getSize()); 
        System.out.println("----+---getBytes()-------"+file.getBytes());
      //  System.out.println("现在文件名:" + newfilename);
        
        
        folderFile.setSubfolderfile(newfilename);//文件名字
		folderFile.setFolderid((int)session.getAttribute("folderid"));//根目录id
		folderFile.setSubfoldersize((int)file.getSize()/1024);//文件夹大小
		folderFile.setSubfolderdate(DateUtils.getDATE());//存入日期
		folderFile.setSubfolderfather((int)session.getAttribute("folderfatherid"));//父级目录id
		folderFile.setSubfolderflag(1);
		
		String path= folderFileService.addFileAndBackPath(folderFile);
        
        
        // 获得项目的路径  
        //ServletContext sc = request.getSession().getServletContext();  
        // 上传位置  
        //String path = sc.getRealPath("/imgs") + "/"; // 设定文件保存的目录  
 
       // String path = "D:/YunPan/";// 设定文件保存的目录
        File f = new File(path);  
        if (!f.exists())  
            f.mkdirs();  
        if (!file.isEmpty()) {  
            try {  
                FileOutputStream fos = new FileOutputStream(path + newfilename);  
                InputStream in = file.getInputStream();  
                int b = 0;  
                while ((b = in.read()) != -1) {  
                    fos.write(b); 
                }  
                fos.close();  
                in.close();  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
      
      //  System.out.println("上传图片到:" + path + newfilename);  
        // 保存文件地址，用于JSP页面回显  
       // model.addAttribute("fileUrl", path + fileName);  
      model.addAttribute("page", 1);
      model.addAttribute("subfolderid", (int)session.getAttribute("folderfatherid"));
      model.addAttribute("subfolderfolder", map.get((int)session.getAttribute("folderfatherid")));
		return "redirect:/file/listFileStructure.do";
	}
	
	//下载文件
	@RequestMapping(value="/batchDownByIds.do")
	public  void batchDownByIds(Integer id, HttpServletResponse response,HttpServletRequest request) throws Exception, IOException{	
			String path = folderFileService.downByIds(id);
			String fileName = path.split("/")[path.split("/").length-1];
			System.out.println(fileName);
			System.out.println(path);
			File file = new File(path);
			if (!file.exists()) {// 如果文件不存在
				request.setAttribute("message", "您要下载的资源已被删除！！");
				request.getRequestDispatcher("/message.jsp").forward(request,response);
				return;
			}
			response.setHeader("content-disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8"));
			FileInputStream in = new FileInputStream(path);// 读取要下载的文件，保存到文件输入流
			OutputStream out = response.getOutputStream();// 创建输出流
			byte buffer[] = new byte[1024];// 创建缓冲区
			int len = 0;
			while ((len = in.read(buffer)) > 0) {// 循环将输入流中的内容读取到缓冲区当中
				out.write(buffer, 0, len);// 输出缓冲区的内容到浏览器，实现文件下载
			}
			
			out.flush();
			in.close();// 关闭文件输入流
			out.close();// 关闭输出流
	
	}
	
	//添加一条分享记录
	@RequestMapping(value="/shareFile.do")
	public @ResponseBody Share addShare(@RequestBody Share share,Model model,HttpSession session){
		
	
		share.setSharefield(RandomCode.randomHexString(10));//设置标识码
		User usersession=(User)session.getAttribute("user");
		share.setUsername(usersession.getUsername());//设置分享人
		share.setSharedate(DateUtils.getDATE());//分享的时间 系统的时间
		
		//加密的
		if(share.getSharestate()==1){
			share.setSharepassword(RandomCode.randomHexString(6));
		}else {
			//公开的
			
			
		}
		
		//限制天数的 （1天、7天）
		if(share.getSharedaynumber()!=0){
			/*通过calendar来得到分享的截止时间*/
			int num= share.getSharedaynumber();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(share.getSharedate());
			calendar.add(Calendar.DATE, num);
			
			/*得到分享截止时间*/
			share.setShareoverdate(calendar.getTime());//分享的截止时间
			
		}else{
			//永久的	
			
			
		}
		
		Share share1= folderFileService.addShareInfo(share);
		
		
		
		return share1;
		
	}
	
	//跳转到分享页面
	@RequestMapping("getShare/{sharefield}")
	public  String getShareFile(@PathVariable String sharefield,Model model){
		
		share.setSharefield(sharefield);
		Share share1 = folderFileService.findShare(share);
		if(share1==null){
			model.addAttribute("msg",0);
			return "pickUp";
		}
		if(share1.getShareoverdate()!=null){//有限时间
			if(share1.getShareoverdate().before(DateUtils.getDATE())){
				//分享的截止时间小于当前时间（链接失效）
				model.addAttribute("msg",1);
				return "pickUp";
			}else{
				model.addAttribute("msg", 2);
				model.addAttribute("share", share1);
				return "pickUp";
			}
		}
		else if(share1.getShareoverdate()==null){//永久有效
			model.addAttribute("msg", 2);
			model.addAttribute("share", share1);
			return "pickUp";	
		}
		model.addAttribute("msg",0);
		return "pickUp";
	}
	//下载分享文件
	@RequestMapping("/downloudShare.do")
	public @ResponseBody int downloudFile(@RequestBody Share share){
		
		System.out.println(share.getSubfolderid()+"----"+share.getSharefield()+"---"+share.getSharepassword());
		if(!share.getSharepassword().equals("0")){
			Share share1 = folderFileService.findShare(share);
			if(share1==null){
				//return "链接已经被删除";
				return 0;
			}
			if(!share1.getSharepassword().equals(share.getSharepassword())){
				//return "提取码错误";
				return -1;
			}
		}
		return share.getSubfolderid();
	}
	
	//将文件移入回收站
	@RequestMapping(value = "/moveToRecycle.do", method = RequestMethod.POST)
	public @ResponseBody Object  moveToRecycle(int fileid){
		folderFileService.moveToRecycle(fileid);
		return null;
	}
	
	
	//点击回收站、遍历被放入回收站中的内容 并且跳转至回收站界面
	@RequestMapping("/listRecycle.do")
	public String listRecycle(Model model,HttpSession session){
		int userid = (int)session.getAttribute("folderid");
		List<FolderFile> listFolderFile = folderFileService.listRecycle(userid);
		model.addAttribute("listFolderFile",listFolderFile);
		return "recycle";
	}
	
	//将文件从回收站中还原
	@RequestMapping("/recover.do")
	public @ResponseBody Object recover(int fileid,String filename,int filefatherid,HttpSession session){
		int folderid = (int)session.getAttribute("folderid");
		int f = folderFileService.recover(fileid,filename,filefatherid,folderid);
		return f;
	}
	
	//将文件彻底删除
	@RequestMapping("/delfile.do")
	public @ResponseBody Object delfile(int fileid,String filename){
		folderFileService.delfile(fileid,filename);
		return null;
	}
	
	//移动操作   获取目录树
	@RequestMapping("/gainTree.do")
	public @ResponseBody List<FolderFile> gainTree(HttpSession session){
		int folderid=(int)session.getAttribute("folderid");
		List<FolderFile> listFolder = folderFileService.gainTree(folderid);
		return listFolder;
	}
	//移动操作 移动io系统-改变数据库
	@RequestMapping("/moveToTarget.do")
	public @ResponseBody Object moveToTarget(int fileid,String filename,int filefatherid,int targetid,HttpSession session){
		int folderid=(int)session.getAttribute("folderid");
		int f = folderFileService.moveToTarget(fileid,filename,filefatherid,targetid,folderid);
		return f;
	}
	//复制操作 复制io系统-改变数据库
	@RequestMapping("/copyToTarget.do")
	public @ResponseBody Object copyToTarget(int fileid,String filename,int filefatherid,int targetid,HttpSession session){
		int userid=(int)session.getAttribute("folderid");
		int f = folderFileService.copyToTarget(fileid,filename,filefatherid,targetid,userid);
		return f;
	}
	
	//查看我的分享
		@RequestMapping("/getMyShare.do")
		public String getShare(HttpSession session,int page,Model model){
			
			User usersession=(User)session.getAttribute("user");
			int shareCount= folderFileService.getMyShareCount(usersession.getUsername());
			pagingInfo.setNumber(8);//每页显示8条数据;
			pagingInfo.setCountnumber(shareCount);//一共多少条数据
			pagingInfo.setPage(page);//第几页
			pagingInfo.getPagenumber();//总共几页
			pagingInfo.getDatanumber();
			Map<String, Object> sMap=new HashMap<String,Object>();
			sMap.put("username", usersession.getUsername());
			sMap.put("pagingInfo", pagingInfo);
			List<Share> shares= folderFileService.getMyShare(sMap);
			model.addAttribute("pageinfo", pagingInfo);
			model.addAttribute("shareList", shares);
			return "my_share_file";
			
		}
		//删除一条分享记录
		@RequestMapping("/deleteShare.do")
		public String deleteShare(int shareid,HttpSession session,Model model){
			folderFileService.deleteShareByone(shareid);
			User usersession=(User)session.getAttribute("user");
			int shareCount= folderFileService.getMyShareCount(usersession.getUsername());
			pagingInfo.setCountnumber(shareCount);//一共多少条数据
			pagingInfo.getPagenumber();//总共几页
			int page=pagingInfo.getPage();
			if(page>pagingInfo.getPagenumber()){
				page--;
				if(page==0){
					page=1;
				}
			}
			model.addAttribute("page",page);
			return "redirect:/file/getMyShare.do";
		}
		
		//显示图片
		@RequestMapping("/listPicture.do")
		public String listPicture(HttpSession session,Model model){
			int folderid=(int)session.getAttribute("folderid");
			List<PictureShowPackge> pictureShow = folderFileService.listPicture(folderid);
			model.addAttribute("listPicture", pictureShow);
			return "sort_picture";
		}
		//显示文档
		@RequestMapping("/listDocument.do")
		public String listDocument(HttpSession session,Model model){
			int folderid=(int)session.getAttribute("folderid");
			List<FolderFile> folderFile = folderFileService.listDocument(folderid);
			model.addAttribute("listDocument", folderFile);
			return "sort_document";
		}
		//显示视频
		@RequestMapping("/listVideo.do")
		public String listVideo(HttpSession session,Model model){
			int folderid=(int)session.getAttribute("folderid");
			List<FolderFile> folderFile = folderFileService.listVideo(folderid);
			model.addAttribute("listVideo", folderFile);
			return "sort_video";
		}
		//显示音乐
		@RequestMapping("/listMusic.do")
		public String listMusic(HttpSession session,Model model){
			int folderid=(int)session.getAttribute("folderid");
			List<FolderFile> folderFile = folderFileService.listMusic(folderid);
			model.addAttribute("listMusic", folderFile);
			return "sort_music";
		}
		//显示其他文件
		@RequestMapping("/listOthers.do")
		public String listOthers(HttpSession session,Model model){
			int folderid=(int)session.getAttribute("folderid");
			List<FolderFile> folderFile = folderFileService.listOthers(folderid);
			model.addAttribute("listOthers", folderFile);
			return "sort_others";
		}
}
