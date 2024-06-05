document.addEventListener('DOMContentLoaded', () => {
    const filmTableBody = document.getElementById('filmTableBody');

    // Fetch film data from the server
    async function fetchFilms() {
        try {
            const response = await fetch('https://your-server-url/api/films'); // Replace with your actual API endpoint
            const films = await response.json();
            renderFilms(films);
        } catch (error) {
            console.error('Error fetching films:', error);
        }
    }

    // Function to render film list
    function renderFilms(films) {
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
    document.getElementById('addFilmForm').addEventListener('submit', async (e) => {
        e.preventDefault();
        const newFilm = {
            title: e.target.title.value,
            description: e.target.description.value,
            image: e.target.image.value
        };
        try {
            const response = await fetch('https://your-server-url/api/films', { // Replace with your actual API endpoint
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(newFilm)
            });
            if (response.ok) {
                const films = await response.json();
                renderFilms(films);
            } else {
                console.error('Error adding film:', response.statusText);
            }
        } catch (error) {
            console.error('Error adding film:', error);
        }
        e.target.reset();
    });

    // Function to edit a film
    window.editFilm = (index) => {
        const film = films[index];
        document.getElementById('filmTitle').value = film.title;
        document.getElementById('filmDescription').value = film.description;
        document.getElementById('filmImage').value = film.image;
        document.getElementById('addFilmForm').onsubmit = async (e) => {
            e.preventDefault();
            films[index] = {
                title: e.target.title.value,
                description: e.target.description.value,
                image: e.target.image.value
            };
            try {
                const response = await fetch(`https://your-server-url/api/films/${index}`, { // Replace with your actual API endpoint
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(films[index])
                });
                if (response.ok) {
                    renderFilms(films);
                } else {
                    console.error('Error editing film:', response.statusText);
                }
            } catch (error) {
                console.error('Error editing film:', error);
            }
            e.target.reset();
            document.getElementById('addFilmForm').onsubmit = addFilmFormSubmit;
        };
    };

    // Function to delete a film
    window.deleteFilm = async (index) => {
        try {
            const response = await fetch(`https://your-server-url/api/films/${index}`, { // Replace with your actual API endpoint
                method: 'DELETE'
            });
            if (response.ok) {
                films.splice(index, 1);
                renderFilms(films);
            } else {
                console.error('Error deleting film:', response.statusText);
            }
        } catch (error) {
            console.error('Error deleting film:', error);
        }
    };

    // Initial fetching of films
    fetchFilms();
});
