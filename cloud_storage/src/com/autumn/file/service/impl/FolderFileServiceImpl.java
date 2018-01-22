package com.autumn.file.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.autumn.file.dao.FolderFileDao;
import com.autumn.file.model.FilePackage;
import com.autumn.file.model.FolderFile;
import com.autumn.file.model.PictureShowPackge;
import com.autumn.file.model.Share;
import com.autumn.file.operate.*;
import com.autumn.file.service.FolderFileService;
@Service
public class FolderFileServiceImpl implements FolderFileService{
	
	@Resource
	private AddFolderOperate addFolderOperate;
	@Resource
	private DelFolderOperate delFolderOperate;
	@Resource
	private Move_Copy_FolderOperate moveFolderOperate;
	@Resource 
	private RenameFolderOperate renameFolderOperate;
	@Resource
	private FolderFileDao folderFileDao;
	@Override
	public List<FolderFile> findListFileStructureByUsername(FilePackage filePackage) {
		// TODO Auto-generated method stub
		return folderFileDao.findListFileStructureByUsername(filePackage);
	}
	@Override
	public FolderFile addAndBackFolder(FolderFile folderFile) {
		// TODO Auto-generated method stub
		folderFileDao.addFolder(folderFile);
		FolderFile folderFile1=folderFileDao.backFolder(folderFile.getSubfolderid());
		
		StringBuffer path = new StringBuffer();			//创建一个StringBuffer，存储文件路径
		path.insert(0, folderFile.getSubfolderfolder());  //取到当前插入进去的文件的名字
		while(folderFile.getSubfolderfather()!=0){		
			folderFile = folderFileDao.backFolder(folderFile.getSubfolderfather());  //查询它的父目录
			path.insert(0, folderFile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
		}
		String name = folderFileDao.selectFolderName(folderFile.getSubfolderid());
		path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
		path.insert(0, "D:/YunPan/");				
		
		String url= new String(path);			//将StringBuffer转换成String
		System.out.println("-----------------"+url);
		addFolderOperate.creat(url);						//调用文件系统，在本地创建文件
		
		return folderFile1;
	}
	@Override
	public FolderFile findFolderNameList(FolderFile folderFile) {
		// TODO Auto-generated method stub
		return folderFileDao.findFolderNameList(folderFile);
	}
	@Override
	public String addFileAndBackPath(FolderFile folderFile) {
		// TODO Auto-generated method stub
		
		folderFileDao.addFile(folderFile);
		FolderFile folderFile1=folderFileDao.backFolder(folderFile.getSubfolderid());
		
		StringBuffer path = new StringBuffer();			//创建一个StringBuffer，存储文件路径
		//path.insert(0, folderFile.getSubfolderfile());  //取到当前插入进去的文件的名字
		while(folderFile.getSubfolderfather()!=0){		
			folderFile = folderFileDao.backFolder(folderFile.getSubfolderfather());  //查询它的父目录
			path.insert(0, folderFile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
		}
		String name = folderFileDao.selectFolderName(folderFile.getSubfolderid());
		path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
		path.insert(0, "D:/YunPan/");
		return path.toString();
	}
	
	@Override
	public String downByIds(Integer id) {
		FolderFile folderFile = folderFileDao.backFolder(id);
		StringBuffer path = new StringBuffer();    //创建一个StringBuffer，存储文件路径
		path.insert(0, folderFile.getSubfolderfile());	//将当前的文件名插入到path路径中
		while(folderFile.getSubfolderfather()!=0){
			folderFile = folderFileDao.backFolder(folderFile.getSubfolderfather()); //查询他的父目录
			path.insert(0, folderFile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
		}
		String name = folderFileDao.selectFolderName(folderFile.getSubfolderid());
		path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
		path.insert(0, "D:/YunPan/");
		return path.toString();
	}
	@Override
	public Share addShareInfo(Share share) {
		// TODO Auto-generated method stub
		
		folderFileDao.addShareInfo(share);
		
		Share share1=folderFileDao.findShare(share);
		return share1;
	}
	@Override
	public Share findShare(Share share) {
		// TODO Auto-generated method stub
		return folderFileDao.findShare(share);
	}
	
	@Override
	public void moveToRecycle(int fileid) {
		// TODO Auto-generated method stub
		folderFileDao.moveToRecycle(fileid);
	}
	
	List<FolderFile> listRecycle;  //类变量。
	//回收站遍历
	@Override
	public List<FolderFile> listRecycle(int userid) {
		// TODO Auto-generated method stub
		listRecycle = new ArrayList<FolderFile>();
		listRecycleFolder(0,userid);
		return listRecycle;
		
	}
	//这是一个封装的方法，用来遍历回收站
	public void listRecycleFolder(int fatherid,int userid){
		List<FolderFile> list = folderFileDao.listRecycle(fatherid,userid);
		if(list.size()==0){
			return ;
		}
		for(FolderFile folderFile:list){
			if(folderFile.getSubfolderflag()==0){
				listRecycle.add(folderFile);
			}else{
				listRecycleFolder(folderFile.getSubfolderid(),userid);
			}
		}
	}
	
	@Override
	public int recover(int fileid,String filename,int filefatherid,int folderid) {
		// TODO Auto-generated method stub
		int flag = 0;//标识是文件还是文件夹
		List<FolderFile> folderfile = folderFileDao.recoverFindList(filefatherid,folderid);
		if(folderfile.size()==0){
			folderFileDao.recoverNoname(fileid);
			return 1;
		}
		for(FolderFile f : folderfile){
			if(f.getSubfolderfile()!=null){    //判断是文件
				flag = 0;
				if(f.getSubfolderfile().equals(filename)){   //拿文件的名字去比较
					return 0;
				}
			}else{		//判断是文件夹
				flag = 1;
				if(f.getSubfolderfolder().equals(filename)){ //拿文件夹的名字去比较
					return 0;
				}
			}
		}
		folderFileDao.recover(fileid,filename,flag);//撤销删除
		String path = findPath(fileid, folderid);//将文件系统里面的名字重命名 
		renameFolderOperate.rename(path,filename);
		return 1;
	}
	
	
	//根据id删除数据库中的文件 以及删除io文件系统中的文件
	@Override
	public void delfile(int fileid,String filename) {
		// TODO Auto-generated method stub
		FolderFile folderFile =folderFileDao.findfatherid(fileid);
		StringBuffer path = new StringBuffer();			//创建一个StringBuffer，存储文件路径
		path.insert(0, filename);  //取到当前插入进去的文件的名字
		
		while(folderFile.getSubfolderfather()!=0){		
			folderFile = folderFileDao.backFolder(folderFile.getSubfolderfather());  //查询它的父目录
			path.insert(0, folderFile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
		}
		String name = folderFileDao.selectFolderName(folderFile.getSubfolderid());
		path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
		path.insert(0, "D:/YunPan/");
		delFolderOperate.delete(path.toString());  //删除io本地文件
		
		List<FolderFile> list = folderFileDao.findFatherId(fileid);
		findId(list);			//调用方法，递归查找文件系统的中文件
		folderFileDao.delfileid(fileid);
	}
	
	//递归查询数据库，并且删除数据库记录
	public void findId(List<FolderFile> list){  
		//folderFile = folderFileDao.backFolder(folderFile.getFolderid());
		for(FolderFile folderFile : list){
			System.out.println("id="+folderFile.getSubfolderid()+"我是文件="+folderFile.getSubfolderfile()+"我是文件夹！"+folderFile.getSubfolderfolder());
			if(folderFile.getSubfolderfile()==null){
				//一次性查出所有父目录为当前id的数据
				findId(folderFileDao.findFatherId(folderFile.getSubfolderid()));
			}
			else{
				folderFileDao.delshare(folderFile.getSubfolderid());//将此文件的分享记录删除  防止外键约束
			}
		}
		//一次性删除所有指定的id的数据
		if(list.size()!=0){
			folderFileDao.delfile(list.get(0).getSubfolderfather());
		}
	}
	
	//文件的移动----查询所有文件夹
	@Override
	public List<FolderFile>  gainTree(int folderid) {
		// TODO Auto-generated method stub
		List<FolderFile> listFolder = folderFileDao.gainTree(folderid);
		for(int i=0;i<listFolder.size();i++){
			System.out.println(listFolder.get(i).getSubfolderfolder());
		}
		return listFolder;
	}
	
	//文件的移动----将文件移动到目标文件（修改数据库，IO文件系统）
	@Override
	public int moveToTarget(int fileid, String filename,int filefatherid, int targetid,int folderid) {
		// TODO Auto-generated method stub
		//fileid 文件的id   folderid 用户名（带用户查找）
		int flag = 0;//临时标志变量用来表示是文件还是文件夹；
		int flag2 = 0;//临时标志变量用来表示是是否需要重命名；
		int f = findName(folderid,targetid,filename);
		if(f==0){
			return 0;
		}
		String oldPath = findPath(fileid,folderid);//根据封装的方法查询此文件的完整路径
		String newPath = findPath(targetid,folderid);//根据封装的方法查询此文件的完整路径
		
		FolderFile folderfile = folderFileDao.backFolder(fileid); //根据id查询出这个文件信息
		if(folderfile.getSubfolderfile()!=null){    //判断是文件
			if(folderfile.getSubfolderfile().equals(filename)){   //拿文件的名字去比较
				flag2 = 1;
				//相同则证明不需要重命名
			}else{
				flag = 0;
				folderFileDao.renameFile(flag,fileid,filename);  //对文件进行重命名
			}
		}else{	//判断是文件夹
			if(folderfile.getSubfolderfolder().equals(filename)){   //拿文件的名字去比较
				flag2 = 1;
				//相同则证明不需要重命名
			}else{
				flag = 1;
				folderFileDao.renameFile(flag,fileid,filename);  //对文件夹进行重命名
			}
		}
		
		if(targetid==0){
			folderFileDao.moveToBoot(fileid);
		}else{
			folderFileDao.moveToTarget(fileid,targetid); //调用数据库实现文件的移动
		}
		try {
			if(flag2 == 0){   //需要重命名
				moveFolderOperate.moveTo(oldPath,newPath,filename);		//移动文件--调用i o
			}else{
				moveFolderOperate.move(oldPath,newPath);
			}
			delFolderOperate.delete(oldPath);				//删除源文件
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 1;
	}
	//这是一个封装的方法，用来查询是否重名
	public int findName(int folderid,int targetid,String filename){
		List<FolderFile> folderfile = folderFileDao.findList(folderid,targetid);
		if(folderfile.size()==0){
			return 1;
		}
		for(FolderFile f : folderfile){
			if(f.getSubfolderfile()!=null){    //判断是文件
				if(f.getSubfolderfile().equals(filename)){   //拿文件的名字去比较
					return 0;
				}
			}else{								//判断是文件夹
				if(f.getSubfolderfolder().equals(filename)){ //拿文件夹的名字去比较
					return 0;
				}
			}
		}
		return 1;
	}
	
	//这是一个封装的方法，用来查询根据当前id，获取当前文件的完整路径
	public String findPath(int fileid,int folderid){
		if(fileid==0){	//根目录
			return "D:/YunPan/"+folderFileDao.selectUser(folderid);
		}
		FolderFile folderFile =folderFileDao.findfatherid(fileid);
		StringBuffer path = new StringBuffer();			//创建一个StringBuffer，存储文件路径
		if(folderFile.getSubfolderfolder()!=null){
			path.insert(0, folderFile.getSubfolderfolder());  //将文件夹的名字插入进去	
		}else{
			path.insert(0, folderFile.getSubfolderfile());		//将文件的名字插入进去
		}
		while(folderFile.getSubfolderfather()!=0){		
			folderFile = folderFileDao.backFolder(folderFile.getSubfolderfather());  //查询它的父目录
			path.insert(0, folderFile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
		}
		String name = folderFileDao.selectFolderName(folderFile.getSubfolderid());
		path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
		path.insert(0, "D:/YunPan/");
		return path.toString();
	}
	//文件的复制----将文件复制到目标文件（修改数据库，IO文件系统）
	@Override
	public int copyToTarget(int fileid, String filename, int filefatherid, int targetid,int userid) {
		// TODO Auto-generated method stub
		int flag = 0;//临时标志变量用来表示是文件还是文件夹；
		int flag2 = 1;//临时标志变量用来表示是是否需要重命名； 0 需要重命名 1 不需要重命名
		int f = findName(userid,targetid,filename);
		if(f==0){
			return 0;
		}
		String oldPath = findPath(fileid,userid);               //根据封装的方法查询此文件的完整路径
		String newPath = findPath(targetid,userid);             //根据封装的方法查询此文件的完整路径
		
		FolderFile folderfile = folderFileDao.backFolder(fileid); //根据id查询出这个文件信息
		if(folderfile.getSubfolderfile()!=null){    //判断是文件
			flag = 0;
			if(!folderfile.getSubfolderfile().equals(filename)){   //拿文件的名字去比较
				flag2 = 0;
				//相同则证明需要重命名
			}
			folderFileDao.copyToTargetandrename(folderfile,targetid,flag,filename,flag2);  //先将主文件复制进去 （插入一条数据）父id为目标文件id，文件名为传递过来的文件名
		}else{	//判断是文件夹
			flag = 1;
			if(!folderfile.getSubfolderfolder().equals(filename)){   //拿文件的名字去比较
				flag2 = 0; 
				//相同则证明需要重命名
			}
			folderFileDao.copyToTargetandrename(folderfile,targetid,flag,filename,flag2);  //先将主文件复制进去 （插入一条数据）父id为目标文件id，文件名为传递过来的文件名
		}
		
		copyTo(folderfile,targetid);  //递归实现子文件复制
		
		try {
			if(flag2 == 0){   //需要重命名
				moveFolderOperate.moveTo(oldPath,newPath,filename);		//移动文件--调用i o
			}else{
				moveFolderOperate.move(oldPath,newPath);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 1;
	}
	//这是封装的一个方法，用来递归将文件的目录复制
	private void copyTo(FolderFile folderFile,int targetid) {
		List<FolderFile> folder = folderFileDao.findFatherId(folderFile.getSubfolderid());
		if(folder.size()>0){
			for(FolderFile f:folder){
				int targetId;
				if(f.getSubfolderfile()!=null){
					targetId = folderFileDao.findfatherandname(targetid,folderFile.getSubfolderfolder()); //根据父目录为targetid，name为当前文件的name 获取目标文件id
				}else{
					targetId = folderFileDao.findfatherandname(targetid,folderFile.getSubfolderfolder());
				}
				folderFileDao.copyToTarget(f,targetId);
				copyTo(f,targetId);
			}
		}
	}
	@Override
	public void addUserFolder(String username) {
		// TODO Auto-generated method stub
		folderFileDao.addUserFolder(username);
		addFolderOperate.creat("D:/YunPan/"+username);
	}
	@Override
	public int getMyShareCount(String username) {
		// TODO Auto-generated method stub
		return folderFileDao.getMyShareCount(username);
	}
	@Override
	public List<Share> getMyShare(Map<String, Object> sMap) {
		// TODO Auto-generated method stub
		return folderFileDao.getMyShare(sMap);
	}
	@Override
	public void deleteShareByone(int shareid) {
		// TODO Auto-generated method stub
		folderFileDao.deleteShareByone(shareid);
	}
	@Override
	public List<PictureShowPackge> listPicture(int folderid) {
		// TODO Auto-generated method stub
		List<PictureShowPackge> pictureShow = new ArrayList<PictureShowPackge>();
		List<FolderFile> folderFile = folderFileDao.listPicture(folderid);
		if(folderFile.size()==0){
			return pictureShow;
		}
		for(FolderFile folder:folderFile){
			PictureShowPackge picture = new PictureShowPackge();
			FolderFile folderfile =folderFileDao.findfatherid(folder.getSubfolderid());
			StringBuffer path = new StringBuffer();			//创建一个StringBuffer，存储文件路径
			if(folderfile.getSubfolderfolder()!=null){
				path.insert(0, folderfile.getSubfolderfolder());  //将文件夹的名字插入进去	
			}else{
				path.insert(0, folderfile.getSubfolderfile());		//将文件的名字插入进去
			}
			while(folderfile.getSubfolderfather()!=0){		
				folderfile = folderFileDao.backFolder(folderfile.getSubfolderfather());  //查询它的父目录
				path.insert(0, folderfile.getSubfolderfolder()+"/");	//取到父目录的文件名，并插入到path中
			}
			String name = folderFileDao.selectFolderName(folderfile.getSubfolderid());
			path.insert(0, name+"/");				//将文件所属那个用户的名字添加到path中
			picture.setPath(path.toString());
			picture.setFolderFile(folder);
			pictureShow.add(picture);
		}
		
		return pictureShow;
	}
	@Override
	public List<FolderFile> listDocument(int folderid) {
		// TODO Auto-generated method stub
		return folderFileDao.listDocument(folderid);
	}
	@Override
	public List<FolderFile> listVideo(int folderid) {
		// TODO Auto-generated method stub
		return folderFileDao.listVideo(folderid);
	}
	@Override
	public List<FolderFile> listMusic(int folderid) {
		// TODO Auto-generated method stub
		return folderFileDao.listMusic(folderid);
	}
	@Override
	public List<FolderFile> listOthers(int folderid) {
		// TODO Auto-generated method stub
		return folderFileDao.listOthers(folderid);
	}
	
}
