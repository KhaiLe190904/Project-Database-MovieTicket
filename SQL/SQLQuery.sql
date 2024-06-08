Create database movie_ticket
use movie_ticket

CREATE TABLE movies (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255) NOT NULL,
  description VARCHAR(MAX) NOT NULL,
  director VARCHAR(255),
  actors VARCHAR(255),
  moviecategory VARCHAR(255),
  release_date DATE,
  duration float NOT NULL,
  trailer_url VARCHAR(MAX),
  is_showing bit,
  poster_url VARCHAR(MAX),
  update_at DATETIME,
  create_at DATETIME
);


CREATE TABLE rooms (
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255) NOT NULL
);


CREATE TABLE schedules (
  id INT PRIMARY KEY IDENTITY(1,1),
  start DateTIME NOT NULL,
  movie_id INT NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (movie_id) REFERENCES movies(id)
  ON DELETE CASCADE,
  FOREIGN KEY (room_id) REFERENCES rooms(id)
  ON DELETE NO ACTION,
  update_at DATETIME,
  create_at DATETIME
);


CREATE TABLE users (
  id INT PRIMARY KEY IDENTITY(1,1),
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(MAX) NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  address VARCHAR(255) NOT NULL,
  sdt Varchar(15) NOT NULL,
  update_at DATETIME,
  create_at DATETIME
);


CREATE TABLE bills (
  id INT PRIMARY KEY IDENTITY(1,1),
  created_time DATETIME2 NOT NULL DEFAULT(getutcdate()),
  user_id INT NOT NULL,
  total_price decimal NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE CASCADE
);

CREATE TABLE tickets (
  id INT PRIMARY KEY IDENTITY(1,1),
  seat varchar(MAX) not null,
  user_id INT NOT NULL,
  room_id INT not null,
  schedule_id INT NOT NULL,
  bill_id INT NOT NULL,
  price decimal NOT NULL,
  FOREIGN KEY (schedule_id) REFERENCES schedules(id)
  ON DELETE NO ACTION,
  FOREIGN KEY (bill_id) REFERENCES bills(id)
  ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE NO ACTION,
  FOREIGN KEY (room_id) REFERENCES rooms(id)
  ON DELETE CASCADE
);

CREATE TABLE roles (
  id INT PRIMARY KEY IDENTITY(1,1),
  role_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE users_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Insert movies
INSERT INTO movies (name, description, director, actors, moviecategory, release_date, duration, trailer_url, is_showing, poster_url, update_at, create_at)
VALUES
('Haikyuu!!', 'Will you follow team Crow or team Cat?', 'Susumu Mitsunaka', 'Hinata, Kagayama', 'Anime', '2024-05-17', 120, 'https://www.youtube.com/watch?v=OFB4mrupFX0', 1, 'https://i.pinimg.com/736x/78/54/40/7854404bc725690ba96d55a990382dc1.jpg', GETDATE(), GETDATE()),
('Movie 2', 'Description 2', 'Director 2', 'Actor 3, Actor 4', 'Drama', '2024-02-01', 100, 'http://trailer2.com', 1, 'http://poster2.com', GETDATE(), GETDATE()),
('Movie 3', 'Description 3', 'Director 3', 'Actor 5, Actor 6', 'Comedy', '2024-03-01', 110, 'http://trailer3.com', 1, 'http://poster3.com', GETDATE(), GETDATE()),
('Movie 4', 'Description 4', 'Director 4', 'Actor 7, Actor 8', 'Horror', '2024-04-01', 90, 'http://trailer4.com', 1, 'http://poster4.com', GETDATE(), GETDATE()),
('Movie 5', 'Description 5', 'Director 5', 'Actor 9, Actor 10', 'Sci-Fi', '2024-05-01', 130, 'http://trailer5.com', 1, 'http://poster5.com', GETDATE(), GETDATE()),
('Movie 6', 'Description 6', 'Director 6', 'Actor 11, Actor 12', 'Thriller', '2024-06-01', 105, 'http://trailer6.com', 1, 'http://poster6.com', GETDATE(), GETDATE()),
('Movie 7', 'Description 7', 'Director 7', 'Actor 13, Actor 14', 'Romance', '2024-07-01', 115, 'http://trailer7.com', 1, 'http://poster7.com', GETDATE(), GETDATE()),
('Movie 8', 'Description 8', 'Director 8', 'Actor 15, Actor 16', 'Adventure', '2024-08-01', 125, 'http://trailer8.com', 1, 'http://poster8.com', GETDATE(), GETDATE());
GO

-- Insert rooms
INSERT INTO rooms (name) VALUES
('Room 1'),
('Room 2'),
('Room 3'),
('Room 4'),
('Room 5');
GO

-- THÊM INSERT SCHEDULE










-- Insert users
INSERT INTO users (username, password, full_name, email, address, sdt, update_at, create_at) VALUES
('admin', 'admin', 'ADMIN', 'admin@gmail.com', '***', '***', GETDATE(), GETDATE()),
('user1', 'password1', 'Full Name 1', 'user1@example.com', 'Address 1', '1234567890', GETDATE(), GETDATE()),
('user2', 'password2', 'Full Name 2', 'user2@example.com', 'Address 2', '0987654321', GETDATE(), GETDATE()),
('user3', 'password3', 'Full Name 3', 'user3@example.com', 'Address 3', '1122334455', GETDATE(), GETDATE()),
('user4', 'password4', 'Full Name 4', 'user4@example.com', 'Address 4', '5566778899', GETDATE(), GETDATE()),
('user5', 'password5', 'Full Name 5', 'user5@example.com', 'Address 5', '6677889900', GETDATE(), GETDATE()),
('user6', 'password6', 'Full Name 6', 'user6@example.com', 'Address 6', '7788990011', GETDATE(), GETDATE()),
('user7', 'password7', 'Full Name 7', 'user7@example.com', 'Address 7', '8899001122', GETDATE(), GETDATE()),
('user8', 'password8', 'Full Name 8', 'user8@example.com', 'Address 8', '9900112233', GETDATE(), GETDATE()),
('user9', 'password9', 'Full Name 9', 'user9@example.com', 'Address 9', '1010101010', GETDATE(), GETDATE()),
('user10', 'password10', 'Full Name 10', 'user10@example.com', 'Address 10', '2020202020', GETDATE(), GETDATE()),
('user11', 'password11', 'Full Name 11', 'user11@example.com', 'Address 11', '3030303030', GETDATE(), GETDATE()),
('user12', 'password12', 'Full Name 12', 'user12@example.com', 'Address 12', '4040404040', GETDATE(), GETDATE()),
('user13', 'password13', 'Full Name 13', 'user13@example.com', 'Address 13', '5050505050', GETDATE(), GETDATE()),
('user14', 'password14', 'Full Name 14', 'user14@example.com', 'Address 14', '6060606060', GETDATE(), GETDATE()),
('user15', 'password15', 'Full Name 15', 'user15@example.com', 'Address 15', '7070707070', GETDATE(), GETDATE());
GO

CREATE PROCEDURE InsertTicket
    @seat NVARCHAR(10),
    @user_id INT,
    @room_id INT,
    @schedule_id INT,
    @price DECIMAL
AS
BEGIN
    DECLARE @bill_id INT;
    DECLARE @total_price DECIMAL;

    -- Check if a bill already exists for this user_id, room_id, and schedule_id
    SELECT @bill_id = id
    FROM bills
    WHERE user_id = @user_id
      AND id IN (SELECT bill_id FROM tickets WHERE room_id = @room_id AND schedule_id = @schedule_id);

    -- If no existing bill is found, create a new bill
    IF @bill_id IS NULL
    BEGIN
        INSERT INTO bills (user_id, total_price)
        VALUES (@user_id, @price);
        SET @bill_id = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- Update the total price of the existing bill
        SELECT @total_price = total_price FROM bills WHERE id = @bill_id;
        SET @total_price = @total_price + @price;
        UPDATE bills
        SET total_price = @total_price
        WHERE id = @bill_id;
    END

    -- Insert the ticket
    INSERT INTO tickets (seat, user_id, room_id, schedule_id, bill_id, price)
    VALUES (@seat, @user_id, @room_id, @schedule_id, @bill_id, @price);
END;

EXEC InsertTicket 'A1', 2, 1, 1, 15.00;
EXEC InsertTicket 'A2', 2, 1, 1, 15.00;
EXEC InsertTicket 'A3', 2, 2, 2, 15.00;
EXEC InsertTicket 'B1', 3, 3, 3, 15.00;
EXEC InsertTicket 'B2', 4, 4, 4, 15.00;
EXEC InsertTicket 'C1', 5, 5, 5, 15.00;
EXEC InsertTicket 'C2', 6, 1, 6, 40.00;
EXEC InsertTicket 'D1', 7, 2, 7, 45.00;
EXEC InsertTicket 'D2', 8, 3, 8, 50.00;
EXEC InsertTicket 'E1', 9, 4, 9, 55.00;
EXEC InsertTicket 'E2', 10, 5, 10, 60.00;
EXEC InsertTicket 'F1', 11, 1, 11, 65.00;
EXEC InsertTicket 'F2', 12, 2, 12, 70.00;
EXEC InsertTicket 'G1', 13, 3, 13, 75.00;
EXEC InsertTicket 'G2', 14, 4, 14, 80.00;
EXEC InsertTicket 'H1', 15, 5, 15, 85.00;


-- Insert roles
INSERT INTO roles (role_name) VALUES
('Admin'),
('User');
GO

-- Assign roles to users
INSERT INTO users_roles (user_id, role_id) VALUES
(1, 2),  -- Assign Admin role to user1
(2, 2),  -- Assign User role to user2
(3, 2),  -- Assign User role to user3
(4, 2),  -- Assign User role to user4
(5, 2),  -- Assign User role to user5
(6, 2),  -- Assign User role to user6
(7, 2),  -- Assign User role to user7
(8, 2),  -- Assign User role to user8
(9, 2),  -- Assign User role to user9
(10, 2), -- Assign User role to user10
(11, 2), -- Assign User role to user11
(12, 2), -- Assign User role to user12
(13, 2), -- Assign User role to user13
(14, 2), -- Assign User role to user14
(15, 2); -- Assign User role to user15
GO

-- Create the trigger to update total_price in bills table
--CREATE TRIGGER trg_UpdateTotalPrice
--ON tickets
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;

    -- Update total_price for the affected bills
--    UPDATE bills
--    SET total_price = (
--        SELECT SUM(price)
--        FROM tickets
--        WHERE bill_id = inserted.bill_id 
--    )
--    FROM inserted
--    WHERE bills.id = inserted.bill_id 
--END;
--GO