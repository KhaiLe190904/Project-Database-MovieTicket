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
    let booked = randint === 1 ? "" : "booked";
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
      amount += 200;
    } else {
      count -= 1;
      amount -= 200;
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

  if (selectedSeats.length > 0) {
    fetch('/api/select-seat', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ seats: selectedSeats })
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        document.getElementById("popup").classList.add("show");
        setTimeout(() => {
          window.location.href = "/";
        }, 2000);
      } else {
        alert("Booking failed: " + data.message);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  } else {
    alert("Please select at least one seat.");
  }
});
