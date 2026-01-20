package org.kgitbank.spring.recommend.controller;

import org.kgitbank.spring.recommend.service.IRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

//구역 추천 페이지
@Controller
public class RecommendController {
	
	@Autowired
	private IRecommendService recommendService;
	
	//응원 분위기 최고 구역
	//좌석만족도 최고 구역
	//종합 점수
	@GetMapping("/recommend")
	public String recommend(Model model) {
		model.addAttribute("bestCheer", recommendService.getBestCheerSeat());
		model.addAttribute("bestSatisfaction", recommendService.getBestSatisfactionSeat());
		model.addAttribute("topPost", recommendService.getTopSeatPost());
		return "recommend";
	}

}
