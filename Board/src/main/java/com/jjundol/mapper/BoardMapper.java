package com.jjundol.mapper;

import java.util.List;

import com.jjundol.domain.BoardVO;

public interface BoardMapper {
	
	//@Select("select * from tbl_board where bno > 0")
	// 게시물 여러개 가져오기
	public List<BoardVO> getList();
	
	// 게시글 작성
	public void insert(BoardVO board);
	
	// 게시글 작성 key
	public void insertSelectKey(BoardVO board);
	
	// 특정 게시글 읽기
	public BoardVO read(int bno);
	
	// 특정 게시글 삭제
	public int delete(int bno);
	
	// 특정 게시글 수정(업데이트)
	public int update(BoardVO board);
}