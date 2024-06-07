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
    public int id;

    @Column(name="seat", nullable = false)
    private String seat;

    @ManyToOne
    @JoinColumn(name="user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name="room_id", nullable = false)
    private Room room;

    @ManyToOne
    @JoinColumn(name="schedule_id", nullable = false)
    private Schedule schedule;

    @ManyToOne
    @JoinColumn(name="bill_id", nullable = false)
    private Bill bill;

    @Column(name="price", nullable = false)
    private BigDecimal price;
}
