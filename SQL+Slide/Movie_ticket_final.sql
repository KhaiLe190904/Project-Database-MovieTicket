Create database movie_ticket
Use movie_ticket

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
  is_showing INT,
  poster_url VARCHAR(MAX),
  update_at DATETIME,
  create_at DATETIME
);


CREATE TABLE categories(
  id INT PRIMARY KEY IDENTITY(1,1),
  name VARCHAR(255));

CREATE TABLE movie_category(
  movie_id INT NOT NULL,
  category_id INT NOT NULL,
  CONSTRAINT PK_movie_category PRIMARY KEY (movie_id, category_id),
  CONSTRAINT FK1_movie FOREIGN KEY (movie_id)
  REFERENCES movies(id),
  CONSTRAINT FK2_ FOREIGN KEY (category_id)
  REFERENCES categories(id)
  );


INSERT INTO categories (name) VALUES 
('Action'),
('Adventure'),
('Biography'),
('Cartoon'),
('Comedy'),
('Documentary'),
('Drama'),
('Family'),
('Historical'),
('Horror'),
('Musical'),
('Romance'),
('War');

 
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

CREATE TABLE bills(
  id INT PRIMARY KEY IDENTITY(1,1),
  user_id INT,
  schedule_id INT,
  price float NOT NULL,
  CONSTRAINT FK1_bill FOREIGN KEY (user_id)
  REFERENCES users(id),
  CONSTRAINT FK2_bill FOREIGN KEY (schedule_id)
  REFERENCES schedules(id)
);

ALTER TABLE bills
ADD CONSTRAINT UQ_UserSchedule UNIQUE (user_id, schedule_id);

CREATE TABLE tickets (
  id INT PRIMARY KEY IDENTITY(1,1),
  seat varchar(MAX) not null,
  user_id INT NOT NULL,
  schedule_id INT NOT NULL,
  price decimal NOT NULL,
  FOREIGN KEY (schedule_id) REFERENCES schedules(id)
  ON DELETE NO ACTION,
  FOREIGN KEY (user_id) REFERENCES users(id)
  ON DELETE NO ACTION
);

CREATE TABLE roles (
  id INT PRIMARY KEY IDENTITY(1,1),
  role_name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO roles VALUES
('ROLE_ADMIN'),
('ROLE_USER');

CREATE TABLE users_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

INSERT INTO movies (name, description, director, actors, moviecategory, release_date, duration, trailer_url, is_showing, poster_url, update_at, create_at)
VALUES
('Haikyuu!!', 'Will you follow team Crow or team Cat?', 'Susumu Mitsunaka', 'Hinata, Kagayama', 'Anime', '2024-05-17', 120, 'https://www.youtube.com/watch?v=OFB4mrupFX0', 1, 'https://i.pinimg.com/736x/78/54/40/7854404bc725690ba96d55a990382dc1.jpg', GETDATE(), GETDATE()),
('Doraemon', 'Robot cat from the future', 'Imai KazuAki', 'Subaru Kimura, Oyama Nobuyo', 'Anime', '2024-02-01', 100, 'https://www.youtube.com/watch?v=Yug8gbDd5EQ', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkR9XFC68ZwwZNnxmU4owosfg8mW5fIWkZEQ&s', GETDATE(), GETDATE()),
('Conan', 'Famous detective Conan', 'John Milius', 'Takayama Minami, Takagi Wataru', 'Detective', '2024-03-01', 110, 'https://www.youtube.com/watch?v=YWSC_Qh8b_k', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqcZpVws4mD-f3yKNkGj6fy2mZST_qA8lbrzpuIcxOm-s3Q_N-pePo0ydfCDAFQ06kGoI&usqp=CAU', GETDATE(), GETDATE()),
('Harry Potter', 'a series of seven fantasy movies', 'Chris Columbus', 'Daniel Radcliffe, Emma Watson', 'Magic', '2024-04-01', 90, 'https://www.youtube.com/watch?v=yBAGclXF3Jk', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_HdTzrqt3vd3BMqaYoyrSOB_TQYGkIriNog&s', GETDATE(), GETDATE()),
('Bastard', 'become suspects and potential victims', 'Heavy Metal', 'Kisho Taniyama, Kusunori Tomori', 'Thriller', '2024-06-01', 105, 'https://www.youtube.com/watch?v=8y4aT2Am6Us', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgj1Ije2hYE2DhjUfuVjetK9gDvQRXq4IIbQ&s', GETDATE(), GETDATE()),
('Your Name', 'Two teenagers share a profound, magical connection upon discovering they are swapping bodies.', 'Shinkai Makoto', 'kamiki Ryunosuke, Kamishiraishi Mone', 'Romance', '2024-07-01', 115, 'https://www.youtube.com/watch?v=_mifHzxFNQ4', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyGn2TG18MomSf_u81A3VObvl31yBF9567EA&s', GETDATE(), GETDATE()),
('The Lord of the Rings', 'To destroy the One Ring and thwart Sauron ambitions, a fellowship is formed', 'Viggo Mortensen', 'Elijah Wood, Sean Astin', 'Adventure', '2024-08-01', 125, 'https://www.youtube.com/watch?v=TCwmXY_f-e0', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREUhUrHh4yahRYlL5_u-Sl4fei4XQSkleQpg&s', GETDATE(), GETDATE()),
('The Shawshank Redemption', 'Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison', 'Frank Darabont', 'Stephen King', 'Drama', '1994-09-23',142 , 'https://youtu.be/PLl99DlL6b4', 1, 'https://www.themoviedb.org/t/p/w1280/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg', GETDATE(), GETDATE()),
('The Godfather', 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family.', 'Francis Ford Coppola', 'Mario Puzo', 'Drama', '1972-03-24',175 , 'https://youtu.be/7pfqivkYUlE', 1, 'https://www.themoviedb.org/t/p/w1280/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', GETDATE(), GETDATE()),
('Spirited Away', 'A young girl, Chihiro, becomes trapped in a strange new world of spirits.', 'Hayao Miyazaki', 'Hayao Miyazaki', 'Cartoon', '2001-01-07',125 , 'https://youtu.be/GAp2_0JJskk', 1, 'https://www.themoviedb.org/t/p/w1280/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg', GETDATE(), GETDATE()),
('The Dark Knight', 'Batman raises the stakes in his war on crime.', 'Christopher Nolan', 'Bob Kane, Jonathan Nolan', 'Action', '2008-08-29',158 , 'https://youtu.be/kmJLuwP3MbY', 1, 'https://www.themoviedb.org/t/p/w1280/qJ2tW6WMUDux911r6m7haRef0WH.jpg', GETDATE(), GETDATE()),
('Parasite', 'All unemployed, Ki-taeks family takes peculiar interest in the wealthy and glamorous Parks for their livelihood until they get entangled in an unexpected incident', 'Bong Joon-ho', 'Han Jin-won', 'Comedy', '2019-06-21',133 , 'https://youtu.be/bM9QabAojCg', 1, 'https://www.themoviedb.org/t/p/w1280/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', GETDATE(), GETDATE()),
('Grave of the Fireflies', 'In the final months of World War II, 14-year-old Seita and his sister Setsuko are orphaned when their mother is killed during an air raid in Kobe, Japan.', 'Isao Takahata', 'Akiyuki Nosaka', 'Cartoon', '1998-04-16',89 , 'https://youtu.be/4vPeTSRd580', 1, 'https://www.themoviedb.org/t/p/w1280/k9tv1rXZbOhH7eiCk378x61kNQ1.jpg', GETDATE(), GETDATE()),
('The Lord of the Rings: The Return of the King', 'As armies mass for a final battle that will decide the fate of the world--and powerful, ancient forces of Light and Dark', 'Peter Jackson', 'J.R.R. Tolkien, Philippa Boyens', 'Adventure', '2023-11-29',201 , 'https://youtu.be/zckJCxYxn1g', 1, 'https://www.themoviedb.org/t/p/w1280/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg', GETDATE(), GETDATE()),
('The Good, the Bad and the Ugly', 'While the Civil War rages on between the Union and the Confederacy, three men - a quiet loner, a ruthless hitman', 'Sergio Leone', 'Luciano Vincenzoni, Agenore Incrocci', 'Action', '1966-12-22',161 , 'https://youtu.be/IFNUGzCOQoI', 1, 'https://www.themoviedb.org/t/p/w1280/bX2xnavhMYjWDoZp1VM6VnU1xwe.jpg', GETDATE(), GETDATE()),
('Interstellar', 'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.', 'Christopher Nolan', 'Jonathan Nolan', 'Adventure', '2014-11-07',169 , 'https://youtu.be/LY19rHKAaAg', 1, 'https://www.themoviedb.org/t/p/w1280/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', GETDATE(), GETDATE()),
('Radical', 'In a Mexican border town plagued by neglect, corruption, and violence, a frustrated teacher tries a radical new method to break through his students apathy and unlock their curiosity, their potential… and maybe even their genius.', 'Christopher Zalla', 'Christopher Zalla', 'Drama', '2023-11-03',127 , 'https://youtu.be/BXcGgvAKC1Q', 1, 'https://www.themoviedb.org/t/p/w1280/eSatbygYZp8ooprBHZdb6GFZxGB.jpg', GETDATE(), GETDATE()),
('Life Is Beautiful', 'A touching story of an Italian book seller of Jewish ancestry who lives in his own little fairy tale.', 'Roberto Benigni', 'Vincenzo Cerami', 'Comedy', '1997-12-20',116 , 'https://youtu.be/pAYEQP8gx3w', 1, 'https://www.themoviedb.org/t/p/w1280/74hLDKjD5aGYOotO6esUVaeISa2.jpg', GETDATE(), GETDATE()),
('Gabriel Inferno', 'An intriguing and sinful exploration of seduction, forbidden love, and redemption, Gabriel Inferno is a captivating and wildly passionate tale of', 'Tosca Musk', 'Sylvain Reynard, Mary Pocrnic', 'Romance', '2020-05-29',122 , 'https://youtu.be/kgWFjmiqHmQ', 1, 'https://www.themoviedb.org/t/p/w1280/oyG9TL7FcRP4EZ9Vid6uKzwdndz.jpg', GETDATE(), GETDATE()),
('Once Upon a Time in America', 'A former Prohibition-era Jewish gangster returns to the Lower East Side of Manhattan over thirty years later, where he once again must confront the ghosts and regrets of his old life.', 'Sergio Leone', 'Harry Grey, Leonardo Benvenuti', 'Drama', '1984-09-28',229 , 'https://youtu.be/lFw062jAYR0', 1, 'https://www.themoviedb.org/t/p/w1280/i0enkzsL5dPeneWnjl1fCWm6L7k.jpg', GETDATE(), GETDATE()),
('Spider-Man: Into the Spider-Verse', 'Struggling to find his place in the world while juggling school and family, Brooklyn teenager Miles Morales is unexpectedly bitten by a radioactive spider and develops unfathomable powers just like the one and only Spider-Man.', 'Rodney Rothman', 'Phil Lord, Bob Persichetti', 'Cartoon', '2018-12-14',117 , 'https://youtu.be/tg52up16eq0', 1, 'https://www.themoviedb.org/t/p/w1280/iiZZdoQBEYBv6id8su7ImL0oCbD.jpg', GETDATE(), GETDATE()),
('Howls Moving Castle', 'Sophie, a young milliner, is turned into an elderly woman by a witch who enters her shop and curses her. She encounters a wizard named Howl and gets caught up in his resistance to fighting for the king.', 'Hayao Miyazaki', 'Diana Wynne Jones', 'Cartoon', '2004-11-19',119 , 'https://youtu.be/2x5SejvTMeA', 1, 'https://www.themoviedb.org/t/p/w1280/6pZgH10jhpToPcf0uvyTCPFhWpI.jpg', GETDATE(), GETDATE()),
('The Legend of Hei', 'When cat spirit Luo Xiaohei home is deforested by humans, he must find a new one. He runs into a group of other spirit creatures who take him under their wing with dreams of reconquering the land they say is rightfully theirs.', 'MTJJ', 'Fengxishenlei, Kexin Peng', 'Cartoon', '2019-08-27',82 , 'https://youtu.be/Ps0O9l2CvOM', 1, 'https://www.themoviedb.org/t/p/w1280/aLv87NgRJUPkQ6sVLP72IisDdt4.jpg', GETDATE(), GETDATE()),
('The Empire Strikes Back', 'The epic saga continues as Luke Skywalker, in hopes of defeating the evil Galactic Empire, learns the ways of the Jedi from aging master Yoda. But Darth Vader is more determined than ever to capture Luke.', 'Irvin Kershner', 'Leigh Brackett, Lawrence Kasdan', 'Adventure', '1980-05-26',124 , 'https://youtu.be/vU6L3jXt2r8', 1, 'https://www.themoviedb.org/t/p/w1280/nNAeTmF4CtdSgMDplXTDPOpYzsX.jpg', GETDATE(), GETDATE()),
('Harakir', 'Down-on-his-luck veteran Tsugumo Hanshirō enters the courtyard of the prosperous House of Iyi. Unemployed, and with no family, he hopes to find a place to commit seppuku—and a worthy second to deliver the coup de grâce in his suicide ritual.', 'Masaki Kobayashi', 'Yasuhiko Takiguchi, Shinobu Hashimoto', 'Action', '1962-11-09',135 , 'https://youtu.be/gfABwM-Ppng', 1, 'https://www.themoviedb.org/t/p/w1280/5konZnIbcAxZjP616Cz5o9bKEfW.jpg', GETDATE(), GETDATE()),
('Taylor Swift: Reputation Stadium Tour', 'Taylor Swift takes the stage in Dallas for the Reputation Stadium Tour and celebrates a monumental night of Musicalal, memories and visual magic.', 'Paul Dugdale', 'Paul Dugdale', 'Musicalal', '2018-12-31',125 , 'https://youtu.be/HIb_TlK2HAI', 1, 'https://www.themoviedb.org/t/p/w1280/u6oXUTtOuJRPdUgUuPAVVJPSKCo.jpg', GETDATE(), GETDATE()),
('Spider-Man: Across the Spider-Verse', 'After reuniting with Gwen Stacy, Brooklyn full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence.', 'Joaquim Dos Santos', 'Stan Lee, Steve Ditko, Robbi Rodriguez', 'Cartoon', '2023-06-01',200 , 'https://youtu.be/yFrxzaBLDQM', 1, 'https://www.themoviedb.org/t/p/w1280/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg', GETDATE(), GETDATE()),
('A Silent Voice: The Movie', 'Shouya Ishida starts bullying the new girl in class, Shouko Nishimiya, because she is deaf. But as the teasing continues, the rest of the class starts to turn on Shouya for his lack of compassion.', 'Naoko Yamada', 'Reiko Yoshida', 'Cartoon', '2017-05-12',130 , 'https://youtu.be/e8tMQVwqj54', 1, 'https://www.themoviedb.org/t/p/w1280/tuFaWiqX0TXoWu7DGNcmX3UW7sT.jpg', GETDATE(), GETDATE()),
('Princess Mononoke', 'Ashitaka, a prince of the disappearing Emishi people, is cursed by a demonized boar god and must journey to the west to find a cure.', 'Hayao Miyazaki', 'Hayao Miyazaki', 'Cartoon', '1997-07-12',134 , 'https://youtu.be/opCxPAwdB6U', 1, 'https://www.themoviedb.org/t/p/w1280/cMYCDADoLKLbB83g4WnJegaZimC.jpg', GETDATE(), GETDATE()),
('The Quintessential Quintuplets Movie', 'When five lovely young girls who hate studying hire part-time tutor Futaro, he guides not only their education but also their hearts. Time spent has brought them all closer, with feelings growing within the girls and Futaro.', 'Masato Jimbo', 'Keiichiro Ochi', 'Cartoon', '2022-05-20',136 , 'https://youtu.be/maS5nHFa1o8', 1, 'https://www.themoviedb.org/t/p/w1280/sg7klpt1xwK1IJirBI9EHaqQwJ5.jpg', GETDATE(), GETDATE()),
('Hotarubi no Mori e', 'One hot summer day a little girl gets lost in an enchanted forest of the mountain god where spirits reside. A young boy appears before her, but she cannot touch him for fear of making him disappear.', 'Takahiro Omori', 'Takahiro Omori', 'Cartoon', '2011-09-17',45 , 'https://youtu.be/qXLSRH31Yao', 1, 'https://www.themoviedb.org/t/p/w1280/mDqzHV8UXWWNpZkoAbKmKX1ZxEE.jpg', GETDATE(), GETDATE()),
('The Great Dictator', 'Dictator Adenoid Hynkel tries to expand his empire while a poor Jewish barber tries to avoid persecution from Hynkel regime.', 'Charlie Chaplin', 'Charlie Chaplin', 'Comedy', '1940-10-23',125 , 'https://youtu.be/i1C6qZVeFtA', 1, 'https://www.themoviedb.org/t/p/w1280/1QpO9wo7JWecZ4NiBuu625FiY1j.jpg', GETDATE(), GETDATE()),
('High and Low', 'In the midst of an attempt to take over his company, a powerhouse executive is hit with a huge ransom demand when his servants son is kidnapped', 'Akira Kurosawa', 'Evan Hunter, Hideo Oguni', 'Drama', '1963-01-03',142 , 'https://youtu.be/ELsgPvgDBoY', 1, 'https://www.themoviedb.org/t/p/w1280/tgNjemQPG96uIezpiUiXFcer5ga.jpg', GETDATE(), GETDATE()),
('Neon Genesis Evangelion: The End of Evangelion', 'Seele orders an all-out attack on NERV, aiming to destroy the Evas before Gendo can trigger Third Impact and Instrumentality under his control.', 'Hideaki Anno', 'Kazuya Tsurumaki', 'Cartoon', '1997-07-19',97 , 'https://youtu.be/v1pWyWIu8x4', 1, 'https://www.themoviedb.org/t/p/w1280/j6G24dqI4WgUtChhWjfnI4lnmiK.jpg', GETDATE(), GETDATE()),
('Back to the Future', 'Eighties teenager Marty McFly is accidentally sent back in time to 1955, inadvertently disrupting his parents first meeting and attracting his mother romantic interest.', 'Robert Zemeckis', 'Bob Gale', 'Adventure', '1985-07-15',114 , 'https://youtu.be/U71BvFM7Wpw', 1, 'https://www.themoviedb.org/t/p/w1280/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg', GETDATE(), GETDATE()),
('Dedicated to my ex', 'The film tells the story of Ariel, a 21-year-old who decides to form a rock band to compete for a prize of ten thousand dollars in a Musicalalal band contest, this as a last option when trying to get money to save their relationship and reunite with his ex-girlfriend,', 'Jorge Ulloa', 'Nataly Valencia, Diego Ulloa, Julio Pañi', 'Drama', '2019-11-08',94 , 'https://youtu.be/hU2DASqjvi4', 1, 'https://www.themoviedb.org/t/p/w1280/xc4bTXVwYNXi10jG9dwcaYt5IpU.jpg', GETDATE(), GETDATE()),
('Dead Poets Society', 'At an elite, old-fashioned boarding school in New England, a passionate English teacher inspires his students to rebel against convention and seize the potential of every day, courting the disdain of the stern headmaster.', 'Peter Weir', 'Tom Schulman', 'Drama', '1989-06-02',128 , 'https://youtu.be/s_jsDreXFZU', 1, 'https://www.themoviedb.org/t/p/w1280/hmGAF5NDoYB6S39UONevjHCESOI.jpg', GETDATE(), GETDATE()),
('One Direction: This Is Us', 'Hear it from the boys themselves and see through their own eyes what it really like to be One Direction.', 'Morgan Spurlock', 'Morgan Spurlock', 'Musicalal', '2013-08-30',107 , 'https://youtu.be/mvl-YyGRXmA', 1, 'https://www.themoviedb.org/t/p/w1280/cxIoYa7uboxiDvWGxdad6fvgpcH.jpg', GETDATE(), GETDATE()),
('Sunset Boulevard', 'A hack screenwriter writes a screenplay for a former silent film star who has faded into Hollywood obscurity.', 'Billy Wilder', 'D.M. Marshman Jr., Charles Brackett', 'Drama', '1950-08-10',110 , 'https://youtu.be/_dY0SVxnHjQ', 1, 'https://www.themoviedb.org/t/p/w1280/sC4Dpmn87oz9AuxZ15Lmip0Ftgr.jpg', GETDATE(), GETDATE()),
('Ikiru', 'Kanji Watanabe is a middle-aged man who has worked in the same monotonous bureaucratic position for decades. Learning he has cancer, he starts to look for the meaning of his life.', 'Akira Kurosawa', 'Shinobu Hashimoto, Hideo Oguni', 'Drama', '1952-10-09',143 , 'https://youtu.be/geKhyNerWM8', 1, 'https://www.themoviedb.org/t/p/w1280/dgNTS4EQDDVfkzJI5msKuHu2Ei3.jpg', GETDATE(), GETDATE()),
('Léon: The Professional', 'Léon, the top hit man in New York, has earned a rep as an effective "cleaner".', 'Luc Besson', 'Luc Besson', 'Action', '1994-07-05',111 , 'https://youtu.be/Nq101UyQyTo', 1, 'https://www.themoviedb.org/t/p/w1280/yI6X2cCM5YPJtxMhUd3dPGqDAhw.jpg', GETDATE(), GETDATE()),
('Perfect Blue', 'Encouraged by her managers, rising pop star Mima takes on a recurring role on a popular TV show, when suddenly her handlers and collaborators begin turning up murdered.', 'Satoshi Kon, Kou Matsuo', 'Sadayuki Murai', 'Cartoon', '1998-02-28',102 , 'https://youtu.be/0AgD1uocfk0', 1, 'https://www.themoviedb.org/t/p/w1280/6WTiOCfDPP8XV4jqfloiVWf7KHq.jpg', GETDATE(), GETDATE()),
('Modern Times', 'A bumbling tramp desires to build a home with a young woman, yet is thwarted time and time again by his lack of experience and habit of being in the wrong place at the wrong time.', 'Charlie Chaplin', 'Charlie Chaplin', 'Comedy', '1936-02-25',97 , 'https://youtu.be/NNznUyDmSFc', 1, 'https://www.themoviedb.org/t/p/w1280/uEMekS25hwXrCJOZZ3NKMGcAFJo.jpg', GETDATE(), GETDATE()),
('Once Upon a Time in the West', 'As the railroad builders advance unstoppably through the Arizona desert on their way to the sea, Jill arrives in the small town of Flagstone with the intention of starting a new life.', 'Sergio Leone', 'Sergio Donati, Bernardo Bertolucci', 'Drama', '1968-12-21',168 , 'https://youtu.be/Yw-Av9BpC-w', 1, 'https://www.themoviedb.org/t/p/w1280/qbYgqOczabWNn2XKwgMtVrntD6P.jpg', GETDATE(), GETDATE()),
('Apocalypse Now', 'At the height of the Vietnam war, Captain Benjamin Willard is sent on a dangerous mission that, officially, "does not exist, nor will it ever exist." His goal is to locate - and eliminate - a mysterious Green Beret Colonel named Walter Kurtz', 'Francis Ford Coppola', 'Francis Ford Coppola, Michael Herr, John Milius', 'Drama', '1979-08-15',147 , 'https://youtu.be/9l-ViOOFH-s', 1, 'https://www.themoviedb.org/t/p/w1280/gQB8Y5RCMkv2zwzFHbUJX3kAhvA.jpg', GETDATE(), GETDATE()),
('Le Trou', 'Four prison inmates have been hatching a plan to literally dig out of jail when another prisoner, Claude Gaspard, is moved into their cell. They take a risk and share their plan with the newcomer.', 'Jacques Becker', 'José Giovanni, Jean Aurel', 'Drama', '1960-03-18',132 , 'https://youtu.be/g2Sbo6JpDsY', 1, 'https://www.themoviedb.org/t/p/w1280/8kxtOm7D992iAaOzUoWmNQwbXjs.jpg', GETDATE(), GETDATE()),
('City Lights', 'A tramp falls in love with a beautiful blind flower girl. His on-and-off friendship with a wealthy man allows him to be the girl benefactor and suitor.', 'Charlie Chaplin', 'Harry Carr, Harry Crocker', 'Comedy', '1931-03-07',97 , 'https://youtu.be/7vl7F8S4cpQ', 1, 'https://www.themoviedb.org/t/p/w1280/bXNvzjULc9jrOVhGfjcc64uKZmZ.jpg', GETDATE(), GETDATE()),
('The Intouchables', 'A true story of two men who should never have met - a quadriplegic aristocrat who was injured in a paragliding accident and a young man from the projects.', 'Olivier Nakache', 'Éric Toledano, Philippe Pozzo di Borgo', 'Drama', '2012-06-15',114 , 'https://youtu.be/dvdJ--DV0Uo', 1, 'https://www.themoviedb.org/t/p/w1280/1QU7HKgsQbGpzsJbJK4pAVQV9F5.jpg', GETDATE(), GETDATE()),
('Josee, the Tiger and the Fish', 'With dreams of diving abroad, Tsuneo gets a job assisting Josee, an artist whose imagination takes her far beyond her wheelchair. But when the tide turns against them, they push each other to places they never thought possible, and inspire a love fit for a storybook.', 'Kotaro Tamura', 'Sayaka Kuwamura', 'Cartoon', '2021-04-09',103 , 'https://youtu.be/hLEjE77PbcA', 1, 'https://www.themoviedb.org/t/p/w1280/xAbSLi61npWyVs5M0yxin3dKcGO.jpg', GETDATE(), GETDATE()),
('Life in a Year', 'A 17 year old finds out that his girlfriend is dying, so he sets out to give her an entire life, in the last year she has left.', 'Mitja Okorn', 'Jeffrey Addiss, Will Matthews', 'Romance', '2020-11-27',107 , 'https://youtu.be/BgmJ14p4Uuk', 1, 'https://www.themoviedb.org/t/p/w1280/bP7u19opmHXYeTCUwGjlLldmUMc.jpg', GETDATE(), GETDATE()),
('Paths of Glory', 'A commanding officer defends three scapegoats on trial for a failed offensive that occurred within the French Army in 1916.', 'Stanley Kubrick', 'Humphrey Cobb, Jim Thompson', 'History', '1957-10-20',88 , 'https://youtu.be/icZyfkL4FMY', 1, 'https://www.themoviedb.org/t/p/w1280/3O10X1bVSasrS2NQ186s2tlKvqN.jpg', GETDATE(), GETDATE()),
('It a Wonderful Life', 'A holiday favourite for generations... George Bailey has spent his entire life giving to the people of Bedford Falls. All that prevents rich skinflint Mr. Potter from taking over the entire town is George modest building and loan company.', 'Frank Capra', 'Frances Goodrich, Albert Hackett', 'Drama', '1946-12-20',130 , 'https://youtu.be/iLR3gZrU2Xo', 1, 'https://www.themoviedb.org/t/p/w1280/bSqt9rhDZx1Q7UZ86dBPKdNomp2.jpg', GETDATE(), GETDATE()),
('Five Feet Apart', 'Seventeen-year-old Stella spends most of her time in the hospital as a cystic fibrosis patient. Her life is full of routines, boundaries and self-control — all of which get put to the test when she meets Will, an impossibly charming teen who has the same illness.', 'Justin Baldoni', 'Mikki Daughtry, Tobias Iaconis', 'Romance', '2019-03-29',116 , 'https://youtu.be/24YrEAGF32M', 1, 'https://www.themoviedb.org/t/p/w1280/kreTuJBkUjVWePRfhHZuYfhNE1T.jpg', GETDATE(), GETDATE()),
('The Boy, the Mole, the Fox and the Horse', 'The unlikely friendship of a boy, a mole, a fox and a horse traveling together in the boy search for home.', 'Peter Baynton', 'Charlie Mackesy, Jon Croker', 'Cartoon', '2022-12-25',35 , 'https://youtu.be/609A7IGdoEc', 1, 'https://www.themoviedb.org/t/p/w1280/oQRgyQCzcyZvE6w5heM9ktVY0LT.jpg', GETDATE(), GETDATE()),
('Miracle in Cell No. 7', 'Separated from his daughter, a father with an intellectual disability must prove his innocence when he is jailed for the death of a commander child.', 'Mehmet Ada Öztekin', 'Kubilay Tat, Özge Efendioğlu', 'Drama', '2019-10-11',132 , 'https://youtu.be/bDAkHkR6fwA', 1, 'https://www.themoviedb.org/t/p/w1280/bOth4QmNyEkalwahfPCfiXjNh1r.jpg', GETDATE(), GETDATE()),
('Given', 'The relationship between a band bassist, their drummer, and the drummers roommate and ex-boyfriend, who is a professional violinist.', 'Hikaru Yamaguchi', 'Yuniko Ayana', 'Cartoon', '2020-08-22',60 , 'https://youtu.be/XGKGjMGZwtk', 1, 'https://www.themoviedb.org/t/p/w1280/3trPz7muDOv4AHjDZiD3MLGls2Q.jpg', GETDATE(), GETDATE()),
('Violet Evergarden: The Movie', 'As the world moves on from the war and technological advances bring changes to her life, Violet still hopes to see her lost commanding officer again.', 'Taichi Ishidate', 'Kana Akatsuki, Reiko Yoshida', 'Cartoon', '2020-09-18',140 , 'https://youtu.be/BUfSen2rYQs', 1, 'https://www.themoviedb.org/t/p/w1280/A9R6bukzzRmOzxvDQsXdQpeNm8l.jpg', GETDATE(), GETDATE());

-- Insert rooms
INSERT INTO rooms (name) VALUES
('Room 1'),
('Room 2'),
('Room 3'),
('Room 4'),
('Room 5');
GO

-- THÊM INSERT SCHEDULE

INSERT INTO schedules(start, movie_id, room_id, update_at, create_at) VALUES
('2024-06-01 10:00:00', 1, 1, GETDATE(), GETDATE()),
('2024-06-01 13:00:00', 2, 2, GETDATE(), GETDATE()),
('2024-06-01 16:00:00', 3, 3, GETDATE(), GETDATE()),
('2024-06-01 19:00:00', 4, 4, GETDATE(), GETDATE()),
('2024-06-02 10:00:00', 5, 5, GETDATE(), GETDATE()),
('2024-06-02 13:00:00', 6, 1, GETDATE(), GETDATE()),
('2024-06-02 16:00:00', 7, 2, GETDATE(), GETDATE()),
('2024-06-02 19:00:00', 8, 3, GETDATE(), GETDATE()),
('2024-06-03 10:00:00', 1, 4, GETDATE(), GETDATE()),
('2024-06-03 13:00:00', 2, 5, GETDATE(), GETDATE()),
('2024-06-03 16:00:00', 3, 1, GETDATE(), GETDATE()),
('2024-06-03 19:00:00', 4, 2, GETDATE(), GETDATE()),
('2024-06-04 10:00:00', 5, 3, GETDATE(), GETDATE()),
('2024-06-04 13:00:00', 6, 4, GETDATE(), GETDATE()),
('2024-06-04 16:00:00', 7, 5, GETDATE(), GETDATE()),
('2024-06-04 19:00:00', 8, 1, GETDATE(), GETDATE());

--------------------------------------------------------------------------------------------
----------TRIGGER----------------------------------------------------------------------------
-----------------Mỗi khi thêm vào 1 phim, trigger sẽ tự động kiểm tra moviecategory có thuộc trường (name) trong bảng categories hay không. Nếu có, add vào
CREATE TRIGGER insert_category
ON movies
AFTER INSERT
AS
BEGIN
    -- Biến để kiểm tra trạng thái
    DECLARE @categoryId INT, @movieId INT, @movieCategory VARCHAR(255);

    -- Con trỏ để duyệt qua từng bản ghi trong bảng inserted
    DECLARE insert_cursor CURSOR FOR
    SELECT i.id, i.moviecategory
    FROM inserted i;

    OPEN insert_cursor;
    FETCH NEXT FROM insert_cursor INTO @movieId, @movieCategory;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Kiểm tra xem thể loại phim có tồn tại trong bảng categories hay không
        SELECT @categoryId = c.id
        FROM categories c
        WHERE c.name = @movieCategory;

        IF @categoryId IS NOT NULL
        BEGIN
            -- Nếu thể loại tồn tại, thêm vào bảng movie_category
            INSERT INTO movie_category (movie_id, category_id)
            VALUES (@movieId, @categoryId);
        END
        ELSE
        BEGIN
            -- Nếu thể loại không tồn tại, in ra thông báo lỗi
            RAISERROR ('Khong ton tai the loai phim nay', 16, 1);
        END
        FETCH NEXT FROM insert_cursor INTO @movieId, @movieCategory;
    END;

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;
---------------------------------------------------------------------------------------------
CREATE TRIGGER update_movie_dates
ON movies
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE movies
    SET update_at = GETDATE()
    FROM inserted
    WHERE movies.id = inserted.id;

    IF NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        UPDATE movies
        SET create_at = GETDATE()
        WHERE id IN (SELECT id FROM inserted);
    END;
END;

---------------------------------------------------------------------------
CREATE TRIGGER update_users_dates
ON users
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE users
    SET update_at = GETDATE()
    FROM inserted
    WHERE users.id = inserted.id;

    IF NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        UPDATE users
        SET create_at = GETDATE()
        WHERE id IN (SELECT id FROM inserted);
    END;
END;

-------------------------------------------------------------

CREATE TRIGGER update_schedule_dates
ON schedules
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE schedules
    SET update_at = GETDATE()
    FROM inserted
    WHERE schedules.id = inserted.id;

    IF NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        UPDATE schedules
        SET create_at = GETDATE()
        WHERE id IN (SELECT id FROM inserted);
    END;
END;

---------------------------------------------------------------------

-- Tạo trigger để cập nhật tổng tiền trong bảng bills khi một vé mới được chèn vào
CREATE TRIGGER cap_nhat_tong_bill
ON tickets
AFTER INSERT, UPDATE
AS
BEGIN
    
    IF EXISTS (SELECT * FROM inserted)
    BEGIN

        UPDATE b
        SET b.price = b. price + t.price
        FROM bills b
        JOIN inserted i ON b.user_id = i.user_id AND b.schedule_id = i.schedule_id
        JOIN tickets t ON i.id = t.id
        WHERE b.user_id = i.user_id AND b.schedule_id = i.schedule_id;

       
        INSERT INTO bills (user_id, schedule_id, price)
        SELECT i.user_id, i.schedule_id, t.price
        FROM inserted i
        JOIN tickets t ON i.id = t.id
        WHERE NOT EXISTS (
            SELECT 1 FROM bills b
            WHERE b.user_id = i.user_id AND b.schedule_id = i.schedule_id
        );
    END
END;


------------------------------------------------------------------


---------------------------------------------------------\
--Kiểm tra tính hợp lệ khi chèn email
CREATE TRIGGER check_email
ON users
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE email NOT LIKE '%@%.%'
    )
    BEGIN
        RAISERROR ('Invalid email format.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
--------------------------------------------------------------------------------------
-----------------Nếu schedule có movie_id thì set cho is_showing = 1 trong bảng movies
CREATE TRIGGER update_is_showing
ON schedules
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE movies
    SET is_showing = CASE
    WHEN EXISTS (
         SELECT 1 FROM inserted WHERE inserted.movie_id = movies.id
                 )
         THEN 1
		 END
    FROM movies
    WHERE movies.id IN (
        SELECT DISTINCT movie_id FROM inserted
    );
END;


