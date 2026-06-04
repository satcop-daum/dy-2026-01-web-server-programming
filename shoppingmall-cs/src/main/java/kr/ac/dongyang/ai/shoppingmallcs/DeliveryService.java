package kr.ac.dongyang.ai.shoppingmallcs;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class DeliveryService {

    private final DeliveryRepository deliveryRepository;


    public void add(DeliveryForm form) {

        var delivery = Delivery.builder()
                .deliveryUser(form.getDeliveyUser())
                .deliveryId(form.getDeliveyId())
                .build();
        deliveryRepository.save(delivery);

    }


}
