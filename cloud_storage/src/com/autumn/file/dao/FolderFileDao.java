package com.autumn.file.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.autumn.file.model.FilePackage;
import com.autumn.file.model.FolderFile;
import com.autumn.file.model.Share;

public interface FolderFileDao {

	public List<FolderFile> findListFileStructureByUsername(FilePackage filePackage);

	public int addFolder(FolderFile folderFile);

	public FolderFile backFolder(int subfolderid);

	public FolderFile findFolderNameList(FolderFile folderFile);
	/*查询根目录*/
	public String selectFolderName(int subfolderid);
	
	public String selectUser(int folderid);

	public int addFile(FolderFile folderFile);

	public void addShareInfo(Share share);

	public Share findShare(Share share);

	public void moveToRecycle(int fileid);

	public List<FolderFile> listRecycle(@Param("fatherid")int fatherid,@Param("userid")int userid);
	
	public void recoverNoname(int fileid);

	public void recover(@Param("fileid")int fileid,@Param("filename")String filename,@Param("flag")int flag);
	
	public List<FolderFile> recoverFindList(@Param("fatherid")int fatherid,@Param("folderid")int folderid);

	public FolderFile findfatherid(int fileid);
	
	public List<FolderFile> findFatherId(int fileid);

	public void delfile(int fileid);
	
	public void delfileid(int fileid);
	
	public void delshare(int fileid);
	
	public List<FolderFile>  gainTree(int folderid);

	public void moveToTarget(@Param("fileid")Integer fileid, @Param("targetid")Integer targetid);
	
	public void moveToBoot(int fileid);

	public void copyToTargetandrename(@Param("f")FolderFile folderFile, @Param("targetid")int targetid,@Param("flag")int flag,@Param("filename")String filename,@Param("flag2")int flag2);

	public void copyToTarget(@Param("f")FolderFile folderFile, @Param("targetid")int targetid);
	
	public int findfatherandname(@Param("targetid")int targetid, @Param("folder")String folder);

	public void addUserFolder(String username);

	public List<FolderFile> findList(@Param("folderid")int folderid, @Param("targetid")int targetid);

	public void renameFile(@Param("flag")int flag,@Param("fileid")int fileid, @Param("filename")String filename);
	
	public int getMyShareCount(String username);

	public List<Share> getMyShare(Map<String, Object> sMap);

	public void deleteShareByone(int shareid);

	public List<FolderFile> listPicture(int folderid);

	public List<FolderFile> listDocument(int folderid);

	public List<FolderFile> listVideo(int folderid);

	public List<FolderFile> listMusic(int folderid);

	public List<FolderFile> listOthers(int folderid);
}
