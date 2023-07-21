<?php

namespace App\Tests;

use App\Entity\Contract;
use App\Repository\ContractRepository;
use Doctrine\ORM\EntityManager;
use Symfony\Bundle\FrameworkBundle\Test\KernelTestCase;

class ContractTest extends KernelTestCase
{
    private ?EntityManager $em;

    private ContractRepository $contractRepo;

    const USER1 = 2;

    CONST MAX_CONTRACTS = 50;

    protected function setUp(): void
    {
        $kernel = self::bootKernel();

        $this->em = $kernel->getContainer()
            ->get('doctrine')
            ->getManager();
        $this->contractRepo = $this->em->getRepository(Contract::class);
    }

    public function testCountContractsAdmin(): void
    {
        $this->assertCount(
            static::MAX_CONTRACTS, 
            $this->contractRepo->getContractsClientsByUser(),
            'It must retrieve all contracts'
        );
    }

    public function testCountContractsUser(): void
    {
        $this->assertLessThan(
            static::MAX_CONTRACTS,
            count($this->contractRepo->getContractsClientsByUser(static::USER1)),
            sprintf("User not admin (id %u) must retrieve less than %u contracts", static::USER1, static::MAX_CONTRACTS)
        );
    }

    public function testDataProperties(): void
    {
        $contracts = $this->contractRepo->getContractsClientsByUser();
        foreach($contracts as $contract) {
            $propsToCheck = [
                'id', 
                'libel', 
                'nature', 
                'clientId', 
                'client_lastname', 
                'client_firstname', 
                'birthday', 
                'user_lastname',
                'user_firstname',
            ];

            $countRequiredProps = count($propsToCheck);

            foreach ($propsToCheck as $prop) {
                $this->assertCount(
                    $countRequiredProps,
                    array_keys($contract),
                    "It should have $countRequiredProps props for contract id {$contract['id']}"
                );

                $this->assertArrayHasKey(
                    $prop, 
                    $contract,
                    "Should not missing prop $prop for contract id {$contract['id']}"
                );

                $this->assertTrue(!empty($contract[$prop]), "Prop $prop should be defined for contract id {$contract['id']}");
            }
        }
    }

    protected function tearDown(): void
    {
        parent::tearDown();
        $this->em->close();
    }
}
