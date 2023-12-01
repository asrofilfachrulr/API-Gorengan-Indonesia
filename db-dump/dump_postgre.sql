DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  image_url varchar(255),
  PRIMARY KEY (id),
  CONSTRAINT username_unique UNIQUE (username),
  CONSTRAINT email_unique UNIQUE (email)
);

INSERT INTO users (id, name, username, email, image_url) VALUES
('@id_userVeangubOW973XBCsyw02O', 'anya', 'anya', 'anya@mail.com', NULL),
('@id_userZO_qpVsZemY5ZF_lxgz00', 'Sari Puspita Hasna', 'hasna', 'saripuspitahasna@mail.com', NULL),
('admin', 'admin', 'admin', 'admin@admin.com', NULL);

DROP TABLE IF EXISTS auth;
CREATE TABLE auth (
  user_id varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  CONSTRAINT auth_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO auth (user_id, password) VALUES
('admin',	'$2b$10$ZnQJ6BiS.IOR./HY5bKQj.afRu4RWlWo2k0y2oDdthgs5cQlHC/hm'),
('@id_userVeangubOW973XBCsyw02O',	'$2b$10$aGCopmemD58Fm4cb0eFxo.BcUjiEbVb2dcTaIEobf7cStNRF0BKgK'),
('@id_userZO_qpVsZemY5ZF_lxgz00',	'$2b$10$qoM/hQsyX6xt5k/VDUMP6.OnbDVNiO71bd4pzYM/WczS7dbu5Nm2S');

DROP VIEW IF EXISTS user_auth;
CREATE VIEW user_auth AS
SELECT users.id AS id, users.username AS username, users.name AS name, auth.password AS password, users.email AS email
FROM users
JOIN auth ON users.id = auth.user_id;

DROP TABLE IF EXISTS receipts;
CREATE TABLE receipts (
  id varchar(255) PRIMARY KEY,
  user_id varchar(255) REFERENCES users (id) ON DELETE CASCADE,
  title varchar(255) NOT NULL,
  category varchar(255) NOT NULL,
  imgUrl varchar(255) NOT NULL,
  difficulty varchar(255) NOT NULL,
  portion integer NOT NULL,
  minute_duration integer NOT NULL,
  UNIQUE (title)
);

INSERT INTO receipts (id, user_id, title, category, imgUrl, difficulty, portion, minute_duration) VALUES
('receipt-1', 'admin', 'Cireng Pedas Nuklir', 'Aci', '', 'Mudah', 3, 30),
('receipt-2', '@id_userZO_qpVsZemY5ZF_lxgz00', 'Cookies Putri Salju', 'Manis / Cookies', '', 'Sedang', 85, 180),
('receipt-3', '@id_userZO_qpVsZemY5ZF_lxgz00', 'Zuppa Soup Ayam [Chicken Pot Pie]', 'Pastry', '', 'Sedang', 9, 120),
('receipt-4', '@id_userZO_qpVsZemY5ZF_lxgz00', 'Churros', 'Manis', '', 'Mudah', 10, 30),
('receipt-5', '@id_userZO_qpVsZemY5ZF_lxgz00', 'Tahu Kwalik Ayam', 'Aci', '', 'Mudah', 20, 60),
('receipt-6', '@id_userZO_qpVsZemY5ZF_lxgz00', 'Cheese Stick', 'Keju', '', 'Mudah', 500, 60);


DROP TABLE IF EXISTS ingredients;
CREATE TABLE ingredients (
  receipt_id varchar(255) NOT NULL,
  qty varchar(255) NOT NULL,
  unit varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  CONSTRAINT ingredients_ibfk_1 FOREIGN KEY (receipt_id) REFERENCES receipts (id) ON DELETE CASCADE
);

INSERT INTO ingredients (receipt_id, qty, unit, name) VALUES
('receipt-1', '250', 'gram', 'tepung kanji'),
('receipt-1', '2', 'siung', 'bawang putih, haluskan'),
('receipt-2', '120', 'gram', 'mentega tawar (suhu ruang)'),
('receipt-2', '120', 'gram', 'dutch butter(suhu ruang)'),
('receipt-2', '110', 'gram', 'gula halus'),
('receipt-2', '1', 'sdt', 'perisa Vanila'),
('receipt-2', '1/8', 'sdt', 'garam'),
('receipt-2', '2', 'butir', 'telur'),
('receipt-2', '270', 'gram', 'tepung terigu protein sedang'),
('receipt-2', '55', 'gram ', 'maizena'),
('receipt-2', '100', 'gram ', 'kacang mede panggang'),
('receipt-2', 'sesuai selera', '""', 'Gula halus(dekstrosa)'),
('receipt-3', '500', 'gram', 'Ayam Paha Bawah'),
('receipt-3', '2', 'buah', 'Wortel'),
('receipt-3', '2', 'lembar', 'Bay Leaf'),
('receipt-3', '3', 'siung', 'bawang putih'),
('receipt-3', '1', 'liter', 'air'),
('receipt-3', '1/4', 'sdt', 'lada hitam'),
('receipt-3', '6', 'sdm', 'tepung terigu protein sedang'),
('receipt-3', '4', 'sdm ', 'mentega tawar'),
('receipt-3', '200', 'ml', 'cooking cream'),
('receipt-3', '1/2', 'sdt', 'garam'),
('receipt-3', '1', 'sdt', 'gula pasir'),
('receipt-3', '1', 'sdt', 'kaldu ayam bubuk'),
('receipt-3', '1/8', 'sdt', 'merica '),
('receipt-3', '1/8', 'sdt', 'pala bubuk'),
('receipt-3', '550', 'ml', 'kuah kaldu ayam'),
('receipt-3', '1/2', 'buah', 'bawang bombay ukuran besar'),
('receipt-3', '150', 'gram', 'sosis ayam'),
('receipt-3', '195', 'gram', 'ayam'),
('receipt-3', '100', 'gram', 'kacang polong'),
('receipt-3', '0', 'sesuaikan dengan gelas', 'Puff Pastry'),
('receipt-3', '0', 'secukupnya', 'Telur untuk olesan '),
('receipt-3', '0', 'secukupnya', 'wijen putih '),
('receipt-4', '150', 'gram', 'Tepung Terigu'),
('receipt-4', '250', 'ml', 'air'),
('receipt-4', '1', 'butir', 'telur'),
('receipt-4', '50', 'gram', 'margarin'),
('receipt-4', '1', 'sdm', 'gula'),
('receipt-4', '1/4', 'sdt', 'garam'),
('receipt-5', '10', 'buah', 'tahu pong (cokelat)'),
('receipt-5', '250', 'gram', 'daging ayam dan kulit'),
('receipt-5', '4', 'sdm', 'tepung tapioka'),
('receipt-5', '3', 'siung ', 'bawang putih '),
('receipt-5', '1', 'butir', 'telur'),
('receipt-5', '80', 'gram', 'es batu'),
('receipt-5', '1', 'sdt', 'garam'),
('receipt-5', '1', 'sdt', 'merica'),
('receipt-5', '""', 'secukupnya', 'kaldu jamur'),
('receipt-6', '300', 'gram', 'tepung serba guna'),
('receipt-6', '75', 'gram', 'tapioka'),
('receipt-6', '60', 'ml', 'air'),
('receipt-6', '50 ', 'gram', 'margarin cair'),
('receipt-6', '1', 'butir', 'telur utuh'),
('receipt-6', '100', 'ml', 'putih telur'),
('receipt-6', '100', 'gram', 'keju parut'),
('receipt-6', '1/2', 'sdt', 'garam'),
('receipt-6', '2', 'batang ', 'seledri iris halus'),
('receipt-6', '8', 'siuang ', 'bawang putih haluskan'),
('receipt-6', '0', 'secukupnya', 'minyak goreng');

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id serial PRIMARY KEY,
  receipt_id varchar(255) NOT NULL,
  user_id varchar(255),
  stars int NOT NULL,
  comment varchar(255),
  FOREIGN KEY (receipt_id) REFERENCES receipts (id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS steps;
CREATE TABLE steps (
  receipt_id varchar(255) NOT NULL,
  number int NOT NULL,
  step varchar(255) NOT NULL,
  PRIMARY KEY (receipt_id, step),
  CONSTRAINT steps_ibfk_1 FOREIGN KEY (receipt_id) REFERENCES receipts (id) ON DELETE CASCADE
);


INSERT INTO steps (receipt_id, number, step) VALUES
('receipt-1',	1,	'Campur tepung kanji, tepung terigu, bawang putih, garam, gula, dan kaldu ayam bubuk (jika digunakan) dalam mangkuk besar'),
('receipt-2',	8,	'Bentuk adonan seperti bulan sabit kemudian susun ke dalam loyang yang telah dialasi baking paper '),
('receipt-2',	3,	'Cincang kacang mede lalu masukkan ke dalam adonan, aduk rata'),
('receipt-2',	5,	'Gunakan sedikit tepung terigu supaya tidak lengket lalu potong miring. Bentuk seperti bulan sabit lalu susun ke dalam loyang yang sudah dialasi baking paper'),
('receipt-2',	11,	'Keluarkan dari panggangan lalu balurkan ke dalam gula donat'),
('receipt-2',	1,	'Kocok dutch butter, mentega, dan gula halus hingga pucat dan mengembang kemudian tambahkan perisa vanila, garam, dan kuning telur, kocok sesaat hingga menyatu'),
('receipt-2',	12,	'Kue putri salju siap dihidangkan'),
('receipt-2',	7,	'Masukkan ke dalam freezer selama 1 jam. Ambil 1 bagian adonan, taburkan sedikit tepung terigu kemudian potong-potong miring'),
('receipt-2',	2,	'Masukkan tepung terigu dan maizena sambil disaring, aduk rata secara perlahan dengan spatula'),
('receipt-2',	9,	'Panggang dengan api bawah selama 30 menit di api kecil lalu panggang dengan api atas bawah selama 10 menit '),
('receipt-2',	6,	'Untuk cara kedua, masukkan adonan ke dalam wadah plastik kemudian ratakan kurang lebih ukuran 20 x 29 cm lalu bagi menjadi 5 bagian dengan benda tumpul'),
('receipt-2',	4,	'Untuk cara pertama, masukkan adonan ke dalam kulkas selama 1-2 jam kemudian ambil 1 kepal adonan, bentuk roll memanjang seukuran jempol '),
('receipt-2',	10,	'Untuk penggunaan oven listrik, panggang di suhu 130 derajat celcius selama 30-40 menit api atas bawah'),
('receipt-3',	10,	'Chicken pot pie siap disajikan'),
('receipt-3',	3,	'Keluarkan wortel dari panci kemudian potong kotak-kotak'),
('receipt-3',	5,	'Masukkan mentega, tepung terigu, dan pala bubuk, aduk sesaat lalu masukkan kuah kaldu sambil disaring'),
('receipt-3',	7,	'Masukkan wortel, kacang polong, garam, gula pasir, merica, kaldu ayam, dan cooking cream, masak sesaat'),
('receipt-3',	9,	'Oles dengan telur dan taburkan wijen. Panggang di suhu 190 derajat celcius selama 15 menit '),
('receipt-3',	4,	'Panaskan sedikit minyak, tumis bawang bombai hingga wangi kemudian masukkan chicken luncheon, dan sosis, tumis sesaat'),
('receipt-3',	2,	'Potong kotak bawang bombai, chicken luncheon dan sosis.'),
('receipt-3',	1,	'Rebus air, ayam,wortel, bawang putih, bay leaf, seledri, dan lada hitam. Masak hingga mendidih kemudian lanjut masak di api kecil selama 15 menit'),
('receipt-3',	6,	'Suwir ayam, potong-potong lalu masukkan ke dalam kuah'),
('receipt-3',	8,	'Tuang ke dalam wadah tahan panas kemudian bagi 4 puff pastry, simpan di atas cetakan'),
('receipt-4',	5,	'Angkat, tiriskan, dan biarkan hangat. Lalu gulingkan ke gula pasir lalu dicocol dengan saus cokelat.'),
('receipt-4',	4,	'Lalu goreng dengan minyak yang sudah dipanaskan sampai golden brown. (gunakan api kecil cenderung sedang)'),
('receipt-4',	1,	'Masak air, gula, garam, dan margarin sampai mendidih, kecilkan kompor lalu masukkan terigu lalu aduk sampai kalis, angkat lalu dinginkan'),
('receipt-4',	3,	'Masukkan ke plastik segitiga, spuitkan panjang-panjang di atas kertas roti lalu simpan di kulkas 1 jam'),
('receipt-4',	2,	'Setelah dingin masukkan telur sambil diaduk sampai rata'),
('receipt-5',	3,	'Abis kulit tahu, beri isian adonan ayam, lakukan sampai adonan habis.'),
('receipt-5',	1,	'Belah 2 tahu bentuk segitiga, kemudian balik tahu, ambil bagian dalam tahu, sisihkan'),
('receipt-5',	4,	'Kukus tahu 10 menit. Setelah agak dingin goreng tahu walik secukupnya, sisanya bisa disimpan di lemari es.'),
('receipt-5',	2,	'Masukkan di chooper semua bahan kecuali kulit tahu, tambahkan isian tahu (bagian putih), haluskan.'),
('receipt-6',	1,	'Campur margarin cair dan telur, aduk rata. Masukkan semua bahan kecuali air.'),
('receipt-6',	3,	'Giling adonan lalu potong memanjang.'),
('receipt-6',	4,	'Goreng sampai kuning keemasan.'),
('receipt-6',	2,	'Tuang air sedikit demi sedikit, uleni sampai kalis.');
