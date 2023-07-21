<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\ExpressionLanguage\Expression;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use App\Entity\User;
use App\Repository\ContractRepository;

#[Route('/contract', name: 'app_contract_')]
class ContractController extends AbstractController
{
    #[Route('/', name: 'list')]
    #[IsGranted(new Expression('is_granted("ROLE_USER")'))]
    public function list(ContractRepository $contractRepo): Response
    {
        $contracts = $contractRepo->getContractsClientsByUser(
            $this->getUserId()
        );

        return $this->render('contract/list.html.twig', [
            'contracts' => $contracts,
        ]);
    }

    #[Route('/{id}', name: 'one', requirements: ['id' => '\d+'])]
    #[IsGranted(new Expression('is_granted("ROLE_USER")'))]
    public function one(int $id, ContractRepository $contractRepo): Response
    {
        $contract = $contractRepo->findOne(
            $id,
            $this->getUserId()
        );

        if (empty($contract)) {
            throw new NotFoundHttpException('Not found');
        }

        return $this->render('contract/contract.html.twig', [
            'contract' => $contract,
        ]);
    }

    private function getUserId():?int
    {
        return $this->isGranted(User::ROLE_ADMIN) ? null : $this->getUser()?->getId();
    }
}
