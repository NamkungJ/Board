package com.jjundol.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	//private BoardService service; 	//@AllArgsConstructor
	
	@Setter(onMethod_ = @Autowired)
	private ReplyServiceImpl service;
	
	@PostMapping(value = "/reg", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> register(@RequestParam ReplyVO vo) {
		log.info("[ReplyController]register.....");
		
		int resultCnt = service.register(vo);				
		
		return resultCnt == 1 
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") int bno, @PathVariable("page") int page) {
		log.info("[ReplyController]getList.....");
		
		Criteria cri = new Criteria(page, 10);	// page : 화면에서 클릭하는 번호
		
		return new ResponseEntity<List<ReplyVO>>(service.getReplyList(cri, bno), HttpStatus.OK);
	}
	
	
}
