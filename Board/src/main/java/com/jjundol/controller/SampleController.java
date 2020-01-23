package com.jjundol.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jjundol.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {		
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);		
		return "안녕하세요!?";
	}
	
	@GetMapping(value = "/getSample", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE,
												   MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value = "/getSample2")	// produces 속성은 생략가능
	public SampleVO getSample2() {
		return new SampleVO(113, "스타2", "로드2");
	}
	
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap() {
		Map<String, SampleVO> map = new HashMap<String, SampleVO>();
		map.put("First", new SampleVO(114, "베이비", "그루트"));
		return map;
	}
	
	@GetMapping(value = "/check", params = { "height", "weight" })
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		
		SampleVO sample = new SampleVO(0, ""+height, ""+weight);
		
		ResponseEntity<SampleVO> result;
		
		if(height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(sample);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(sample);
		}
		return result;
	}
	
	@GetMapping(value = "/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") String pid) {
		return new String[] {cat, pid};
	}
	
}
