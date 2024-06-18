let nextDom = document.getElementById('next');
let prevDom = document.getElementById('prev');

let carouselDom = document.querySelector('.carousel');
let SliderDom = carouselDom.querySelector('.carousel .list');
let thumbnailBorderDom = document.querySelector('.carousel .thumbnail');
let thumbnailItemsDom = thumbnailBorderDom.querySelectorAll('.item');
let timeDom = document.querySelector('.carousel .time');

thumbnailBorderDom.appendChild(thumbnailItemsDom[0]);
let timeRunning = 3000;
let timeAutoNext = 7000;

nextDom.onclick = function(){
    showSlider('next');
}

prevDom.onclick = function(){
    showSlider('prev');
}
let runTimeOut;
let runNextAuto = setTimeout(() => {
    next.click();
}, timeAutoNext)

function showSlider(type){
    let  SliderItemsDom = SliderDom.querySelectorAll('.carousel .list .item');
    let thumbnailItemsDom = document.querySelectorAll('.carousel .thumbnail .item');

    if(type === 'next'){
        SliderDom.appendChild(SliderItemsDom[0]);
        thumbnailBorderDom.appendChild(thumbnailItemsDom[0]);
        carouselDom.classList.add('next');
    }else{
        SliderDom.prepend(SliderItemsDom[SliderItemsDom.length - 1]);
        thumbnailBorderDom.prepend(thumbnailItemsDom[thumbnailItemsDom.length - 1]);
        carouselDom.classList.add('prev');
    }
    clearTimeout(runTimeOut);
    runTimeOut = setTimeout(() => {
        carouselDom.classList.remove('next');
        carouselDom.classList.remove('prev');
    }, timeRunning);

    clearTimeout(runNextAuto);
    runNextAuto = setTimeout(() => {
        next.click();
    }, timeAutoNext)
}

// fetch movies
async function fetchMovies() {
    try {
        const response = await fetch('http://localhost:8080/movies_list');
        if (response.ok) {
            const movies = await response.json();
            displayMovies(movies);
        } else {
            console.error('Error fetching movies:', response.statusText);
        }
    } catch (error) {
        console.error('Error fetching movies:', error);
    }
}

function displayMovies(movies) {
    const moviesContainer = document.getElementById('movies');
    moviesContainer.innerHTML = ''; // Clear any existing content


    movies.filter(movie => movie.isShowing === 1).forEach(movie => {
        const movieCard = document.createElement('div');
        movieCard.className = 'movie-card';

        const poster = document.createElement('img');
        poster.src = movie.posterUrl;
        poster.alt = 'Movie Poster';
        poster.width = 133;
        poster.height = 200;

        const title = document.createElement('h3');
        title.textContent = movie.movieName;

        const buttonsDiv = document.createElement('div');
        buttonsDiv.className = 'buttons';

        const bookingButton = document.createElement('button');
        bookingButton.textContent = 'Đặt Vé';
        bookingButton.onclick = () => {
            window.location.href = `/booking/${movie.movieId}`;
        };

        const trailerButton = document.createElement('button');
        const trailerLink = document.createElement('a');
        trailerLink.href = movie.trailerUrl;
        trailerLink.textContent = 'Trailer';
        trailerButton.appendChild(trailerLink);

        buttonsDiv.appendChild(bookingButton);
        buttonsDiv.appendChild(trailerButton);

        movieCard.appendChild(poster);
        movieCard.appendChild(title);
        movieCard.appendChild(buttonsDiv);

        moviesContainer.appendChild(movieCard);
    });
}

// Fetch and display movies on page load
fetchMovies();