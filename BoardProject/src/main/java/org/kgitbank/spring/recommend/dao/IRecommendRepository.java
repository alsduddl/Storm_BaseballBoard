package org.kgitbank.spring.recommend.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kgitbank.spring.recommend.vo.SeatPostRankVO;
import org.kgitbank.spring.recommend.vo.SeatRankVO;

public interface IRecommendRepository {
	
	SeatRankVO getBestCheerSeat();
	SeatRankVO getBestSatisfactionSeat();
	List<SeatPostRankVO> getTopSeatPost();
	List<SeatPostRankVO> searchSeat(@Param("keyword") String keyword);

}
