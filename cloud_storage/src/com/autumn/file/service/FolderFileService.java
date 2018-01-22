package com.autumn.file.service;

import java.util.List;
import java.util.Map;

import com.autumn.file.model.FilePackage;
import com.autumn.file.model.FolderFile;
import com.autumn.file.model.PictureShowPackge;
import com.autumn.file.model.Share;

public interface FolderFileService {

	public List<FolderFile> findListFileStructureByUsername(FilePackage filePackage);

	public FolderFile addAndBackFolder(FolderFile folderFile);

	public FolderFile findFolderNameList(FolderFile folderFile);

	public String addFileAndBackPath(FolderFile folderFile);

	public String downByIds(Integer id);

	public Share addShareInfo(Share share);

	public Share findShare(Share share);

	public void moveToRecycle(int fileid);

	public List<FolderFile> listRecycle(int userid);

	public int recover(int fileid, String filename, int filefatherid,int folderid);

	public void delfile(int fileid,String filename);

	public List<FolderFile>  gainTree(int folderid);

	public int moveToTarget(int fileid, String filename, int filefatherid, int targetid,int folderid);

	public int copyToTarget(int fileid, String filename, int filefatherid, int targetid, int userid);

	public void addUserFolder(String username);
	
	public int getMyShareCount(String username);

	public List<Share> getMyShare(Map<String, Object> sMap);

	public void deleteShareByone(int shareid);

	public List<PictureShowPackge> listPicture(int folderid);

	public List<FolderFile> listDocument(int folderid);

	public List<FolderFile> listVideo(int folderid);

	public List<FolderFile> listMusic(int folderid);

	public List<FolderFile> listOthers(int folderid);

}
