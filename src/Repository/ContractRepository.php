<?php

namespace App\Repository;

use App\Entity\Contract;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Contract>
 */
class ContractRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Contract::class);
    }

    public function getContractsClientsByUser(string|int $userId = null): array
    {
        $query = $this->createQueryBuilder('con')
            ->select('
                con.id, 
                con.libel, 
                nat.name AS nature, 
                cli.id AS clientId, 
                cli.lastname As client_lastname, 
                cli.firstname AS client_firstname, 
                cli.birthday, 
                user.lastname AS user_lastname, 
                user.firstname AS user_firstname'
            )
            ->join('con.client', 'cli')
            ->join('con.nature', 'nat')
            ->join('cli.user', 'user');
            
        if (!empty($userId)) {
            $query
                ->where('cli.user = :userId')
                ->setParameter('userId', $userId);
        }
        
        return $query
            ->orderBy('cli.lastname')
            ->addOrderBy('cli.firstname')
            ->addOrderBy('con.libel')
            ->getQuery()
            ->getResult();
    }

    public function findOne(string|int $id, string|int $userId = null): ?array
    {
        $query = $this->createQueryBuilder('con')
            ->select('con.id, con.libel, con.valorisation, con.open_date, cli.lastname AS client_lastname, cli.firstname AS client_firstname, nat.name AS nature')
            ->join('con.client', 'cli')
            ->join('con.nature', 'nat')
            ->andWhere('con.id = :id');
        
        if (!empty($userId)) {
            $query
                ->andWhere('cli.user = :userId')
                ->setParameter('userId', $userId);
        }

        return $query
            ->setParameter('id', $id)
            ->getQuery()
            ->getOneOrNullResult();
    }
}
