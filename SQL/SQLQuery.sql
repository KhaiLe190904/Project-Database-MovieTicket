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
  is_showing integer,
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
  schedule_id INT NOT NULL,
  price decimal NOT NULL,
  FOREIGN KEY (schedule_id) REFERENCES schedules(id)
  ON DELETE NO ACTION,
  FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE NO ACTION,
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
('Doraemon', 'Robot cat from the future', 'Imai KazuAki', 'Subaru Kimura, Oyama Nobuyo', 'Anime', '2024-02-01', 100, 'https://www.youtube.com/watch?v=Yug8gbDd5EQ', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkR9XFC68ZwwZNnxmU4owosfg8mW5fIWkZEQ&s', GETDATE(), GETDATE()),
('Conan', 'Famous detective Conan', 'John Milius', 'Takayama Minami, Takagi Wataru', 'Detective', '2024-03-01', 110, 'https://www.youtube.com/watch?v=YWSC_Qh8b_k', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqcZpVws4mD-f3yKNkGj6fy2mZST_qA8lbrzpuIcxOm-s3Q_N-pePo0ydfCDAFQ06kGoI&usqp=CAU', GETDATE(), GETDATE()),
('Harry Potter', 'a series of seven fantasy movies', 'Chris Columbus', 'Daniel Radcliffe, Emma Watson', 'Magic', '2024-04-01', 90, 'https://www.youtube.com/watch?v=yBAGclXF3Jk', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_HdTzrqt3vd3BMqaYoyrSOB_TQYGkIriNog&s', GETDATE(), GETDATE()),
('Haloween', 'The plot centers on a mental patient', 'Rob Zombie', 'Jamie Lee, John Carpenter', 'Horror', '2024-05-01', 130, 'https://www.youtube.com/watch?v=ek1ePFp-nBI', 1, 'https://i.ytimg.com/vi/ek1ePFp-nBI/sddefault.jpg', GETDATE(), GETDATE()),
('Bastard', 'become suspects and potential victims', 'Heavy Metal', 'Kisho Taniyama, Kusunori Tomori', 'Thriller', '2024-06-01', 105, 'https://www.youtube.com/watch?v=8y4aT2Am6Us', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgj1Ije2hYE2DhjUfuVjetK9gDvQRXq4IIbQ&s', GETDATE(), GETDATE()),
('Your Name', 'Two teenagers share a profound, magical connection upon discovering they are swapping bodies.', 'Shinkai Makoto', 'kamiki Ryunosuke, Kamishiraishi Mone', 'Romance', '2024-07-01', 115, 'https://www.youtube.com/watch?v=_mifHzxFNQ4', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyGn2TG18MomSf_u81A3VObvl31yBF9567EA&s', GETDATE(), GETDATE()),
('The Lord of the Rings', 'To destroy the One Ring and thwart Sauron ambitions, a fellowship is formed', 'Viggo Mortensen', 'Elijah Wood, Sean Astin', 'Adventure', '2024-08-01', 125, 'https://www.youtube.com/watch?v=TCwmXY_f-e0', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREUhUrHh4yahRYlL5_u-Sl4fei4XQSkleQpg&s', GETDATE(), GETDATE());

-- Insert rooms
INSERT INTO rooms (name) VALUES
('Room 1'),
('Room 2'),
('Room 3'),
('Room 4'),
('Room 5');
GO

-- TH�M INSERT SCHEDULE

-- Assuming movie_ids and room_ids are sequential and start from 1

INSERT INTO schedules(start, movie_id, room_id, update_at, create_at) VALUES
('2024-06-01 10:00:00', 41, 1, GETDATE(), GETDATE()),
('2024-06-01 13:00:00', 42, 2, GETDATE(), GETDATE()),
('2024-06-01 16:00:00', 43, 3, GETDATE(), GETDATE()),
('2024-06-01 19:00:00', 44, 4, GETDATE(), GETDATE()),
('2024-06-02 10:00:00', 45, 5, GETDATE(), GETDATE()),
('2024-06-02 13:00:00', 46, 1, GETDATE(), GETDATE()),
('2024-06-02 16:00:00', 47, 2, GETDATE(), GETDATE()),
('2024-06-02 19:00:00', 48, 3, GETDATE(), GETDATE()),
('2024-06-03 10:00:00', 41, 4, GETDATE(), GETDATE()),
('2024-06-03 13:00:00', 42, 5, GETDATE(), GETDATE()),
('2024-06-03 16:00:00', 43, 1, GETDATE(), GETDATE()),
('2024-06-03 19:00:00', 44, 2, GETDATE(), GETDATE()),
('2024-06-04 10:00:00', 45, 3, GETDATE(), GETDATE()),
('2024-06-04 13:00:00', 46, 4, GETDATE(), GETDATE()),
('2024-06-04 16:00:00', 47, 5, GETDATE(), GETDATE()),
('2024-06-04 19:00:00', 48, 1, GETDATE(), GETDATE());



-- Insert users

INSERT INTO users (username, password, full_name, email, address, sdt, update_at, create_at) VALUES
('user1', 'Johndepzai23', 'John Smith', 'john.smith@gmail.com', '123 Main St, London, UK', '44791123456', GETDATE(), GETDATE()),
('user2', 'Emmaxinhgai@', 'Emma Brown', 'emma.brown@gmail.com', '456 Elm St, Sydney, Australia', '6121235678', GETDATE(), GETDATE()),
('user3', 'Liamso1', 'Liam Johnson', 'liam.johnson@gmail.com', '789 Oak St, Toronto, Canada', '14165554367', GETDATE(), GETDATE()),
('user4', 'Oliviatocdai', 'Olivia Williams', 'olivia.williams@gmail.com', '101 Pine St, Auckland, New Zealand', '6491234567', GETDATE(), GETDATE()),
('user5', 'Noah214', 'Noah Jones', 'noah.jones@gmail.com', '202 Maple St, Dublin, Ireland', '35312345678', GETDATE(), GETDATE()),
('user6', 'Avacotu', 'Ava Garcia', 'ava.garcia@gmail.com', '303 Birch St, Barcelona, Spain', '348543678', GETDATE(), GETDATE()),
('user7', 'Millerdep', 'William Miller', 'william.miller@gmail.com', '404 Cedar St, Berlin, Germany', '4932345678', GETDATE(), GETDATE()),
('user8', 'Sophiacodon', 'Sophia Martinez', 'sophia.martinez@gmail.com', '505 Spruce St, Paris, France', '+3323456764', GETDATE(), GETDATE()),
('user9', 'Jamesxauxi', 'James Rodriguez', 'james.rodriguez@gmail.com', '606 Ash St, Rome, Italy', '78394547327', GETDATE(), GETDATE()),
('user10', 'Isabellachuany', 'Isabella Hernandez', 'isabella.hernandez@gmail.com', '707 Palm St, Lisbon, Portugal', '5121123567', GETDATE(), GETDATE()),
('user11', 'Benjaminkaiiu', 'Benjamin Lee', 'benjamin.lee@gmail.com', '808 Fir St, Seoul, South Korea', '78221234567', GETDATE(), GETDATE()),
('user12', 'Miaminua231', 'Mia Kim', 'mia.kim@gmail.com', '909 Willow Li, Tokyo, Japan', '+8153235678', GETDATE(), GETDATE()),
('user13', 'Lucas@4124', 'Lucas Davis', 'lucas.davis@gmail.com', '1010 Chestnut St, Cape Town, South Africa', '2721234567', GETDATE(), GETDATE()),
('user14', 'Ameliachuara', 'Amelia Martinez', 'amelia.martinez@gmail.com', '1111 Redwood St, Buenos Aires, Argentina', '1112345678', GETDATE(), GETDATE()),
('user15', 'Mason7623', 'Mason Wilson', 'mason.wilson@gmail.com', '1212 Cypress St, S�o Paulo, Brazil', '65845734754', GETDATE(), GETDATE());
GO


INSERT INTO bills(user_id, total_price) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0);

INSERT INTO tickets(seat, user_id, room_id, schedule_id, bill_id, price) VALUES
('A2', 2, 1, 3, 18 , 15.00),
('A3', 2, 1, 3, 18 , 15.00),
('A4', 2, 1, 3, 18 , 15.00);




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