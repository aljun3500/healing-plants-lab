-- Healing Plants Database (MySQL 8) - source: Amazing Healing Plants by Dr. JC Kurian
CREATE DATABASE IF NOT EXISTS healing_plants CHARACTER SET utf8mb4;
USE healing_plants;
CREATE TABLE family (id INT PRIMARY KEY AUTO_INCREMENT, family_name VARCHAR(80) NOT NULL UNIQUE);
CREATE TABLE conservation_status (id INT PRIMARY KEY AUTO_INCREMENT, status_name VARCHAR(40) NOT NULL UNIQUE);
CREATE TABLE region (id INT PRIMARY KEY AUTO_INCREMENT, region_name VARCHAR(40) NOT NULL UNIQUE);
CREATE TABLE species (id INT PRIMARY KEY AUTO_INCREMENT, scientific_name VARCHAR(120) NOT NULL, common_name VARCHAR(120), toxic TINYINT(1) NOT NULL DEFAULT 0, endemic TINYINT(1) NOT NULL DEFAULT 0, family_id INT NOT NULL, status_id INT NOT NULL DEFAULT 1, medicinal_use TEXT, description TEXT, image_url VARCHAR(255), image_credit VARCHAR(120) DEFAULT 'Dr. JC Kurian and Roshan Raphael', source VARCHAR(255), FOREIGN KEY (family_id) REFERENCES family(id), FOREIGN KEY (status_id) REFERENCES conservation_status(id));
CREATE TABLE local_name (id INT PRIMARY KEY AUTO_INCREMENT, species_id INT NOT NULL, name VARCHAR(80) NOT NULL, language VARCHAR(30) NOT NULL, FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE);
CREATE TABLE species_region (species_id INT NOT NULL, region_id INT NOT NULL, PRIMARY KEY (species_id, region_id), FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE, FOREIGN KEY (region_id) REFERENCES region(id));
INSERT INTO family (id,family_name) VALUES (1,'Malvaceae'),(2,'Apiaceae'),(3,'Euphorbiaceae'),(4,'Fabaceae'),(5,'Verbenaceae'),(6,'Brassicaceae'),(7,'Myrtaceae'),(8,'Poaceae'),(9,'Nyctaginaceae'),(10,'Moringaceae'),(11,'Musaceae'),(12,'Lamiaceae'),(13,'Phyllanthaceae'),(14,'Portulacaceae'),(15,'Asteraceae'),(16,'Ebenaceae'),(17,'Annonaceae');
INSERT INTO conservation_status (id,status_name) VALUES (1,'Not Evaluated'),(2,'Least Concern'),(3,'Vulnerable'),(4,'Endangered'),(5,'Critically Endangered');
INSERT INTO region (id,region_name) VALUES (1,'Luzon'),(2,'Visayas'),(3,'Mindanao'),(4,'Palawan');
INSERT INTO species (id,scientific_name,common_name,toxic,endemic,family_id,status_id,medicinal_use) VALUES
(1,'Abutilon indicum','Indian Mallow',0,0,1,1,'Soothes and protects the alimentary tract, relieves inflammation; brings down fever; softens inflamed parts; promotes urine flow; laxative; promotes removal of mucous secretions from bronchial tubes; chronic inflammation of urethra and urinary bladder.'),
(2,'Centella asiatica','Indian Pennywort',0,0,2,1,'Alters nutrition and excretion; promotes urine flow; reduces inflammation; gentle laxative; purifies blood; soothes nerves; local stimulant; leprosy, skin diseases, chronic ulcers, contagious sores, chronic rheumatism, piles; swellings and inflammations; checks fever; dysentery; memory tonic; hair growth and hair fall.'),
(3,'Euphorbia hirta','Snake Weed',0,0,3,1,'Asthma; coughs, bowel complaints, stomach ache, dysentery; acute abdominal pains; skin disease and mouth infection; stops local bleeding; snakebite antidote; eye diseases.'),
(4,'Glycine max','Soya Bean',0,0,4,1,'Malnutrition; allergies; diabetes; skin and eye diseases; dandruff; laxative; promotes hair growth.'),
(5,'Stachytarpheta indica','Aaron''s Rod',0,0,5,1,'Ulcers; ophthalmic problems; diarrhoea and dysentery; fevers; rheumatic inflammations; cardiac problems; expels intestinal worms; erysipelas or infectious diseases; oedema; stomach ailments.'),
(6,'Cassia alata','Ringworm Shrub',0,0,4,1,'Ringworm; cough; asthma; vermicide; eczema.'),
(7,'Cleome viscosa','Wild Mustard',0,0,6,1,'Expels worms; digestion; laxative; reduces inflammations; skin ailments; leprosy; blood diseases; cough; earache; cardiac stimulant.'),
(8,'Syzygium jambos','Rose Apple',0,0,7,1,'Asthma; fatigue; dysentery; bronchitis; liver complaints; brain tonic; syphilis; sore eyes; fever.'),
(9,'Cynodon dactylon','Bermuda Grass',0,0,8,1,'Promotes urine flow; irritation of urinary organs and bladder; oedema and syphilis; checks vomiting; bleeding piles; conjunctivitis; minor cuts and wounds; rheumatism and gout; high cholesterol.'),
(10,'Mimosa pudica','Sensitive Plant',0,0,4,1,'Liver disease, constipation, dysentery, kidney problems; mouth and throat inflammations; cancerous ulcers, skin diseases, glandular swellings; scorpion sting; urinary complaints; purgative; mumps.'),
(11,'Mirabilis jalapa','Four-O''Clock Plant',1,0,9,1,'Promotes urine flow; inflammatory viral skin disease; abnormal liquid in cellular tissue; boils, enlarged lymph nodes, pus in a cavity; heals wounds, bruises, skin allergy from indigestion; earaches; removes freckles.'),
(12,'Moringa oleifera','Drumstick',0,0,10,1,'Urinary problems; reduces inflammation; earaches; dental caries; cardiac stimulant in asthma; cough; scurvy; wounds and eye diseases; intermittent fevers, epilepsy, hysteria, palsy, rheumatism, gout, dropsy, dyspepsia, enlarged liver; paralysis.'),
(13,'Musa paradisiaca','Banana',0,0,11,1,'Root: liver congestion tonic, scurvy, glandular and venereal disease, anaemia, diarrhoea. Stem: ulcer, thirst in cholera, nervous disorders, hysteria, dysentery, jaundice, opium poisoning antidote, bleeding wounds, asthma, inflamed kidneys, hair loss, piles. Leaves: eye inflammation, wounds and ulcers, headaches, blisters. Flowers: excessive menstrual bleeding, diabetes, earaches. Fruit: diabetes, spitting of blood, diarrhoea, indigestion, flatulence, scurvy, urine flow, gentle laxative, sore throat, chest congestion, dysentery, anaemia, inflamed colon, rectal diseases.'),
(14,'Ocimum basilicum','Sweet Basil',0,0,12,1,'Relieves gas in stomach/intestines, stimulates appetite; prevents sudden muscle contractions; increases milk secretion during lactation; strengthens the stomach; removes bronchial mucus; soothes alimentary tract; diarrhoea, dysentery, chronic constipation; whooping cough; bowel complaints in children; intestinal problems, stomach cramps, vomiting.'),
(15,'Phyllanthus fraternus','Phyllanthus',0,0,13,1,'Promotes urine flow; tones the stomach; promotes menstrual flow; reduces fever; mild laxative; eliminates kidney and gall stones; kidney colic; cystitis; dropsy; prostate problems; urogenital diseases; early jaundice; indigestion, dysentery, gonorrhoea; diabetes, sores, fevers.'),
(16,'Portulaca oleracea','Purslane',0,0,14,1,'Liver, kidney and bladder problems; scurvy; increases milk flow in nursing mothers; painful urination; dry coughs, shortness of breath, thirst; inflamed eyes, mouth sores, swollen gums; loose teeth; burns; hastens wound healing; promotes urine and menstrual flow; expels intestinal worms; digestion.'),
(17,'Tridax procumbens','Mexican Daisy',0,0,15,1,'Checks haemorrhage of wounds; bronchial catarrh; dysentery and diarrhoea.'),
(18,'Wrightia tomentosa','Ivory Tree',0,0,16,1,'Menstrual and renal complaints; fever.'),
(19,'Annona muricata','Soursop',1,0,17,1,'Kidney problems; increases perspiration and used to cause vomiting; spasms; dysentery; scurvy; constipation, obesity, hypertension, coronary disease, diabetes.'),
(20,'Annona squamosa','Custard Apple',1,0,17,1,'Anaemia; causes vomiting; dandruff; indigestion; relieves fainting spells; vermicidal and insecticidal; strong laxative.');
INSERT INTO local_name (species_id,name,language) VALUES
(1,'Malbas','Filipino'),
(2,'Takip-kohol','Filipino'),
(2,'Gotu kola','English'),
(3,'Tawa-tawa','Filipino'),
(4,'Soya','Filipino'),
(5,'Kandi-kandilaan','Filipino'),
(6,'Akapulko','Filipino'),
(7,'Mustasa','Filipino'),
(8,'Tambis','Filipino'),
(9,'Bakbakan','Filipino'),
(10,'Makahiya','Filipino'),
(11,'Alas-kuwatro','Filipino'),
(12,'Malunggay','Filipino'),
(13,'Saging','Filipino'),
(14,'Sangig','Filipino'),
(15,'Sampa-sampalukan','Filipino'),
(16,'Gulasiman','Filipino'),
(17,'Bulak-manok','Filipino'),
(18,'Bantolinao','Filipino'),
(19,'Guyabano','Filipino'),
(20,'Atis','Filipino');
-- Placeholder: every species linked to all regions. Replace with real distribution data.
INSERT INTO species_region (species_id,region_id) SELECT s.id,r.id FROM species s CROSS JOIN region r;
-- Image paths (files in /images)
UPDATE species SET image_url='images/indian-mallow.jpg' WHERE id=1;
UPDATE species SET image_url='images/indian-pennywort.jpg' WHERE id=2;
UPDATE species SET image_url='images/snake-weed.jpg' WHERE id=3;
UPDATE species SET image_url='images/soya-bean.jpg' WHERE id=4;
UPDATE species SET image_url='images/aarons-rod.jpg' WHERE id=5;
UPDATE species SET image_url='images/ringworm-shrub.jpg' WHERE id=6;
UPDATE species SET image_url='images/wild-mustard.jpg' WHERE id=7;
UPDATE species SET image_url='images/rose-apple.jpg' WHERE id=8;
UPDATE species SET image_url='images/bermuda-grass.jpg' WHERE id=9;
UPDATE species SET image_url='images/sensitive-plant.jpg' WHERE id=10;
UPDATE species SET image_url='images/four-oclock.jpg' WHERE id=11;
UPDATE species SET image_url='images/drumstick.jpg' WHERE id=12;
UPDATE species SET image_url='images/banana.jpg' WHERE id=13;
UPDATE species SET image_url='images/sweet-basil.jpg' WHERE id=14;
UPDATE species SET image_url='images/phyllanthus.jpg' WHERE id=15;
UPDATE species SET image_url='images/purslane.jpg' WHERE id=16;
UPDATE species SET image_url='images/mexican-daisy.jpg' WHERE id=17;
UPDATE species SET image_url='images/ivory-tree.jpg' WHERE id=18;
UPDATE species SET image_url='images/soursop.jpg' WHERE id=19;
UPDATE species SET image_url='images/custard-apple.jpg' WHERE id=20;
