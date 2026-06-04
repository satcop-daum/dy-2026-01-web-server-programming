package kr.ac.dongyang.ai.shoppingmallcs;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
@Table(name = "delivery")
@Entity
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    @Column(name = "product_name", length = 50)
    String productName;

    @Column(name = "delivery_id", length = 20)
    String deliveryId;

    @Column(name = "delivery_user", length = 50)
    String deliveryUser;

}
