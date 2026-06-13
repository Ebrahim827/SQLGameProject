# Schema Summary & Entity Relationship Details

## Complete Entity Catalog

---

## FOUNDATIONAL ENTITIES

### Entity: Areas (AreaId)
**Role:** World map; geographic core

**Columns:**
```
AreaId          INT PK AI
Name            VARCHAR(100) NOT NULL      -- e.g., "Samurai's Peak", "Mystic Valley"
Text            VARCHAR(255)               -- Description
LandScape       VARCHAR(50)                -- Forest, Mountain, City, Plains, Town
Significance    VARCHAR(100)               -- Strategic importance
```

**Cardinality:** 1:N with Store, 1:N with DinoArea, 1:N with AreaMasters

---

### Entity: Connectors (ConnectorId)
**Role:** Route classification system

**Columns:**
```
ConnectorId     INT PK AI
Type            VARCHAR(50)                -- Road, Cave, Bridge, Tunnel, Ferry, etc.
Cost            INT                        -- Travel cost (0 = free)
Safety          INT                        -- 1-10 scale (10 = safest)
```

**Usage:** Connecting Areas via AreasConnections junction table

---

### Entity: Master (TrainerId)
**Role:** Trainer profile with warrior heritage

**Columns:**
```
TrainerId       INT PK AI
GiveAwayCharm   INT FK → Charms             -- Starting gift charm
Dialog          VARCHAR(255)               -- Warrior motto/battle cry
StrongestDino   INT                        -- Denormalized for quick access
DinoCount       INT                        -- Creature collection size
Experience      INT                        -- Battle experience points
```

**Sample Data:** Ancient Samurai warriors with honor-based dialogue
- "Honor through combat!"
- "The path of the warrior beckons!"
- "Stone-hearted and steadfast!"

---

## CREATURE MANAGEMENT ENTITIES

### Entity: Dino (Dinold)
**Role:** Creature species catalog

**Columns:**
```
Dinold          INT PK AI
DinoName        VARCHAR(100) NOT NULL      -- Species name
DinoFamily      VARCHAR(100)               -- Type/element: Grass/Poison, Fire, Water, etc.
```

**Cardinality:** 1:1 with Stats, M:N with Area via DinoArea, M:N with Moves via DinoMoves

---

### Entity: Stats (Dinold)
**Role:** Creature combat attributes

**Columns:**
```
Dinold          INT PK FK → Dino           -- One-to-one
Attack          INT                        -- Offensive power (0-255)
Defense         INT                        -- Defensive power (0-255)
Chant           INT                        -- Special/mystical ability (0-255)
```

**Constraint:** CASCADE delete with Dino

---

### Entity: Moves (Moveld)
**Role:** Combat technique library

**Columns:**
```
Moveld          INT PK AI
Discription     VARCHAR(255)               -- Move name & description
Damage          INT                        -- Damage inflicted (0 for status moves)
AddedEffects    VARCHAR(255)               -- Secondary effects (Burn, Paralyze, Flinch)
```

---

### Entity: DinoMoves (Dinold, Moveld)
**Role:** Creature move learning pools

**Columns:**
```
Dinold          INT FK → Dino
Moveld          INT FK → Moves
LevelCap        INT                        -- Max level to learn move
Area            VARCHAR(50)                -- Location requirement (Any, specific)
Charms          INT FK → Charms            -- Required charm item
```

**Primary Key:** (Dinold, Moveld)

---

## EVOLUTION & HABITAT ENTITIES

### Entity: DinoEvo (BaseDino, EvoDino)
**Role:** Evolution transformation rules

**Columns:**
```
BaseDino        INT FK → Dino              -- Pre-evolution form
EvoDino         INT FK → Dino              -- Post-evolution form
RequiredLevel   INT                        -- Minimum level threshold
RequiredCharm   INT FK → Charms            -- NULL if level-only evolution
Location        INT FK → Areas             -- NULL if any location
```

**Primary Key:** (BaseDino, EvoDino)

**Example Chains:**
- Bulbasaur (Lv 16) → Ivysaur (Lv 32) → Venusaur
- Charmander (Lv 16) → Charmeleon (Lv 36) → Charizard

---

### Entity: DinoArea (AreaId, Dinold)
**Role:** Creature habitat mapping

**Columns:**
```
AreaId          INT FK → Areas
Dinold          INT FK → Dino
LevelObservable INT                        -- Typical encounter level
```

**Primary Key:** (AreaId, Dinold)

**Cardinality:** M:N - Creatures span multiple areas; Areas contain multiple species

---

## TRAINER OWNERSHIP ENTITY

### Entity: MasterMons (Dinold, MasterId, Ropeld)
**Role:** Trainer's captured creatures

**Columns:**
```
Dinold          INT FK → Dino
MasterId        INT FK → Master
Ropeld          INT                        -- Individual creature instance ID
RelicId         INT                        -- Held item identifier (0 = none)
```

**Primary Key:** (Dinold, MasterId, Ropeld)

**Special Feature:** Supports multiple instances of same species per trainer (e.g., 2 Pikachus)

---

## AREA CONNECTION ENTITY

### Entity: AreasConnections (ConnectorId, Area1, Area2)
**Role:** World navigation graph

**Columns:**
```
ConnectorId     INT FK → Connectors
Area1           INT FK → Areas
Area2           INT FK → Areas
Significance    VARCHAR(100)               -- "Main Road", "Cave Path", etc.
```

**Primary Key:** (ConnectorId, Area1, Area2)

**Constraint:** Bidirectional (Area1 ↔ Area2)

---

### Entity: AreaMasters (AreaId, MasterId)
**Role:** Trainer territory assignments

**Columns:**
```
AreaId          INT FK → Areas
MasterId        INT FK → Master
```

**Primary Key:** (AreaId, MasterId)

**Cardinality:** M:N - Multiple trainers per area; trainers in multiple areas

---

## COMMERCE ENTITIES

### Entity: Store (StoreId)
**Role:** Retail establishments

**Columns:**
```
StoreId         INT PK AI
AreaId          INT FK → Areas ON DELETE SET NULL
StoreWorker     VARCHAR(100)               -- Attendant/manager name
Discription     VARCHAR(255)               -- Inventory specialty
StoreName       VARCHAR(100)               -- Official business name
```

---

### Entity: Charms (CharmId)
**Role:** Mystical capture artifacts

**Columns:**
```
CharmId         INT PK AI
TimeDuration    INT                        -- Effect duration (time units)
BondLevel       INT                        -- Required trainer-creature bond
CapturingRadiance INT                      -- Capture effectiveness (higher = better)
```

---

### Entity: ShopCharms (ShopId, CharmId)
**Role:** Store inventory management

**Columns:**
```
ShopId          INT FK → Store
CharmId         INT FK → Charms
Cost            INT                        -- Purchase price
Experiece       INT                        -- XP gained from purchase
Area            VARCHAR(50)                -- Regional category
```

**Primary Key:** (ShopId, CharmId)

---

## BATTLE ENTITIES

### Entity: Conditions (conditionId)
**Role:** Battle rule parameters

**Columns:**
```
conditionId     INT PK AI
Discription     VARCHAR(255)               -- Rule description
MustNotUseCharms BOOLEAN                   -- Charm prohibition flag
```

**Examples:**
- "No Items"
- "Weather: Rain"
- "Level Cap 50"
- "Only Water Types Allowed"

---

### Entity: BattleSanctum (BattleNumber)
**Role:** Tournament records

**Columns:**
```
BattleNumber    INT PK AI
Master1         INT FK → Master
Master2         INT FK → Master
Rounds          INT                        -- Number of battle rounds
conditionId     INT FK → Conditions
Location        INT FK → Areas
```

**Constraint:** Master1 ≠ Master2 (no self-battles)

---

## Relationship Map

```
Areas
├── 1:N → Store
├── 1:N → DinoArea
├── 1:N → AreaMasters
├── 1:N → AreasConnections (Area1 & Area2)
└── 1:N → BattleSanctum (Location)

Master
├── M:N → Areas (via AreaMasters)
├── 1:N → MasterMons
├── 1:N → BattleSanctum (Master1 & Master2)
└── M:1 → Charms (GiveAwayCharm)

Dino
├── 1:1 → Stats
├── M:N → Areas (via DinoArea)
├── M:N → Moves (via DinoMoves)
├── M:N → Master (via MasterMons)
├── 1:N → DinoEvo (BaseDino & EvoDino)
└── M:1 → DinoEvo

Charms
├── M:N → Store (via ShopCharms)
├── M:N → DinoMoves
├── M:1 → Master (GiveAwayCharm)
└── M:1 → DinoEvo (RequiredCharm)

Connectors
└── 1:N → AreasConnections

Store
├── M:N → Charms (via ShopCharms)
└── M:1 → Areas

Conditions
└── 1:N → BattleSanctum
```

---

## Key Metrics

| Metric | Count |
|--------|-------|
| Total Entities | 17 |
| Total Attributes | 87 |
| Primary Keys | 17 |
| Foreign Keys | 28 |
| Composite Keys | 8 |
| One-to-One Relations | 1 |
| One-to-Many Relations | 15 |
| Many-to-Many Relations | 8 |

---

## Data Integrity Features

**Cascade Delete Scenarios:**
- Deleting Area cascades to AreasConnections, Store, AreaMasters, DinoArea
- Deleting Dino cascades to Stats, MasterMons, DinoMoves, DinoEvo
- Deleting Master cascades to MasterMons, BattleSanctum
- Deleting Store cascades to ShopCharms

**Set Null Scenarios:**
- Deleting Charm sets ShopCharms.CharmId to NULL (if allowed)
- Deleting Area sets Store.AreaId to NULL
- Deleting Charm sets Master.GiveAwayCharm to NULL

---

## Sample Statistics

**Expected Data Distribution:**
- Areas: 10-50 (game regions)
- Dinos: 100-300 (creature species)
- Trainers: 50-200 (NPCs and players)
- Moves: 50-150 (combat techniques)
- Stores: 20-100 (retail locations)
- Charms: 10-30 (capture artifacts)
- Battles: Can grow indefinitely (tournament history)


