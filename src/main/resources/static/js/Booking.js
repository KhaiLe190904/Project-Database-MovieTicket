document.addEventListener('DOMContentLoaded', () => {
  const movieId = window.location.pathname.split('/').pop();
  fetchSchedules(movieId);

  let seats = document.querySelector(".all-seats");

  // Rows from A to F and columns from 1 to 10
  const rows = ['A', 'B', 'C', 'D', 'E', 'F'];
  const cols = 10;

  // Function to generate seat labels
  function generateSeatLabel(row, col) {
    return `${row}${col}`;
  }

  // Generating 60 seats (6 rows, 10 seats each)
  let seatIndex = 0;
  for (let row = 0; row < rows.length; row++) {
    for (let col = 1; col <= cols; col++) {
      seatIndex++;
      let randint = Math.floor(Math.random() * 2);
      let booked = randint === 1 ? "" : "";
      let disabled = booked === "booked" ? "disabled" : "";
      let seatLabel = generateSeatLabel(rows[row], col);

      seats.insertAdjacentHTML(
          "beforeend",
          `<input type="checkbox" name="tickets" id="s${seatIndex}" data-seat-label="${seatLabel}" ${disabled} />
         <label for="s${seatIndex}" class="seat ${booked}">
           <span>${seatLabel}</span>
         </label>`
      );
    }
  }

  // Select all non-disabled ticket inputs
  let tickets = seats.querySelectorAll("input:not(:disabled)");

  // Add event listeners to selectable tickets
  tickets.forEach((ticket) => {
    ticket.addEventListener("change", () => {
      let amount = document.querySelector(".amount").innerHTML;
      let count = document.querySelector(".count").innerHTML;
      amount = Number(amount);
      count = Number(count);

      if (ticket.checked) {
        count += 1;
        amount += 75000;
      } else {
        count -= 1;
        amount -= 75000;
      }
      document.querySelector(".amount").innerHTML = amount;
      document.querySelector(".count").innerHTML = count;
    });
  });

  // Add event listener to book button
  document.getElementById("bookButton").addEventListener("click", () => {
    let selectedSeats = [];
    tickets.forEach((ticket) => {
      if (ticket.checked) {
        selectedSeats.push(ticket.getAttribute("data-seat-label"));
      }
    });

    // Get selected scheduleID
    const selectedScheduleID = document.querySelector('input[name="time"]:checked').getAttribute("data-schedule-id");

    const data = {
      seat_id: selectedSeats.join(","),
      price: 75000,
      schedule_id: selectedScheduleID
    };

    if (selectedSeats.length > 0) {
      fetch("https://jsonplaceholder.typicode.com/users", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ data })
      })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              document.getElementById("popup").classList.add("show");
              setTimeout(() => {
                window.location.href = "/";
              }, 2000);
            } else {
              alert("Booking success: " + data.message);
            }
          })
          .catch(error => {
            console.error('Error:', error);
          });
    } else {
      alert("Please select at least one seat.");
    }
    console.log(data);
  });
});

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
      console.log(schedules);
    } else {
      console.error('Lỗi khi lấy lịch chiếu:', response.statusText);
    }
  } catch (error) {
    console.error('Lỗi khi lấy lịch chiếu:', error);
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
  });
}
