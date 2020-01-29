package com.jjundol.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.jjundol.domain.Ticket;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class SampleControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testConvert() {
		Ticket ticket = new Ticket();
		ticket.setBon(123);
		ticket.setGrade("Admin");
		ticket.setOwner("AAA");
		
		String jsonStrTicket = new Gson().toJson(ticket);
		
		log.info("testConvert.... : " + jsonStrTicket);
		// testConvert.... : {"bon":123,"owner":"AAA","grade":"Admin"}
		
		try {
			mockMvc.perform(post("/sample/ticket")
					.contentType(MediaType.APPLICATION_JSON)
					.content(jsonStrTicket))
					.andExpect(status().is(200));
			// /sample/ticket으로 JSON데이터를 전달, Gson : Java객체 -> JSON
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
