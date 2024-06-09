package com.webbookingticket.fullstack.model;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name="movies")
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id")
    public int id;

    @Column(name="name", nullable = false)
    private String name;

    @Column(name="description", nullable = false)
    private String description;

    @Column(name="director")
    private String director;

    @Column(name="actors")
    private String actors;

    @Column(name="moviecategory")
    private String movieCategory;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name="release_date")
    private Date releaseDate;

    @Column(name="duration", nullable = false)
    private float duration;

    @Column(name="trailer_url")
    private String trailerUrl;

    @Column(name="is_showing")
    private int isShowing;

    @Column(name="poster_url")
    private String posterUrl;

    @Column(name="update_at")
    private LocalDateTime updateAt;

    @Column(name="create_at")
    private LocalDateTime createAt;

    @PrePersist
    protected void onCreate() {
        createAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updateAt = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", director='" + director + '\'' +
                ", actors='" + actors + '\'' +
                ", movieCategory='" + movieCategory + '\'' +
                ", releaseDate=" + releaseDate +
                ", duration=" + duration +
                ", trailerUrl='" + trailerUrl + '\'' +
                ", isShowing=" + isShowing +
                ", posterUrl='" + posterUrl + '\'' +
                ", updateAt=" + updateAt +
                ", createAt=" + createAt +
                '}';
    }
}
