document.addEventListener('DOMContentLoaded', () => {
  const movieId = window.location.pathname.split('/').pop();
  fetchSchedules(movieId);

  let seats = document.querySelector(".all-seats");

  // Rows from A to F and columns from 1 to 10
  const rows = ['F', 'E', 'D', 'C', 'B', 'A'];
  const cols = 10;

  // Function to generate seat labels
  function generateSeatLabel(row, col) {
    return `${row}${col}`;
  }

  // Function to update seat availability based on booked seats
  function updateSeatAvailability(bookedSeats) {
    seats.innerHTML = ''; // Clear existing seats
    let seatIndex = 0;
    for (let row = 0; row < rows.length; row++) {
      for (let col = 1; col <= cols; col++) {
        seatIndex++;
        let seatLabel = generateSeatLabel(rows[row], col);
        let isBooked = bookedSeats.includes(seatLabel);
        let disabled = isBooked ? "disabled" : "";
        let booked = isBooked ? "booked" : "";

        seats.insertAdjacentHTML(
            "beforeend",
            `<input type="checkbox" name="tickets" id="s${seatIndex}" data-seat-label="${seatLabel}" ${disabled} />
           <label for="s${seatIndex}" class="seat ${booked}">
             <span>${seatLabel}</span>
           </label>`
        );
      }
    }
    addEventListenersToSeats();
  }

  // Function to fetch booked seats for a specific schedule
  function fetchBookedSeats(scheduleId) {
    fetch(`http://localhost:8080/booking/booked-seats/${scheduleId}`)
        .then(response => {
          if (!response.ok) {
            throw new Error('Failed to fetch booked seats');
          }
          return response.json();
        })
        .then(bookedSeats => updateSeatAvailability(bookedSeats))
        .catch(error => console.error('Error fetching booked seats:', error));
  }

  // Add event listeners to seats
  function addEventListenersToSeats() {
    let tickets = seats.querySelectorAll("input:not(:disabled)");

    tickets.forEach((ticket) => {
      ticket.addEventListener("change", () => {
        updateTotalAmountAndCount();
      });
    });

    document.getElementById("bookButton").addEventListener("click", async () => {
      const selectedSeats = Array.from(tickets)
          .filter(ticket => ticket.checked)
          .map(ticket => ticket.getAttribute("data-seat-label"));

      const selectedScheduleID = document.querySelector('input[name="time"]:checked').getAttribute("data-schedule-id");
      const userId = JSON.parse(localStorage.getItem("userId"));

      if (selectedSeats.length > 0) {
        const bookingPromises = selectedSeats.map(seat => {
          const data = {
            seat: seat,
            userId: userId,
            scheduleId: selectedScheduleID,
            price: 75000,
          };
          return book(data);
        });

        try {
          await Promise.all(bookingPromises);
          // All bookings succeeded
          const totalAmount = document.querySelector(".amount").innerHTML;
          const bookedSeatsMessage = selectedSeats.join(', ');
          alert(`Seats booked: ${bookedSeatsMessage}\nTotal amount: ${totalAmount}`);
          // Optionally, you can reset the UI here
           location.reload();// Update UI to mark seats as booked
          updateTotalAmountAndCount(); // Reset amount and count to zero
        } catch (error) {
          console.error('Booking failed:', error);
        }
      }
    });
  }

  // Function to book a seat
  function book(data) {
    return fetch("http://localhost:8080/tickets/post", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
        .then(response => {
          if (!response.ok) {
            throw new Error('Booking failed');
          }
          return response.json();
        });
  }

  // Function to fetch schedules
  async function fetchSchedules(movieId) {
    try {
      const response = await fetch(`http://localhost:8080/booking/${movieId}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });
      if (response.ok) {
        const schedules = await response.json();
        displaySchedules(schedules);
      } else {
        throw new Error('Failed to fetch schedules');
      }
    } catch (error) {
      console.error('Error fetching schedules:', error);
    }
  }

  // Function to display schedules
  function displaySchedules(schedules) {
    const datesContainer = document.querySelector('.dates');
    const timesContainer = document.querySelector('.times');
    datesContainer.innerHTML = ''; // Clear existing dates
    timesContainer.innerHTML = ''; // Clear existing times

    const uniqueDates = [...new Set(schedules.map(schedule => new Date(schedule.start).toLocaleDateString()))];

    uniqueDates.forEach((date, index) => {
      const dateInput = document.createElement('input');
      dateInput.type = 'radio';
      dateInput.name = 'date';
      dateInput.id = `d${index + 1}`;
      if (index === 0) dateInput.checked = true;

      const dateLabel = document.createElement('label');
      dateLabel.className = 'dates-item';
      dateLabel.htmlFor = `d${index + 1}`;
      const dateObj = new Date(date);
      dateLabel.innerHTML = `<div class="day">${dateObj.toLocaleDateString('vi-VN', { month: 'numeric', weekday: 'short' })}</div>
                             <div class="date">${dateObj.getDate()}</div>`;

      datesContainer.appendChild(dateInput);
      datesContainer.appendChild(dateLabel);

      // Add event listener to update times based on selected date
      dateInput.addEventListener('change', () => {

        const selectedDate = new Date(date);
        const filteredSchedules = schedules.filter(schedule => new Date(schedule.start).toLocaleDateString() === selectedDate.toLocaleDateString());
        updateTimes(filteredSchedules);
      });

      // Automatically display times for the first date
      if (index === 0) {
        const filteredSchedules = schedules.filter(schedule => new Date(schedule.start).toLocaleDateString() === date);
        updateTimes(filteredSchedules);
      }
    });
  }

  // Function to update times based on selected date
  function updateTimes(schedules) {
    const timesContainer = document.querySelector('.times');
    timesContainer.innerHTML = ''; // Clear existing times

    schedules.forEach((schedule, index) => {
      const timeInput = document.createElement('input');
      timeInput.type = 'radio';
      timeInput.name = 'time';
      timeInput.id = `t${index + 1}`;
      const scheduleID = schedule.id;
      timeInput.setAttribute("data-schedule-id", scheduleID);
      if (index === 0) timeInput.checked = true;

      const timeLabel = document.createElement('label');
      timeLabel.className = 'time';
      timeLabel.htmlFor = `t${index + 1}`;
      timeLabel.textContent = new Date(schedule.start).toLocaleTimeString();

      timesContainer.appendChild(timeInput);
      timesContainer.appendChild(timeLabel);

      if (index === 0) {
        fetchBookedSeats(scheduleID);
      }

      timeInput.addEventListener('change', () => {

        fetchBookedSeats(scheduleID);
      });
    });
  }

  // Function to update total amount and count of selected seats
  function updateTotalAmountAndCount() {
    let tickets = seats.querySelectorAll("input:not(:disabled)");
    let amount = 0;
    let count = 0;

    tickets.forEach((ticket) => {
      if (ticket.checked) {
        count++;
        amount += 75000;
      }
    });

    document.querySelector(".amount").innerHTML = amount;
    document.querySelector(".count").innerHTML = count;
  }
});
