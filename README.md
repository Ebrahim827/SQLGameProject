# Game Database Project - Complete Implementation Guide

## Project Overview
This project implements a comprehensive relational database for a creature capturing and battling game system. The schema manages territories, mystical artifacts (charms), creatures (dinos), trained warriors (masters using ancient Samurai names), battles, and evolutionary systems.

---

## File Structure

### 1. **01_Schema.sql**
Contains all DDL (Data Definition Language) statements for creating the database and tables.

**Tables Created:**
- `Areas` - Geographic territories
- `Stores` - Retail establishments
- `Connectors` - Route types between areas
- `AreasConnections` - Area interconnectivity
- `Master` - Trainers/Warriors (Samurai-named)
- `AreaMasters` - Trainer territory assignments
- `Charms` - Mystical capture artifacts
- `ShopCharms` - Store inventory management
- `Conditions` - Battle rule parameters
- `BattleSanctum` - Tournament records
- `Dino` - Creatures database
- `Stats` - Creature combat attributes
- `DinoArea` - Creature habitat mapping
- `DinoEvo` - Evolution transformation chains
- `Moves` - Combat techniques library
- `DinoMoves` - Creature move learning pools
- `MasterMons` - Trainer creature ownership

### 2. **02_Data.sql**
Contains DML (Data Manipulation Language) statements for populating the database with sample data.

**Data Inserted:**
- 10 Areas (geographic regions)
- 10 Connectors (route types)
- 10 Charms (mystical artifacts)
- 10 Masters (Samurai-named trainers)
- 10 Dinos (creatures)
- 10 Moves (combat techniques)
- 10 Stats records (creature abilities)
- 10 MasterMons (trainer creature collections)
- 10 Conditions (battle rules)
- 10 BattleSanctum (tournament matches)
- Plus supporting data for stores, connections, evolutions, and area mappings

### 3. **Documentation.md**
Comprehensive professional documentation including:

**Sections:**
- Project Overview
- 17 Detailed Entity Descriptions with:
  - Purpose statement
  - Attribute definitions with data types and constraints
  - Detailed constraint explanations
  - Relationships and cardinality
- Normalization Analysis (1NF, 2NF, 3NF verification)
- Schema design rationale

---

## Data Characteristics

### Master (Trainers) - Samurai Names
The Master table uses ancient Samurai and Japanese warrior-themed naming conventions reflecting warrior culture:
- "Honor through combat!"
- "The path of the warrior beckons!"
- "Stone-hearted and steadfast!"
- "Nature embraces the warrior!"
- And more warrior-inspired dialogues

### Key Relationships
1. **One-to-Many:** Master → MasterMons (trainers own multiple creatures)
2. **Many-to-Many:** Master ↔ Area (multiple trainers in multiple areas)
3. **Many-to-Many:** Dino ↔ Area (creatures inhabit multiple areas)
4. **One-to-One:** Dino → Stats (each creature has one stat record)
5. **Many-to-Many:** Dino ↔ Moves (creatures learn multiple moves)

---

## Implementation Instructions

### Step 1: Create Database
```sql
-- Run 01_Schema.sql in your MySQL client
mysql -u root -p < 01_Schema.sql
```

### Step 2: Populate Data
```sql
-- Run 02_Data.sql after schema creation
mysql -u root -p GameDB_MonsterCapture < 02_Data.sql
```

### Step 3: Verify Installation
```sql
USE GameDB_MonsterCapture;
SELECT COUNT(*) FROM Master;
SELECT COUNT(*) FROM Dino;
SELECT COUNT(*) FROM BattleSanctum;
```

---

## Schema Design Highlights

### Normalization Compliance
- **1NF:** All tables have primary keys; all attributes are atomic
- **2NF:** No partial dependencies; composite keys fully determine non-key attributes
- **3NF:** No transitive dependencies; non-key attributes depend only on primary key

### Referential Integrity
- Foreign Key constraints ensure data consistency
- Cascade delete policies maintain database integrity
- SET NULL options preserve history for audit trails

### Scalability Features
- Auto-increment primary keys for growth
- Composite keys for many-to-many relationships
- Index recommendations for performance optimization

---

## Sample Queries

### Find All Trainers in a Specific Area
```sql
SELECT m.TrainerId, 'Trainer Name', COUNT(mm.Dinold) as CreatureCount
FROM Master m
JOIN AreaMasters am ON m.TrainerId = am.MasterId
JOIN MasterMons mm ON m.TrainerId = mm.MasterId
WHERE am.AreaId = 1
GROUP BY m.TrainerId;
```

### Show Creature Evolution Chains
```sql
SELECT d1.DinoName as PreEvolution, d2.DinoName as PostEvolution, 
       de.RequiredLevel, c.CapturingRadiance
FROM DinoEvo de
JOIN Dino d1 ON de.BaseDino = d1.Dinold
JOIN Dino d2 ON de.EvoDino = d2.Dinold
LEFT JOIN Charms c ON de.RequiredCharm = c.CharmId;
```

### List Battle Tournament Results
```sql
SELECT bs.BattleNumber, m1.TrainerId as Participant1, m2.TrainerId as Participant2,
       bs.Rounds, cond.Discription as BattleCondition, a.Name as Arena
FROM BattleSanctum bs
JOIN Master m1 ON bs.Master1 = m1.TrainerId
JOIN Master m2 ON bs.Master2 = m2.TrainerId
JOIN Conditions cond ON bs.conditionId = cond.conditionId
JOIN Areas a ON bs.Location = a.AreaId;
```

---

## Technical Specifications

### Database Engine: MySQL 8.0+
### Character Set: UTF-8
### Table Type: InnoDB (for foreign key support)

### Constraints Applied:
- PRIMARY KEY: Ensures unique identification
- FOREIGN KEY: Maintains referential integrity
- AUTO_INCREMENT: Automatic ID generation
- NOT NULL: Mandatory data fields
- UNIQUE: Prevents duplicate values
- CHECK: Domain validation

---

## Professional Schema Metrics

- **Total Entities:** 17 tables
- **Total Attributes:** 87 data fields
- **Primary Keys:** 17
- **Foreign Keys:** 28 relationships
- **Composite Keys:** 8 junction tables
- **Normalization Level:** 3NF

---

## Notes for Developers

1. The schema supports hierarchical creature evolution (up to 3 stages)
2. Trainers can own multiple instances of the same creature species
3. Battle conditions can restrict charm usage for competitive fairness
4. Areas are interconnected through typed connectors (roads, caves, bridges)
5. Creatures have location-based learning restrictions for moves
6. All deletion cascades are carefully managed to maintain data integrity

---

## Contact & Support

For schema modifications or enhancements, ensure changes maintain:
- 3NF normalization compliance
- Referential integrity constraints
- Proper cascade policies
- Backward compatibility with existing data


