-- Database Schema Construction Script
-- Tables based on ERD Image provided

CREATE DATABASE IF NOT EXISTS GameDB_MonsterCapture;
USE GameDB_MonsterCapture;

-- Drop all tables to restart
DROP TABLE IF EXISTS BattleSanctum;
DROP TABLE IF EXISTS MasterMons;
DROP TABLE IF EXISTS DinoMoves;
DROP TABLE IF EXISTS DinoEvo;
DROP TABLE IF EXISTS DinoArea;
DROP TABLE IF EXISTS Stats;
DROP TABLE IF EXISTS ShopCharms;
DROP TABLE IF EXISTS AreaMasters;
DROP TABLE IF EXISTS AreasConnections;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Master;
DROP TABLE IF EXISTS Conditions;
DROP TABLE IF EXISTS Charms;
DROP TABLE IF EXISTS Moves;
DROP TABLE IF EXISTS Dino;
DROP TABLE IF EXISTS Connectors;
DROP TABLE IF EXISTS Areas;

-- Create tables
CREATE TABLE Areas (
    AreaId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Text VARCHAR(255),
    LandScape VARCHAR(50),
    Significance VARCHAR(100)
);

CREATE TABLE Connectors (
    ConnectorId INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50),
    Cost INT,
    Safety INT
);

CREATE TABLE AreasConnections (
    ConnectorId INT,
    Area1 INT,
    Area2 INT,
    Significance VARCHAR(100),
    PRIMARY KEY (ConnectorId, Area1, Area2),
    FOREIGN KEY (ConnectorId) REFERENCES Connectors(ConnectorId) ON DELETE CASCADE,
    FOREIGN KEY (Area1) REFERENCES Areas(AreaId) ON DELETE CASCADE,
    FOREIGN KEY (Area2) REFERENCES Areas(AreaId) ON DELETE CASCADE
);

CREATE TABLE Charms (
    CharmId INT PRIMARY KEY AUTO_INCREMENT,
    TimeDuration INT,
    BondLevel INT,
    CapturingRadiance INT
);

CREATE TABLE Master (
    TrainerId INT PRIMARY KEY AUTO_INCREMENT,
    GiveAwayCharm INT,
    Dialog VARCHAR(255),
    StrongestDino INT,
    DinoCount INT,
    Experience INT,
    FOREIGN KEY (GiveAwayCharm) REFERENCES Charms(CharmId) ON DELETE SET NULL
);

CREATE TABLE AreaMasters (
    AreaId INT,
    MasterId INT,
    PRIMARY KEY (AreaId, MasterId),
    FOREIGN KEY (AreaId) REFERENCES Areas(AreaId) ON DELETE CASCADE,
    FOREIGN KEY (MasterId) REFERENCES Master(TrainerId) ON DELETE CASCADE
);

CREATE TABLE Store (
    StoreId INT PRIMARY KEY AUTO_INCREMENT,
    AreaId INT,
    StoreWorker VARCHAR(100),
    Discription VARCHAR(255),
    StoreName VARCHAR(100),
    FOREIGN KEY (AreaId) REFERENCES Areas(AreaId) ON DELETE SET NULL
);

CREATE TABLE ShopCharms (
    ShopId INT,
    CharmId INT,
    Cost INT,
    Experiece INT,
    Area VARCHAR(50),
    PRIMARY KEY (ShopId, CharmId),
    FOREIGN KEY (ShopId) REFERENCES Store(StoreId) ON DELETE CASCADE,
    FOREIGN KEY (CharmId) REFERENCES Charms(CharmId) ON DELETE CASCADE
);

CREATE TABLE Conditions (
    conditionId INT PRIMARY KEY AUTO_INCREMENT,
    Discription VARCHAR(255),
    MustNotUseCharms BOOLEAN
);

CREATE TABLE BattleSanctum (
    BattleNumber INT PRIMARY KEY AUTO_INCREMENT,
    Master1 INT,
    Master2 INT,
    Rounds INT,
    conditionId INT,
    Location INT,
    FOREIGN KEY (Master1) REFERENCES Master(TrainerId) ON DELETE CASCADE,
    FOREIGN KEY (Master2) REFERENCES Master(TrainerId) ON DELETE CASCADE,
    FOREIGN KEY (conditionId) REFERENCES Conditions(conditionId) ON DELETE SET NULL,
    FOREIGN KEY (Location) REFERENCES Areas(AreaId) ON DELETE SET NULL
);

CREATE TABLE Dino (
    Dinold INT PRIMARY KEY AUTO_INCREMENT,
    DinoName VARCHAR(100) NOT NULL,
    DinoFamily VARCHAR(100)
);

CREATE TABLE MasterMons (
    Dinold INT,
    MasterId INT,
    Ropeld INT,
    RelicId INT,
    PRIMARY KEY (Dinold, MasterId, Ropeld),
    FOREIGN KEY (Dinold) REFERENCES Dino(Dinold) ON DELETE CASCADE,
    FOREIGN KEY (MasterId) REFERENCES Master(TrainerId) ON DELETE CASCADE
);

CREATE TABLE Stats (
    Dinold INT PRIMARY KEY,
    Attack INT,
    Defense INT,
    Chant INT,
    FOREIGN KEY (Dinold) REFERENCES Dino(Dinold) ON DELETE CASCADE
);

CREATE TABLE DinoArea (
    AreaId INT,
    Dinold INT,
    LevelObservable INT,
    PRIMARY KEY (AreaId, Dinold),
    FOREIGN KEY (AreaId) REFERENCES Areas(AreaId) ON DELETE CASCADE,
    FOREIGN KEY (Dinold) REFERENCES Dino(Dinold) ON DELETE CASCADE
);

CREATE TABLE DinoEvo (
    BaseDino INT,
    EvoDino INT,
    RequiredLevel INT,
    RequiredCharm INT,
    Location INT,
    PRIMARY KEY (BaseDino, EvoDino),
    FOREIGN KEY (BaseDino) REFERENCES Dino(Dinold) ON DELETE CASCADE,
    FOREIGN KEY (EvoDino) REFERENCES Dino(Dinold) ON DELETE CASCADE,
    FOREIGN KEY (RequiredCharm) REFERENCES Charms(CharmId) ON DELETE SET NULL,
    FOREIGN KEY (Location) REFERENCES Areas(AreaId) ON DELETE SET NULL
);

CREATE TABLE Moves (
    Moveld INT PRIMARY KEY AUTO_INCREMENT,
    Discription VARCHAR(255),
    Damage INT,
    AddedEffects VARCHAR(255)
);

CREATE TABLE DinoMoves (
    Dinold INT,
    Moveld INT,
    LevelCap INT,
    Area VARCHAR(50),
    Charms INT,
    PRIMARY KEY (Dinold, Moveld),
    FOREIGN KEY (Dinold) REFERENCES Dino(Dinold) ON DELETE CASCADE,
    FOREIGN KEY (Moveld) REFERENCES Moves(Moveld) ON DELETE CASCADE,
    FOREIGN KEY (Charms) REFERENCES Charms(CharmId) ON DELETE SET NULL
);

