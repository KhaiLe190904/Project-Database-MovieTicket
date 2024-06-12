package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<Room, Integer> {
}
