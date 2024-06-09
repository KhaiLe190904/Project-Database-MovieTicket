package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface MovieRepository extends JpaRepository<Movie, Integer> {
    @Query(value = "select m from Movie m Where m.name LIKE '$%:name%' ")
    public Movie findMovieByName(@Param("name") String name);
}