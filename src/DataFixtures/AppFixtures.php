<?php

namespace App\DataFixtures;

use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use App\Entity\Client;
use App\Entity\Contract;
use App\Entity\Nature;
use App\Entity\Status;
use App\Entity\User;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Faker;

class AppFixtures extends Fixture
{
    const NATURE_EPARGNE = 'Epargne';
    const NATURE_ASSURANCE_VIE = 'Assurance vie';
    const NATURE_COMPTE_COURANT = 'Compte Courant';

    const STATUS_CONTACT = 'contact';
    const STATUS_PROSPECT = 'prospect';
    const STATUS_CLIENT = 'client';

    private ObjectManager $manager;
    private array $natureObjs = [];
    private array $statusObjs = [];
    private array $userObjs = [];
    private array $clientObjs = [];


    public function __construct(private UserPasswordHasherInterface $passwordEncoder)
    {
        //
    }

    public function load(ObjectManager $manager): void
    {
        $this->manager = $manager;

        $this->loadNatures();
        $this->loadStatus();
        $this->loadUsers();
        $this->loadClients();
        $this->loadContracts();

        $this->manager->flush();
    }

    private function getRandomEntity(array $entities)
    {
        return $entities[random_int(0, count($entities) - 1)];
    }

    private function getFaker(string $locale = 'fr_FR')
    {
        return Faker\Factory::create($locale);
    }

    private function loadNatures()
    {
        foreach([static::NATURE_EPARGNE, static::NATURE_ASSURANCE_VIE, static::NATURE_COMPTE_COURANT] as $name) {
            $nature = new Nature();
            $nature->setName($name);
            $this->manager->persist($nature);
            $this->natureObjs[] = $nature;
        }
    }

    private function loadStatus()
    {
        foreach([static::STATUS_CONTACT, static::STATUS_PROSPECT, static::STATUS_CLIENT] as $name) {
            $status = new status();
            $status->setName($name);
            $this->manager->persist($status);
            $this->statusObjs[] = $status;
        }
    }

    private function loadUsers(string $userPassword = 'password')
    {
        $usersData = [
            [
                'email' => 'admin@mail.com',
                'password' => $userPassword,
                'lastname' => 'AdminLastName',
                'firstname' => 'AdminFirstName',
                'roles' => [User::ROLE_ADMIN],
            ],
            [
                'email' => 'pierre.riviere@mail.com',
                'password' => $userPassword,
                'lastname' => 'Riviere',
                'firstname' => 'Pierre',
                'roles' => [User::ROLE_USER],
            ],
            [
                'email' => 'hugo.lopez@mail.com',
                'password' => $userPassword,
                'lastname' => 'Lopez',
                'firstname' => 'Hugo',
                'roles' => [User::ROLE_USER],
            ],
            [
                'email' => 'pauline.maudet@mail.com',
                'password' => $userPassword,
                'lastname' => 'Maudet',
                'firstname' => 'Pauline',
                'roles' => [User::ROLE_USER],
            ],
            [
                'email' => 'barthelot.marcelin@mail.com',
                'password' => $userPassword,
                'lastname' => 'Barthelot',
                'firstname' => 'Marcelin',
                'roles' => [User::ROLE_USER],
            ]
        ];

        foreach ($usersData as $data) {
            $user = new User();
            $user->setEmail($data['email']);
            $user->setPassword(
                $this->passwordEncoder->hashPassword($user, $data['password'])
            );
            $user->setLastname($data['lastname']);
            $user->setFirstname($data['firstname']);
            $user->setRoles($data['roles']);
            $this->manager->persist($user);

            $this->userObjs[] = $user;
        }
    }

    private function loadClients(int $maxClients = 20, string $maxBirthDate = '2005-01-01')
    {
        for ($i = 0; $i < $maxClients; $i++) {
            $client = new Client();
            $user = $this->getRandomEntity($this->userObjs);
            $client->setUser($user);
            $status = $this->getRandomEntity($this->statusObjs);
            $client->setStatus($status);
            $faker = $this->getFaker();
            $client->setLastname($faker->lastName());
            $client->setFirstname($faker->firstName());
            $client->setBirthday($faker->dateTime($maxBirthDate));
            $this->manager->persist($client);

            $this->clientObjs[] = $client;
        }
    }

    private function loadContracts(int $maxContracts = 50)
    {
        for ($i = 0; $i < $maxContracts; $i++) {
            $contract = new Contract();
            $client = $this->getRandomEntity($this->clientObjs);
            $contract->setClient($client);
            $nature = $this->getRandomEntity($this->natureObjs);
            $contract->setNature($nature);
            $faker = $this->getFaker();
            $contract->setLibel($faker->company());
            $contract->setValorisation($faker->randomFloat(2, 1));
            $contract->setOpenDate($faker->dateTime());
            $this->manager->persist($contract);
        }
    }
}
