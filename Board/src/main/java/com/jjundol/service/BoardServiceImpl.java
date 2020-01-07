package com.jjundol.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjundol.domain.BoardVO;
import com.jjundol.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 게시글에 대한 CRUD
 * BoardService.java Interface 구현
 */

@Service
@Log4j
public class BoardServiceImpl implements BoardService {	

	// DI
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public List<BoardVO> getList() {
		log.info("getList...");		
		return mapper.getList();
	}

	@Override
	public void register(BoardVO board) {
		log.info("register... : " + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(int bno) {
		log.info("get... : " + bno);		
		return mapper.read(bno);
	}

	@Override
	public boolean remove(int bno) {
		log.info("remove... : " + bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify... : " + board);		
		return mapper.update(board) == 1;
	}

}
