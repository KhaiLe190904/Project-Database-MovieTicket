document.addEventListener('DOMContentLoaded', () => {
    const filmTableBody = document.getElementById('filmTableBody');

    // Sample data
   let films = [
        { title: 'Film 1', description: 'Description of Film 1', image: '../../static/image/img1.jpg' },
        { title: 'Film 2', description: 'Description of Film 2', image: '../../static/image/img2.jpg' }
    ]; 

    // Function to render film list
    function renderFilms() {
        filmTableBody.innerHTML = '';
        films.forEach((film, index) => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${film.title}</td>
                <td>${film.description}</td>
                <td><img src="${film.image}" alt="${film.title}" width="100"></td>
                <td>
                    <button onclick="editFilm(${index})">Edit</button>
                    <button onclick="deleteFilm(${index})">Delete</button>
                </td>
            `;
            filmTableBody.appendChild(row);
        });
    }

    // Function to add a new film
    document.getElementById('addFilmForm').addEventListener('submit', (e) => {
        e.preventDefault();
        const newFilm = {
            title: e.target.title.value,
            description: e.target.description.value,
            image: e.target.image.value
        };
        films.push(newFilm);
        renderFilms();
        e.target.reset();
    });

    // Function to edit a film
    window.editFilm = (index) => {
        const film = films[index];
        document.getElementById('filmTitle').value = film.title;
        document.getElementById('filmDescription').value = film.description;
        document.getElementById('filmImage').value = film.image;
        document.getElementById('addFilmForm').onsubmit = (e) => {
            e.preventDefault();
            films[index] = {
                title: e.target.title.value,
                description: e.target.description.value,
                image: e.target.image.value
            };
            renderFilms();
            e.target.reset();
            document.getElementById('addFilmForm').onsubmit = addFilmFormSubmit;
        };
    };

    // Function to delete a film
    window.deleteFilm = (index) => {
        films.splice(index, 1);
        renderFilms();
    };

    // Initial rendering of films
    renderFilms();
});