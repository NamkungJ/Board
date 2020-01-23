package com.jjundol.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor	// 생성자
@NoArgsConstructor	// 디폴트 생성자
public class SampleVO {
	
	private Integer mno;
	private String firstName;
	private String lastName;
	
}
