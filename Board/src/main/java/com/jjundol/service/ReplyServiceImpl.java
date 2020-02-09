package com.jjundol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyPageDTO;
import com.jjundol.domain.ReplyVO;
import com.jjundol.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 댓글에 대한 CRUD 
 */

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO reply) {		
		log.info("[ReplyServiceImpl]register.....");		
		return mapper.register(reply);
	}

	@Override
	public ReplyVO select(int rno) {
		log.info("[ReplyServiceImpl]select.....");
		return mapper.select(rno);
	}

	@Override
	public int remove(int rno) {
		log.info("[ReplyServiceImpl]remove.....");		
		return mapper.remove(rno);
	}

	@Override
	public int update(ReplyVO reply) {
		log.info("[ReplyServiceImpl]update.....");
		return mapper.update(reply);
	}

	@Override
	public ReplyPageDTO getReplyList(Criteria cri, int bno) {
		log.info("[ReplyServiceImpl]getReplyList.....");
		
		int replyCnt = mapper.getCountReplyByBno(bno);
		List<ReplyVO> list = mapper.getReplyListWithPaging(cri, bno);
		
		return new ReplyPageDTO(replyCnt, list);
	}	

	

}