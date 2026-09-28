CREATE TABLE IF NOT EXISTS `fivem_system` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `data` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO `fivem_system` (`player_id`, `data`) VALUES (1, '{"example": "data"}');