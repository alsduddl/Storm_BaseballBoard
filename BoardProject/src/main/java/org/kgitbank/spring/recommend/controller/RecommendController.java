package org.kgitbank.spring.recommend.controller;

import org.kgitbank.spring.recommend.service.IRecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RecommendController {
	
	@Autowired
	private IRecommendService recommendService;
	
	@GetMapping("/recommend")
	public String recommend(Model model) {
		model.addAttribute("bestCheer", recommendService.getBestCheerSeat());
		model.addAttribute("bestSatisfaction", recommendService.getBestSatisfactionSeat());
		model.addAttribute("topPost", recommendService.getTopSeatPost());
		return "recommend";
	}

}
