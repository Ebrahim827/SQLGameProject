# Database Schema Documentation & Normalization Analysis

## Overview
This document describes a comprehensive schema for a creature capturing and battling game system. The database is designed to manage territories (Areas), mystical artifacts (Charms), creatures (Dinos), trained warriors (Masters), battle sanctuaries, movement systems, and evolutionary transformations. The schema follows relational database best practices with proper normalization to ensure data integrity and query efficiency.

---

## Detailed Entity Descriptions

### 1. **Areas**
**Purpose:** Represents distinct geographic locations/territories within the game world where creatures and trainers interact.

**Attributes:**
- `AreaId` (PK, INT, AUTO_INCREMENT): Unique identifier for each area
- `Name` (VARCHAR(100), NOT NULL): Name of the area (e.g., "Veridian Forest", "Mt. Moon")
- `Text` (VARCHAR(255)): Narrative description or flavor text describing the area's characteristics
- `LandScape` (VARCHAR(50)): Terrain type classification (Forest, Mountain, City, Plains, Town, etc.)
- `Significance` (VARCHAR(100)): Strategic importance (Early Game, Key Location, Gym Location, Shopping Hub, etc.)

**Constraints:** Primary Key on AreaId; Areas are foundational entities referenced by multiple tables

---

### 2. **Store**
**Purpose:** Manages retail establishments within areas where trainers can purchase items and charm artifacts.

**Attributes:**
- `StoreId` (PK, INT, AUTO_INCREMENT): Unique identifier for each store
- `AreaId` (FK, INT): References the area where the store is located
- `StoreWorker` (VARCHAR(100)): Name/title of the store attendant or manager
- `Discription` (VARCHAR(255)): Description of the store's inventory or specialization
- `StoreName` (VARCHAR(100)): Official name of the establishment

**Constraints:** 
- Primary Key on StoreId
- Foreign Key on AreaId references Areas(AreaId) with ON DELETE SET NULL
- One store per area possible; many stores can operate in different areas

---

### 3. **Connectors**
**Purpose:** Represents different types of pathways and connections between areas (roads, caves, bridges, etc.).

**Attributes:**
- `ConnectorId` (PK, INT, AUTO_INCREMENT): Unique identifier for each connector type
- `Type` (VARCHAR(50)): Classification of the connector (Road, Cave, Bridge, Tunnel, Ferry, Mountain Pass, etc.)
- `Cost` (INT): Resource cost to traverse (currency units; 0 for free routes)
- `Safety` (INT): Safety rating on scale 1-10 (higher = safer, lower = more dangerous/hazardous)

**Constraints:** Primary Key on ConnectorId; Used to classify routes between areas

---

### 4. **AreasConnections**
**Purpose:** Creates a many-to-many relationship between areas through specific connector types, enabling game world navigation.

**Attributes:**
- `ConnectorId` (FK, INT): References the type of connection
- `Area1` (FK, INT): References the first connected area
- `Area2` (FK, INT): References the second connected area
- `Significance` (VARCHAR(100)): Notes on the connection's importance or characteristics (Main Road, Cave Path, Bridge crossing, etc.)

**Constraints:**
- Composite Primary Key: (ConnectorId, Area1, Area2)
- Foreign Keys: ConnectorId → Connectors(ConnectorId), Area1 → Areas(AreaId), Area2 → Areas(AreaId)
- All relationships cascade delete (ON DELETE CASCADE)
- Bidirectional navigation: Area1 ↔ Area2

---

### 5. **Master** (Game Trainers/Warriors)
**Purpose:** Stores information about game trainers and their battle profiles. Masters serve as key protagonists and opponents, named after ancient Samurai and mythological warriors.

**Attributes:**
- `TrainerId` (PK, INT, AUTO_INCREMENT): Unique identifier for each master/trainer
- `GiveAwayCharm` (FK, INT): References a charm artifact the trainer grants to captured creatures
- `Dialog` (VARCHAR(255)): Iconic dialogue or catchphrase for the master
- `StrongestDino` (INT): Reference to the trainer's strongest creature (denormalized for quick access)
- `DinoCount` (INT): Total number of creatures in the trainer's collection
- `Experience` (INT): Cumulative experience points earned through battles

**Constraints:**
- Primary Key on TrainerId
- Foreign Key on GiveAwayCharm references Charms(CharmId) with ON DELETE SET NULL
- Trainers use ancient Samurai/mythological names reflecting their warrior status

---

### 6. **AreaMasters** (Junction Table)
**Purpose:** Associates trainers with specific areas where they establish their presence/challenges.

**Attributes:**
- `AreaId` (FK, INT): References the area
- `MasterId` (FK, INT): References the trainer/master

**Constraints:**
- Composite Primary Key: (AreaId, MasterId)
- Both fields are Foreign Keys ensuring referential integrity
- Enables many-to-many relationship: Multiple masters can operate in multiple areas

---

### 7. **Charms** (Mystical Artifacts)
**Purpose:** Defines mystical artifacts used to capture, bond with, and enhance creatures.

**Attributes:**
- `CharmId` (PK, INT, AUTO_INCREMENT): Unique identifier for each charm type
- `TimeDuration` (INT): Duration (in seconds/time units) the charm's effect persists
- `BondLevel` (INT): Required bond level between trainer and creature to activate charm
- `CapturingRadiance` (INT): Effectiveness rating for capturing creatures (higher = more effective)

**Constraints:** Primary Key on CharmId; Charms are collectible artifacts with varying efficacy

---

### 8. **ShopCharms** (Store Inventory)
**Purpose:** Links charm artifacts to specific stores, including pricing and rewards.

**Attributes:**
- `ShopId` (FK, INT): References the store selling the charm
- `CharmId` (FK, INT): References the charm artifact
- `Cost` (INT): Purchase price in currency units
- `Experiece` (INT): Experience points gained upon purchase or use
- `Area` (VARCHAR(50)): Regional classification or category

**Constraints:**
- Composite Primary Key: (ShopId, CharmId)
- Foreign Keys ensure store and charm existence
- ON DELETE CASCADE: Removing a store/charm cascades to inventory
- Enables store customization and price variation

---

### 9. **Conditions** (Battle Parameters)
**Purpose:** Defines special battle conditions and restrictions applied to sanctioned matches.

**Attributes:**
- `conditionId` (PK, INT, AUTO_INCREMENT): Unique identifier for each condition set
- `Discription` (VARCHAR(255)): Detailed explanation (No Items, Weather: Rain, Level Cap 50, etc.)
- `MustNotUseCharms` (BOOLEAN): Flag indicating charm usage prohibition in this condition type

**Constraints:** Primary Key on conditionId; Conditions enforce game rules during battles

---

### 10. **BattleSanctum** (Official Battle Arenas)
**Purpose:** Records official battle tournaments and sanctioned matches between trainers.

**Attributes:**
- `BattleNumber` (PK, INT, AUTO_INCREMENT): Unique identifier/tournament number
- `Master1` (FK, INT): References the first participant trainer
- `Master2` (FK, INT): References the second participant trainer
- `Rounds` (INT): Number of battle rounds in the match
- `conditionId` (FK, INT): References the applied battle conditions/rules
- `Location` (FK, INT): References the area/arena where battle occurs

**Constraints:**
- Primary Key on BattleNumber
- Foreign Keys to Master(TrainerId) and Conditions(conditionId) and Areas(AreaId)
- Master1 ≠ Master2 (trainers cannot battle themselves)
- ON DELETE CASCADE for condition/location removal

---

### 11. **Dino** (Creatures)
**Purpose:** Core entity defining all capturable creatures in the game world.

**Attributes:**
- `Dinold` (PK, INT, AUTO_INCREMENT): Unique creature identifier (National Dex equivalent)
- `DinoName` (VARCHAR(100), NOT NULL): Species name of the creature
- `DinoFamily` (VARCHAR(100)): Elemental family/typing (Grass/Poison, Fire, Water/Electric, etc.)

**Constraints:** Primary Key on Dinold; Base entity for all creature-related operations

---

### 12. **Stats** (Creature Attributes)
**Purpose:** Stores individual stat values for each creature type defining combat abilities.

**Attributes:**
- `Dinold` (PK, FK, INT): References the creature; One-to-One relationship
- `Attack` (INT): Offensive capability rating (0-255 scale)
- `Defense` (INT): Defensive capability rating (0-255 scale)
- `Chant` (INT): Special/mystical ability rating (0-255 scale)

**Constraints:**
- Primary Key and Foreign Key both on Dinold
- ON DELETE CASCADE: Removing creature deletes its stats
- Ensures every creature has exactly one stat record

---

### 13. **DinoArea** (Creature Habitats)
**Purpose:** Maps creatures to geographic locations where they naturally appear/can be found.

**Attributes:**
- `AreaId` (FK, INT): References the area
- `Dinold` (FK, INT): References the creature
- `LevelObservable` (INT): Minimum level of creatures typically found in this location

**Constraints:**
- Composite Primary Key: (AreaId, Dinold)
- Both fields are Foreign Keys
- Enables many-to-many: Creatures span multiple habitats; areas contain multiple species
- ON DELETE CASCADE ensures data consistency

---

### 14. **DinoEvo** (Evolutionary Pathways)
**Purpose:** Defines evolution chains and transformation requirements for creature advancement.

**Attributes:**
- `BaseDino` (FK, INT): References the pre-evolution creature
- `EvoDino` (FK, INT): References the post-evolution creature
- `RequiredLevel` (INT): Minimum level threshold for evolution
- `RequiredCharm` (FK, INT): Specific charm artifact required (NULL if level-only evolution)
- `Location` (FK, INT): Geographic area where evolution must occur (NULL if any location)

**Constraints:**
- Composite Primary Key: (BaseDino, EvoDino)
- All fields are Foreign Keys except RequiredLevel
- ON DELETE CASCADE for dino and charm references
- Supports multi-stage evolution chains

---

### 15. **Moves** (Combat Techniques)
**Purpose:** Catalogs available combat abilities/techniques creatures can learn and execute.

**Attributes:**
- `Moveld` (PK, INT, AUTO_INCREMENT): Unique move identifier
- `Discription` (VARCHAR(255)): Move name and flavor description (Tackle, Ember, Solar Beam, etc.)
- `Damage` (INT): Direct damage inflicted (0 for status moves)
- `AddedEffects` (VARCHAR(255)): Secondary effects (Burn, Paralyze, Flinch, Poison, etc.)

**Constraints:** Primary Key on Moveld; Moves are reusable templates for creature abilities

---

### 16. **DinoMoves** (Creature Move Pools)
**Purpose:** Associates specific moves with creature species and defines learning conditions.

**Attributes:**
- `Dinold` (FK, INT): References the creature species
- `Moveld` (FK, INT): References the move technique
- `LevelCap` (INT): Maximum level at which this move can be learned
- `Area` (VARCHAR(50)): Geographic requirement for learning (Any, specific region, etc.)
- `Charms` (FK, INT): Charm item required to teach move (NULL if no charm needed)

**Constraints:**
- Composite Primary Key: (Dinold, Moveld)
- All references are Foreign Keys
- ON DELETE CASCADE for creature, move, and charm removal
- Enables diverse move pools with conditional learning

---

### 17. **MasterMons** (Trainer's Creatures)
**Purpose:** Associates captured creatures with their trainers and stores personal item data.

**Attributes:**
- `Dinold` (FK, INT): References the creature species
- `MasterId` (FK, INT): References the trainer/owner
- `Ropeld` (INT): Personal instance identifier for this specific creature (nickname equivalent)
- `RelicId` (INT): Attached held item/relic identifier (0 if no item)

**Constraints:**
- Composite Primary Key: (Dinold, MasterId, Ropeld)
- Foreign Keys ensure trainer and creature existence
- ON DELETE CASCADE: Removing trainer/creature cascades deletion
- Supports trainer ownership of multiple creatures of same species

---

## Normalization Analysis

---

## Normalization Analysis

### First Normal Form (1NF)
All proposed tables satisfy 1NF because they feature a primary key, and all attributes contain atomic values (no repeating groups or arrays).

### Second Normal Form (2NF)
A table is in 2NF if it is in 1NF and all non-key attributes are fully functionally dependent on the entire primary key.
*   **DinoMoves**: Attributes like LevelCap, Area, and Charms depend completely on the combination of Dinold and Moveld. 
*   **ShopCharms**: Cost and Experience depend on both ShopId and CharmId.
*   The schema effectively satisfies 2NF.

### Third Normal Form (3NF)
A table is in 3NF if it is in 2NF and there are no transitive dependencies (i.e., non-key attributes should not depend on other non-key attributes).
*   **Master**: The attributes `Dialog`, `StrongestDino`, `DinoCount`, and `Experience` relate directly to the `TrainerId`. 
*   **Store**: `StoreWorker`, `Discription`, and `StoreName` relate directly to `StoreId`.
*   The tables appear to be in 3NF. No partial or transitive dependencies are obvious given the domains.

The design is adequately normalized for transactional operations.


