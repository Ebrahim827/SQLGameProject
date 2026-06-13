-- Populate Seed Data for Monster Game Capture
USE GameDB_MonsterCapture;

-- 1. Inserting Data into Areas
INSERT INTO Areas (Name, Text, LandScape, Significance)
VALUES
('Veridian Forest', 'A dense forest with many bugs.', 'Forest', 'Early Game'),
('Mt. Moon', 'A mysterious mountain.', 'Mountain', 'Key Location'),
('Cerulean City', 'The floral city.', 'City', 'Gym Location'),
('Route 1', 'A calm path.', 'Plains', 'Starting Route'),
('Route 2', 'Path to Viridian.', 'Plains', 'Transition'),
('Pewter City', 'The stone city.', 'City', 'Gym Location'),
('Route 3', 'Rocky mountain path.', 'Mountain', 'Transition'),
('Route 4', 'Path to Cerulean.', 'Mountain', 'Transition'),
('Lavender Town', 'The noble town.', 'Town', 'Ghost Tower Location'),
('Celadon City', 'City of dreams.', 'City', 'Shopping Hub');

-- 2. Inserting Data into Connectors
INSERT INTO Connectors (Type, Cost, Safety)
VALUES
('Road', 0, 9), ('Cave', 0, 5), ('Bridge', 10, 8), ('Tunnel', 0, 7), ('Ferry', 50, 6),
('Path', 0, 9), ('Mountain Pass', 0, 4), ('Underground Path', 0, 8), ('Cycling Road', 0, 7), ('Surf', 0, 5);

-- 3. Inserting Data into Charms
INSERT INTO Charms (TimeDuration, BondLevel, CapturingRadiance)
VALUES
(100, 1, 10), (120, 2, 15), (150, 3, 20), (200, 4, 25), (60, 1, 5),
(250, 5, 30), (300, 6, 35), (180, 2, 18), (220, 3, 22), (400, 8, 50);

-- 4. Inserting Data into Master (Trainers) - Ancient Samurai Names
INSERT INTO Master (GiveAwayCharm, Dialog, StrongestDino, DinoCount, Experience)
VALUES
(1, 'Honor through combat!', 1, 2, 50),
(2, 'The path of the warrior beckons!', 2, 3, 100),
(3, 'Stone-hearted and steadfast!', 15, 2, 150),
(4, 'Nature embraces the warrior!', 4, 4, 80),
(1, 'Destiny leads forward!', 7, 1, 40),
(2, 'Harness the flowing waters!', 9, 3, 110),
(3, 'The flames demand mastery!', 5, 2, 120),
(4, 'Spirits guide my hand!', 10, 3, 150),
(1, 'Swift as the lightning!', 11, 2, 90),
(2, 'Absolute strength is victory!', 12, 1, 200);

-- 5. Inserting Data into Dino (Creatures)
INSERT INTO Dino (DinoName, DinoFamily)
VALUES
('Bulbasaur', 'Grass/Poison'), ('Ivysaur', 'Grass/Poison'), ('Venusaur', 'Grass/Poison'),
('Charmander', 'Fire'), ('Charmeleon', 'Fire'), ('Charizard', 'Fire/Flying'),
('Squirtle', 'Water'), ('Wartortle', 'Water'), ('Blastoise', 'Water'),
('Pikachu', 'Electric');

-- 6. Inserting Data into Moves
INSERT INTO Moves (Discription, Damage, AddedEffects)
VALUES
('Tackle', 40, 'None'), ('Scratch', 40, 'None'), ('Ember', 40, 'Burn'), ('Water Gun', 40, 'None'),
('Vine Whip', 45, 'None'), ('Thunder Shock', 40, 'Paralyze'), ('Bite', 60, 'Flinch'),
('Flamethrower', 90, 'Burn'), ('Hydro Pump', 110, 'None'), ('Solar Beam', 120, 'Charge');

-- 7. Inserting Data into Stats
INSERT INTO Stats (Dinold, Attack, Defense, Chant)
VALUES
(1, 49, 49, 45), (2, 62, 63, 60), (3, 82, 83, 80), (4, 52, 43, 65), (5, 64, 58, 80),
(6, 84, 78, 100), (7, 48, 65, 43), (8, 63, 80, 58), (9, 83, 100, 78), (10, 55, 40, 90);

-- 8. Inserting Data into MasterMons (Trainer's Dinos with Ropes/Relics)
INSERT INTO MasterMons (Dinold, MasterId, Ropeld, RelicId)
VALUES
(1, 1, 1, 0), (4, 2, 2, 0), (7, 3, 3, 1), (10, 4, 4, 1), (2, 5, 5, 0),
(5, 6, 6, 2), (8, 7, 7, 0), (3, 8, 8, 3), (6, 9, 9, 1), (9, 10, 10, 4);

-- 9. Inserting Data into Conditions
INSERT INTO Conditions (Discription, MustNotUseCharms)
VALUES
('No Items', TRUE), ('Normal Battle', FALSE), ('Weather: Rain', FALSE), ('Weather: Sun', FALSE), ('Weather: Hail', FALSE),
('No Switching', FALSE), ('Level Cap 20', FALSE), ('Level Cap 50', FALSE), ('Only Charms Allowed', FALSE), ('Only Water Types Allowed', FALSE);

-- 10. Inserting Data into BattleSanctum
INSERT INTO BattleSanctum (Master1, Master2, Rounds, conditionId, Location)
VALUES
(1, 2, 3, 2, 1), (3, 4, 3, 1, 2), (5, 6, 5, 2, 3), (7, 8, 3, 3, 4), (9, 10, 5, 4, 5),
(1, 3, 3, 2, 6), (2, 4, 3, 1, 7), (5, 7, 5, 3, 8), (6, 8, 3, 4, 9), (9, 1, 5, 2, 10);

-- 11. Inserting Data into Store
INSERT INTO Store (AreaId, StoreWorker, Discription, StoreName)
VALUES
(1, 'Clerk A', 'Sells basic items', 'Poke Mart Viridian'), (3, 'Clerk B', 'Sells water items', 'Poke Mart Cerulean'),
(6, 'Clerk C', 'Sells rocks', 'Poke Mart Pewter'), (9, 'Clerk D', 'Sells incense', 'Lavender Mart'),
(10, 'Manager E', 'Sells everything', 'Celadon Department Store'), (2, 'Hiker F', 'Sells ropes', 'Mt Moon Store'),
(4, 'Lass G', 'Sells potions', 'Route 4 Shop'), (5, 'Bug Catcher H', 'Sells nets', 'Route 2 Stall'),
(7, 'Camper I', 'Sells tents', 'Route 3 Outpost'), (8, 'Picnicker J', 'Sells lunch', 'Route 4 Picnic Store');

-- 12. Inserting Data into ShopCharms
INSERT INTO ShopCharms (ShopId, CharmId, Cost, Experiece, Area)
VALUES
(1, 1, 100, 10, 'General'), (1, 2, 200, 20, 'General'), (2, 3, 300, 30, 'Water'), (2, 4, 400, 40, 'Water'),
(3, 1, 150, 15, 'Rock'), (3, 5, 250, 25, 'Rock'), (4, 6, 500, 50, 'Ghost'), (5, 7, 1000, 100, 'All'),
(5, 8, 800, 80, 'All'), (5, 9, 1500, 150, 'Elite');

-- 13. Inserting Data into DinoEvo
INSERT INTO DinoEvo (BaseDino, EvoDino, RequiredLevel, RequiredCharm, Location)
VALUES
(1, 2, 16, NULL, NULL), (2, 3, 32, NULL, NULL),
(4, 5, 16, NULL, NULL), (5, 6, 36, NULL, NULL),
(7, 8, 16, NULL, NULL), (8, 9, 36, NULL, NULL),
(10, 10, 50, 1, 1), (1, 3, 50, 2, 2), (4, 6, 50, 3, 3), (7, 9, 50, 4, 4);

-- 14. Inserting Data into DinoArea
INSERT INTO DinoArea (AreaId, Dinold, LevelObservable)
VALUES
(1, 1, 5), (1, 4, 5), (1, 7, 5), (1, 10, 5), (2, 2, 16),
(3, 5, 16), (4, 8, 16), (5, 3, 32), (6, 6, 36), (7, 9, 36);

-- 15. Inserting Data into DinoMoves
INSERT INTO DinoMoves (Dinold, Moveld, LevelCap, Area, Charms)
VALUES
(1, 1, 5, 'Any', NULL), (1, 5, 10, 'Any', NULL), (4, 2, 5, 'Any', NULL), (4, 3, 10, 'Any', NULL),
(7, 1, 5, 'Any', NULL), (7, 4, 10, 'Any', NULL), (10, 1, 5, 'Any', NULL), (10, 6, 10, 'Any', NULL),
(6, 8, 36, 'Any', NULL), (9, 9, 36, 'Any', NULL);

-- 16. Inserting Data into AreaMasters
INSERT INTO AreaMasters (AreaId, MasterId)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- 17. Inserting Data into AreasConnections
INSERT INTO AreasConnections (ConnectorId, Area1, Area2, Significance)
VALUES
(1, 1, 2, 'Main Road'), (2, 2, 3, 'Cave Path'), (3, 3, 4, 'Bridge crossing'), (4, 4, 5, 'Tunnel way'), (5, 5, 6, 'Water path'),
(6, 6, 7, 'Mountain pass'), (7, 7, 8, 'Steep climb'), (8, 8, 9, 'Underground'), (9, 9, 10, 'Bike road'), (10, 10, 1, 'Surf route');

