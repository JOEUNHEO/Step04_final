package com.gura.step04.exception;

// 사용자 정의 exception
public class MyException extends Exception{
	//멤버필드
	private String message = "My Exception";
	
	public MyException(String message){
		this.message= message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public String getMessage() {
		
		return message;
	}
}
