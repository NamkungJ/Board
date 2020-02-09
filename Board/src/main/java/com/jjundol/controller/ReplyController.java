package com.jjundol.controller;

import java.util.List;

import javax.print.attribute.standard.Media;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.jjundol.domain.Criteria;
import com.jjundol.domain.ReplyVO;
import com.jjundol.service.ReplyServiceImpl;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/replies/*")
//@AllArgsConstructor
public class ReplyController {
	
	//private ReplyService service; 	//@AllArgsConstructor
	
	@Setter(onMethod_ = @Autowired)
	private ReplyServiceImpl service;
	
	// 댓글 등록
	@PostMapping(value = "/reg", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
		log.info("[ReplyController]register.....");
		
		int resultCnt = service.register(vo);
		
		return resultCnt == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 목록
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") int bno, @PathVariable("page") int page) {
		log.info("[ReplyController]getList.....");
		
		Criteria cri = new Criteria(page, 10);	// page : 화면에서 클릭하는 번호
		
		return new ResponseEntity<List<ReplyVO>>(service.getReplyList(cri, bno), HttpStatus.OK);
	}
	
	// 댓글 조회
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
		
		log.info("[ReplyController]get.....");
		
		return new ResponseEntity<ReplyVO>(service.select(rno), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value = "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> remove(@PathVariable("rno") int rno){
		
		log.info("[ReplyController]remove.....");
		
		int resultCnt = service.remove(rno);
		
		return resultCnt == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH },
			consumes = { "application/json" }, produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> update(@PathVariable("rno") int rno, @RequestBody ReplyVO vo){
		
		vo.setBno(rno);
		int resultCnt = service.update(vo);
		
		log.info("[ReplyController]update..... : " + vo);
		
		return resultCnt == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
