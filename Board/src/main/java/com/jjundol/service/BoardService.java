package com.jjundol.service;

import java.util.List;

import com.jjundol.domain.BoardVO;
import com.jjundol.domain.Criteria;

public interface BoardService {
	
	// 게시물 여러개 가져오기
	//public List<BoardVO> getList();
	// 페이징 처리
	public List<BoardVO> getList(Criteria cri);
	
	// 게시글 작성
	public void register(BoardVO board);
	
	// 특정 게시글 읽기
	public BoardVO get(int bno);	
	
	// 특정 게시글 삭제
	public boolean remove(int bno);
	
	// 특정 게시글 수정(업데이트)
	public boolean modify(BoardVO board);
		
}
