package kr.ac.dongyang.ai.shoppingmallcs.controller;


import kr.ac.dongyang.ai.shoppingmallcs.DeliveryForm;
import kr.ac.dongyang.ai.shoppingmallcs.DeliveryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@RequiredArgsConstructor
@Controller
public class IndexController {

    private final DeliveryService deliveryService;

    @GetMapping("/")
    public String index() {

        return "index";
    }

    @PostMapping("/")
    public String indexSubmit(DeliveryForm form) {

        deliveryService.add(form);

        return "redirect:/";
    }


}
