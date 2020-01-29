package com.jjundol.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 등록
	public int register(ReplyVO reply);
		
	// 댓글 조회
	public ReplyVO select(int rno);
	
	// 댓글 삭제
	public int remove(int rno);
	
	// 댓글 수정
	public int update(ReplyVO reply);
	
	// 댓글 목록 조회, 페이징
	public List<ReplyVO> getReplyListWithPaging(@Param("cri") Criteria cri, @Param("bno") int bno);
}
