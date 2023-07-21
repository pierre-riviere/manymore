-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Version du serveur : 8.0.33-0ubuntu0.22.04.2
-- Version de PHP : 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `manymore`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` int NOT NULL,
  `status_id` int NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `status_id`, `lastname`, `firstname`, `birthday`, `user_id`) VALUES
(1, 3, 'Lavoisier', 'Gaston', '1984-07-19', 3),
(2, 1, 'Sabatier', 'Franck', '1950-12-25', 3),
(3, 2, 'Chauvin', 'Alice', '1999-02-04', 5),
(4, 1, 'Hermes', 'Laure', '2001-05-18', 5),
(5, 1, 'Boet', 'Arthur', '1990-10-18', 4),
(8, 3, 'Doris', 'Juan', '1975-06-22', 5);

-- --------------------------------------------------------

--
-- Structure de la table `contract`
--

CREATE TABLE `contract` (
  `id` int NOT NULL,
  `nature_id` int NOT NULL,
  `libel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorisation` double NOT NULL,
  `open_date` date NOT NULL,
  `client_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `contract`
--

INSERT INTO `contract` (`id`, `nature_id`, `libel`, `valorisation`, `open_date`, `client_id`) VALUES
(1, 2, 'Assurance vie A', 1999.99, '2023-07-19', 1),
(2, 1, 'PEE', 2089.9, '2023-07-02', 2),
(3, 3, 'BNP Paris', 300, '2023-07-01', 3),
(4, 1, 'PEL', 2000.1, '2023-07-05', 3),
(5, 1, 'Livret jeune', 12.33, '2023-06-21', 3),
(6, 2, 'Assurance B', 25000, '2023-07-23', 4),
(7, 3, 'Crédit agricole', 652.36, '2021-03-01', 4),
(8, 3, 'Bourso', 123789.33, '2021-03-17', 5);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230719182855', '2023-07-19 18:29:11', 2),
('DoctrineMigrations\\Version20230719183107', '2023-07-19 18:31:27', 159),
('DoctrineMigrations\\Version20230719184005', '2023-07-19 18:40:15', 73),
('DoctrineMigrations\\Version20230719184213', '2023-07-19 18:42:17', 76);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `nature`
--

CREATE TABLE `nature` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `nature`
--

INSERT INTO `nature` (`id`, `name`) VALUES
(1, 'Epargne'),
(2, 'Assurance vie'),
(3, 'Compte Courant');

-- --------------------------------------------------------

--
-- Structure de la table `status`
--

CREATE TABLE `status` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'contact'),
(2, 'prospect'),
(3, 'client');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `lastname`, `firstname`) VALUES
(1, 'admin@mail.com', '[\"ROLE_ADMIN\"]', '$2y$13$RuinS9tg0UdXajGWXcB1jOWzrSmifxNMy/gAdAxgI/EWElv4fdRre', 'AdminLastName', 'AdminFirstName'),
(2, 'pierre.riviere@mail.com', '[\"ROLE_USER\"]', '$2y$13$2FTn.PMiCgTCiSjKgVy0R.JiIYKFmGWseRgCx6ThptJMgu1fmsauW', 'Riviere', 'Pierre'),
(3, 'hugo.lopez@mail.com', '[\"ROLE_USER\"]', '$2y$13$9eO3xS2KWXVV0PMjSDbT9ukW3imy5oYTwWN0HH3AV2rbf8341s8fy', 'Lopez', 'Hugo'),
(4, 'pauline.maudet@mail.com', '[\"ROLE_USER\"]', '$2y$13$zkOTdfCLqkPQwxtvrFhUhOAyhKNJAutqRQ5DrTIxKE/DHColNTO5e', 'Maudet', 'Pauline'),
(5, 'barthelot.marcelin@mail.com', '[\"ROLE_USER\"]', '$2y$13$zkOTdfCLqkPQwxtvrFhUhOAyhKNJAutqRQ5DrTIxKE/DHColNTO5e', 'Barthelot', 'Marcelin');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C74404556BF700BD` (`status_id`),
  ADD KEY `IDX_C7440455A76ED395` (`user_id`);

--
-- Index pour la table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E98F28593BCB2E4B` (`nature_id`),
  ADD KEY `IDX_E98F285919EB6921` (`client_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `nature`
--
ALTER TABLE `nature`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `contract`
--
ALTER TABLE `contract`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `nature`
--
ALTER TABLE `nature`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `status`
--
ALTER TABLE `status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `FK_C74404556BF700BD` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  ADD CONSTRAINT `FK_C7440455A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `contract`
--
ALTER TABLE `contract`
  ADD CONSTRAINT `FK_E98F285919EB6921` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `FK_E98F28593BCB2E4B` FOREIGN KEY (`nature_id`) REFERENCES `nature` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
