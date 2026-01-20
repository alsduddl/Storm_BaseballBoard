package org.kgitbank.spring.recommend.service;

import java.util.List;

import org.kgitbank.spring.recommend.dao.IRecommendRepository;
import org.kgitbank.spring.recommend.vo.SeatPostRankVO;
import org.kgitbank.spring.recommend.vo.SeatRankVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecommendService implements IRecommendService{
	
	@Autowired
	private IRecommendRepository recommendRepository;

	@Override
	public SeatRankVO getBestCheerSeat() {
		return recommendRepository.getBestCheerSeat();
	}

	@Override
	public SeatRankVO getBestSatisfactionSeat() {
		return recommendRepository.getBestSatisfactionSeat();
	}

	@Override
	public List<SeatPostRankVO> getTopSeatPost() {
		return recommendRepository.getTopSeatPost();
	}

	@Override
	public List<SeatPostRankVO> searchSeat(String keyword) {
		return recommendRepository.searchSeat(keyword);
	}

}
