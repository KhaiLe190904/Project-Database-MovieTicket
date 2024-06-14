package com.webbookingticket.fullstack.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name="tickets")
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="seat", nullable = false)
    private String seat;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="user_id", nullable = false)
    private User user_id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="schedule_id", nullable = false)
    private Schedule schedule_id;

    @Column(name="price", nullable = false)
    private BigDecimal price;
}
