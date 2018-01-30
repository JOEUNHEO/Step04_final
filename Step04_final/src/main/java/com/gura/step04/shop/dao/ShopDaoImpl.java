package com.gura.step04.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.step04.shop.dto.ShopDto;

@Repository
public class ShopDaoImpl implements ShopDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<ShopDto> getList() {
		
		return session.selectList("shop.getList");
	}

	@Override
	public void minusCount(int num) {
		session.update("shop.minusCount", num);			
	}

	@Override
	public void minusMoney(ShopDto dto) {
		session.update("shop.minusMoney", dto);
	}

	@Override
	public void plusPoint(ShopDto dto) {
		session.update("shop.plusPoint",dto);
	}

	@Override
	public void plusMoney(String id, int price) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void minusPoint(String id, int point) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void plusCount(int num) {
		// TODO Auto-generated method stub
		
	}
	
	//상품의 가격을 리턴해주는 메소드
	@Override
	public int getPrice(int num) {
		
		return session.selectOne("shop.getPrice", num);
	}

}
