-- Verification & Testing Script
-- Run this after importing 01_Schema.sql and 02_Data.sql

USE GameDB_MonsterCapture;

-- ============================================================
-- SECTION 1: TABLE COUNTS
-- ============================================================
SELECT '=== TABLE RECORD COUNTS ===' AS Section;

SELECT 'Areas' as TableName, COUNT(*) as RecordCount FROM Areas
UNION ALL
SELECT 'Store', COUNT(*) FROM Store
UNION ALL
SELECT 'Connectors', COUNT(*) FROM Connectors
UNION ALL
SELECT 'AreasConnections', COUNT(*) FROM AreasConnections
UNION ALL
SELECT 'Master', COUNT(*) FROM Master
UNION ALL
SELECT 'AreaMasters', COUNT(*) FROM AreaMasters
UNION ALL
SELECT 'Charms', COUNT(*) FROM Charms
UNION ALL
SELECT 'ShopCharms', COUNT(*) FROM ShopCharms
UNION ALL
SELECT 'Conditions', COUNT(*) FROM Conditions
UNION ALL
SELECT 'BattleSanctum', COUNT(*) FROM BattleSanctum
UNION ALL
SELECT 'Dino', COUNT(*) FROM Dino
UNION ALL
SELECT 'Stats', COUNT(*) FROM Stats
UNION ALL
SELECT 'DinoArea', COUNT(*) FROM DinoArea
UNION ALL
SELECT 'DinoEvo', COUNT(*) FROM DinoEvo
UNION ALL
SELECT 'Moves', COUNT(*) FROM Moves
UNION ALL
SELECT 'DinoMoves', COUNT(*) FROM DinoMoves
UNION ALL
SELECT 'MasterMons', COUNT(*) FROM MasterMons;

-- ============================================================
-- SECTION 2: DATA INTEGRITY TESTS
-- ============================================================
SELECT '\n=== DATA INTEGRITY CHECKS ===' AS Section;

-- Verify all trainers have valid charms
SELECT m.TrainerId, m.Dialog, c.CharmId, c.CapturingRadiance
FROM Master m
LEFT JOIN Charms c ON m.GiveAwayCharm = c.CharmId
ORDER BY m.TrainerId;

-- Verify all creatures have stats
SELECT d.Dinold, d.DinoName, s.Attack, s.Defense, s.Chant
FROM Dino d
LEFT JOIN Stats s ON d.Dinold = s.Dinold
ORDER BY d.Dinold;

-- ============================================================
-- SECTION 3: RELATIONSHIP VERIFICATION
-- ============================================================
SELECT '\n=== RELATIONSHIP VERIFICATION ===' AS Section;

-- Show trainers in their territories
SELECT m.TrainerId, m.Dialog, GROUP_CONCAT(a.Name SEPARATOR ', ') as Areas
FROM Master m
JOIN AreaMasters am ON m.TrainerId = am.MasterId
JOIN Areas a ON am.AreaId = a.AreaId
GROUP BY m.TrainerId
ORDER BY m.TrainerId;

-- Show creatures in their habitats
SELECT d.DinoName, GROUP_CONCAT(a.Name SEPARATOR ', ') as Habitats
FROM Dino d
JOIN DinoArea da ON d.Dinold = da.Dinold
JOIN Areas a ON da.AreaId = a.AreaId
GROUP BY d.DinoName
ORDER BY d.DinoName;

-- ============================================================
-- SECTION 4: COMPLEX QUERIES
-- ============================================================
SELECT '\n=== COMPLEX DATA QUERIES ===' AS Section;

-- Evolution Chains
SELECT
    d1.DinoName as 'Pre-Evolution',
    d2.DinoName as 'Post-Evolution',
    de.RequiredLevel as 'Level Required'
FROM DinoEvo de
JOIN Dino d1 ON de.BaseDino = d1.Dinold
JOIN Dino d2 ON de.EvoDino = d2.Dinold
ORDER BY d1.DinoName;

-- Trainer Battle Statistics
SELECT
    m.TrainerId,
    m.Dialog as 'Trainer',
    COUNT(DISTINCT bs.BattleNumber) as 'Battles Participated',
    m.DinoCount as 'Team Size',
    m.Experience as 'Experience'
FROM Master m
LEFT JOIN BattleSanctum bs ON m.TrainerId = bs.Master1 OR m.TrainerId = bs.Master2
GROUP BY m.TrainerId
ORDER BY m.Experience DESC;

-- Store Inventory Analysis
SELECT
    s.StoreName,
    s.StoreWorker,
    a.Name as 'Location',
    COUNT(sc.CharmId) as 'Charms Sold'
FROM Store s
LEFT JOIN ShopCharms sc ON s.StoreId = sc.ShopId
LEFT JOIN Areas a ON s.AreaId = a.AreaId
GROUP BY s.StoreId
ORDER BY 'Charms Sold' DESC;

-- ============================================================
-- SECTION 5: CONSTRAINT VALIDATION
-- ============================================================
SELECT '\n=== CONSTRAINT VALIDATION ===' AS Section;

-- Verify no self-battles
SELECT COUNT(*) as 'Self-Battles (Should be 0)'
FROM BattleSanctum
WHERE Master1 = Master2;

-- Verify no orphaned battle conditions
SELECT COUNT(*) as 'Orphaned Conditions (Should be 0)'
FROM BattleSanctum bs
WHERE bs.conditionId NOT IN (SELECT conditionId FROM Conditions);

-- Verify no orphaned creature stats
SELECT COUNT(*) as 'Orphaned Stats (Should be 0)'
FROM Stats s
WHERE s.Dinold NOT IN (SELECT Dinold FROM Dino);

-- ============================================================
-- SECTION 6: SAMPLE INSIGHTS
-- ============================================================
SELECT '\n=== BUSINESS INSIGHTS ===' AS Section;

-- Strongest creatures by stats
SELECT
    d.DinoName,
    s.Attack,
    s.Defense,
    s.Chant,
    (s.Attack + s.Defense + s.Chant) as 'Total Stats'
FROM Dino d
JOIN Stats s ON d.Dinold = s.Dinold
ORDER BY 'Total Stats' DESC
LIMIT 5;

-- Most experienced trainers
SELECT
    TrainerId,
    Dialog,
    Experience,
    DinoCount
FROM Master
ORDER BY Experience DESC
LIMIT 5;

-- Safest travel routes
SELECT
    c.Type as 'Route Type',
    c.Safety as 'Safety Rating',
    COUNT(ac.ConnectorId) as 'Usage Count'
FROM Connectors c
LEFT JOIN AreasConnections ac ON c.ConnectorId = ac.ConnectorId
GROUP BY c.ConnectorId
ORDER BY c.Safety DESC;

-- ============================================================
-- SECTION 7: SCHEMA SUMMARY
-- ============================================================
SELECT '\n=== SCHEMA SUMMARY ===' AS Section;

SELECT
    'Total Trainers' as Metric, COUNT(*) as Value FROM Master
UNION ALL
SELECT 'Total Creatures', COUNT(*) FROM Dino
UNION ALL
SELECT 'Total Moves', COUNT(*) FROM Moves
UNION ALL
SELECT 'Total Areas', COUNT(*) FROM Areas
UNION ALL
SELECT 'Total Stores', COUNT(*) FROM Store
UNION ALL
SELECT 'Total Charms', COUNT(*) FROM Charms
UNION ALL
SELECT 'Total Battles Recorded', COUNT(*) FROM BattleSanctum
UNION ALL
SELECT 'Total Evolution Paths', COUNT(*) FROM DinoEvo
UNION ALL
SELECT 'Total Battle Conditions', COUNT(*) FROM Conditions
UNION ALL
SELECT 'Total Creature Habitat Mappings', COUNT(*) FROM DinoArea;

-- ============================================================
-- END OF VERIFICATION
-- ============================================================
SELECT '\n=== VERIFICATION COMPLETE ===' AS Status;

